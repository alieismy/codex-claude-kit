[CmdletBinding()]
param(
    [ValidateSet("en", "zh-CN")]
    [string]$Language = "en",

    [string]$OutputRoot = (Join-Path (Split-Path -Parent $PSScriptRoot) ".tmp/local/claude-ai-skills"),

    # Package only Skills that are missing from, or differ from, the copies synced from claude.ai.
    [switch]$Changed,

    [string]$SyncedRoot,

    [switch]$AllowDirty
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$sourceRelative = if ($Language -eq "zh-CN") {
    "zh-CN/skills"
}
else {
    "skills"
}
$sourceRoot = [System.IO.Path]::GetFullPath((Join-Path $repoRoot $sourceRelative))

$skillNames = @(
    "rd-requirement",
    "rd-feasibility",
    "rd-research",
    "rd-solution",
    "rd-design",
    "rd-specification",
    "rd-writing",
    "rd-review",
    "rd-delivery"
)

# Repository-only material: eval definitions and Codex desktop metadata are not used at runtime by Claude.
$excludedTopLevel = @("evals", "agents")

# claude.ai re-serializes SKILL.md frontmatter on upload (observed 2026-10-09: folded descriptions became
# single-line scalars), so metadata is compared by value and the body byte for byte. Forms this reader does
# not understand return $null, which the caller treats as a difference rather than risk a missed upload.
function Get-SkillFingerprint {
    param([Parameter(Mandatory)][string]$Path)

    $match = [regex]::Match([System.IO.File]::ReadAllText($Path), "(?s)\A---\r?\n(?<fm>.*?)\r?\n---\r?\n(?<body>.*)\z")
    if (-not $match.Success) {
        return $null
    }

    $fields = [ordered]@{}
    $key = $null
    foreach ($line in $match.Groups["fm"].Value -split "\r?\n") {
        $keyMatch = [regex]::Match($line, "^(?<key>[A-Za-z0-9_-]+):(?:\s+(?<rest>.*))?$")
        if ($keyMatch.Success) {
            $key = $keyMatch.Groups["key"].Value
            $fields[$key] = [pscustomobject]@{ Rest = $keyMatch.Groups["rest"].Value.TrimEnd(); Lines = [System.Collections.Generic.List[string]]::new() }
        }
        elseif ($key -and $line -match "^\s+\S") {
            $fields[$key].Lines.Add($line.Trim())
        }
        else {
            return $null
        }
    }

    $canonical = [System.Collections.Generic.List[string]]::new()
    foreach ($name in $fields.Keys | Sort-Object) {
        $rest = $fields[$name].Rest
        $lines = $fields[$name].Lines
        if ($rest -match "^>-?$") {
            $value = $lines -join " "
        }
        elseif ($rest -match "^'(?<inner>.*)'$" -and $lines.Count -eq 0) {
            $value = $Matches["inner"].Replace("''", "'")
        }
        elseif ($rest -match '^"(?<inner>[^"\\]*)"$' -and $lines.Count -eq 0) {
            $value = $Matches["inner"]
        }
        elseif ($rest -and $rest -notmatch "^[>|'`"]") {
            $value = (@($rest) + $lines) -join " "
        }
        else {
            return $null
        }
        $canonical.Add("$name=$value")
    }

    $text = ($canonical -join "`n") + "`n---`n" + $match.Groups["body"].Value
    return [Convert]::ToHexString([System.Security.Cryptography.SHA256]::HashData([System.Text.Encoding]::UTF8.GetBytes($text)))
}

function Get-PayloadManifest {
    param([Parameter(Mandatory)][string]$Root)

    $manifest = @{}
    foreach ($file in Get-ChildItem -LiteralPath $Root -Recurse -File -Force) {
        $relative = $file.FullName.Substring($Root.Length).TrimStart('\', '/').Replace('\', '/')
        if ($excludedTopLevel -contains $relative.Split('/')[0]) {
            continue
        }
        $fileHash = (Get-FileHash -Algorithm SHA256 -LiteralPath $file.FullName).Hash
        $fingerprint = if ($relative -eq "SKILL.md") { Get-SkillFingerprint -Path $file.FullName } else { $null }
        $manifest[$relative] = if ($fingerprint) { "meta:$fingerprint" } else { $fileHash }
    }
    return $manifest
}

function Test-SameManifest {
    param(
        [Parameter(Mandatory)][hashtable]$Expected,
        [Parameter(Mandatory)][hashtable]$Actual
    )

    if ($Expected.Count -ne $Actual.Count) {
        return $false
    }
    foreach ($relative in $Expected.Keys) {
        if (-not $Actual.ContainsKey($relative) -or $Actual[$relative] -ne $Expected[$relative]) {
            return $false
        }
    }
    return $true
}

function Resolve-SyncedRoot {
    $configDir = if ($env:CLAUDE_CONFIG_DIR) {
        $env:CLAUDE_CONFIG_DIR
    }
    else {
        Join-Path ([Environment]::GetFolderPath("UserProfile")) ".claude"
    }
    $syncedParent = Join-Path $configDir "skills/synced"
    $buckets = @(Get-ChildItem -LiteralPath $syncedParent -Directory -ErrorAction SilentlyContinue |
        Where-Object { -not $_.Name.StartsWith(".") })
    if ($buckets.Count -eq 0) {
        throw "No claude.ai-synced Skills found under $syncedParent. Sign in to Claude Code with your Claude account and keep skill sync on, or omit -Changed to package every Skill."
    }
    if ($buckets.Count -gt 1) {
        throw "Several synced Skill sets exist under $syncedParent; pass -SyncedRoot with the one for the target account: $($buckets.FullName -join ', ')"
    }
    return $buckets[0].FullName
}

foreach ($name in $skillNames) {
    $skillFile = Join-Path $sourceRoot "$name/SKILL.md"
    if (-not (Test-Path -LiteralPath $skillFile -PathType Leaf)) {
        throw "Missing source Skill: $skillFile"
    }
    # claude.ai requires the archive's top-level folder to match the frontmatter name.
    if ((Get-Content -LiteralPath $skillFile -Raw) -notmatch "(?m)^name:\s*$([regex]::Escape($name))\s*$") {
        throw "Frontmatter name does not match its folder: $skillFile"
    }
}

$commit = (git -C $repoRoot rev-parse HEAD).Trim()
$dirty = @(git -C $repoRoot status --porcelain -- $sourceRelative)
if ($LASTEXITCODE -ne 0) {
    throw "git status failed for $sourceRelative"
}
if ($dirty.Count -gt 0 -and -not $AllowDirty) {
    throw "Uncommitted changes under $sourceRelative; commit them so the upload is traceable, or pass -AllowDirty for a trial package:`n$($dirty -join "`n")"
}

$selected = [System.Collections.Generic.List[object]]::new()
$syncedPath = $null
if ($Changed) {
    $syncedPath = if ($SyncedRoot) { (Resolve-Path -LiteralPath $SyncedRoot).Path } else { Resolve-SyncedRoot }
}
foreach ($name in $skillNames) {
    $payload = Get-PayloadManifest -Root (Join-Path $sourceRoot $name)
    $status = "packaged"
    if ($Changed) {
        $syncedSkill = Join-Path $syncedPath $name
        $status = if (-not (Test-Path -LiteralPath $syncedSkill -PathType Container)) {
            "missing"
        }
        elseif (Test-SameManifest -Expected $payload -Actual (Get-PayloadManifest -Root $syncedSkill)) {
            "current"
        }
        else {
            "changed"
        }
    }
    Write-Host ("{0,-17} {1}" -f $name, $status)
    if ($status -ne "current") {
        $selected.Add([pscustomobject]@{ Name = $name; Status = $status; Payload = $payload })
    }
}

$outputDir = Join-Path ([System.IO.Path]::GetFullPath($OutputRoot)) $Language
[System.IO.Directory]::CreateDirectory($outputDir) | Out-Null
# Clear only this script's own outputs so a stale archive is never mistaken for a pending upload.
foreach ($name in $skillNames) {
    Remove-Item -LiteralPath (Join-Path $outputDir "$name.zip") -Force -ErrorAction SilentlyContinue
}
Remove-Item -LiteralPath (Join-Path $outputDir "manifest.json") -Force -ErrorAction SilentlyContinue

Add-Type -AssemblyName System.IO.Compression, System.IO.Compression.FileSystem
$fixedTime = [DateTimeOffset]::new(2000, 1, 1, 0, 0, 0, [TimeSpan]::Zero)
$archives = foreach ($skill in $selected) {
    $zipPath = Join-Path $outputDir "$($skill.Name).zip"
    $skillRoot = Join-Path $sourceRoot $skill.Name
    $stream = [System.IO.File]::Open($zipPath, [System.IO.FileMode]::CreateNew)
    try {
        $zip = [System.IO.Compression.ZipArchive]::new($stream, [System.IO.Compression.ZipArchiveMode]::Create)
        try {
            foreach ($relative in $skill.Payload.Keys | Sort-Object -CaseSensitive) {
                # claude.ai looks for <skill-name>/SKILL.md, so every entry sits under the Skill folder.
                $entry = $zip.CreateEntry("$($skill.Name)/$relative", [System.IO.Compression.CompressionLevel]::Optimal)
                $entry.LastWriteTime = $fixedTime
                $entryStream = $entry.Open()
                try {
                    $bytes = [System.IO.File]::ReadAllBytes((Join-Path $skillRoot $relative))
                    $entryStream.Write($bytes, 0, $bytes.Length)
                }
                finally {
                    $entryStream.Dispose()
                }
            }
        }
        finally {
            $zip.Dispose()
        }
    }
    finally {
        $stream.Dispose()
    }

    $verify = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
    try {
        $entryNames = @($verify.Entries | ForEach-Object { $_.FullName })
        if ($entryNames.Count -ne $skill.Payload.Count -or
            @($entryNames | Where-Object { -not $_.StartsWith("$($skill.Name)/") }).Count -gt 0 -or
            $entryNames -notcontains "$($skill.Name)/SKILL.md") {
            throw "Archive layout verification failed: $zipPath"
        }
    }
    finally {
        $verify.Dispose()
    }

    [pscustomobject]@{
        skill = $skill.Name
        status = $skill.Status
        archive = "$($skill.Name).zip"
        sha256 = (Get-FileHash -Algorithm SHA256 -LiteralPath $zipPath).Hash
        files = $skill.Payload.Count
    }
}

$manifest = [ordered]@{
    language = $Language
    source = $sourceRelative
    commit = $commit
    uncommittedChanges = ($dirty.Count -gt 0)
    mode = if ($Changed) { "changed" } else { "all" }
    archives = @($archives)
}
[System.IO.File]::WriteAllText(
    (Join-Path $outputDir "manifest.json"),
    (($manifest | ConvertTo-Json -Depth 4) -replace "`r`n", "`n") + "`n",
    [System.Text.UTF8Encoding]::new($false)
)

if ($selected.Count -eq 0) {
    Write-Host "Local synced copies match all nine $Language RD Skills from $sourceRelative; no archives selected. Current claude.ai state depends on the last successful sync." -ForegroundColor Green
    exit 0
}

Write-Host "Packaged $($selected.Count) $Language RD Skill archive(s) in $outputDir" -ForegroundColor Green
Write-Host "Upload each archive at claude.ai Customize > Skills, replacing any older copy of the same Skill."
Write-Host "After Claude Code syncs, rerun with -Changed to compare the source with the local last-synced copies."
