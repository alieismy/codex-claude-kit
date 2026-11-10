[CmdletBinding()]
param(
    [ValidateRange(1, 120)]
    [int]$StrictLoadTimeoutSeconds = 15
)

$ErrorActionPreference = "Stop"

$root = Resolve-Path (Join-Path $PSScriptRoot "..")
$metadataPath = Join-Path $root "schemas/codex-config.schema.meta.json"
$snapshotPath = Join-Path $root "schemas/codex-config.schema.json"
$validatorPath = Join-Path $root "scripts/validate-codex-configs.py"
$configPaths = @(
    "codex/examples/config.example.toml",
    "codex/examples/config.full-access.example.toml",
    "zh-CN/codex/examples/config.example.toml",
    "zh-CN/codex/examples/config.full-access.example.toml",
    "codex/examples/config.project.example.toml",
    "zh-CN/codex/examples/config.project.example.toml"
)

function Get-Sha256 {
    param([string]$Path)

    return (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash.ToUpperInvariant()
}

# Some platforms ship only python3, while Windows may expose a non-functional python3 alias; probe each candidate.
function Get-PythonCommand {
    foreach ($name in @("python", "python3")) {
        $command = Get-Command $name -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($command) {
            & $command.Source -c "import sys; sys.exit(0 if sys.version_info >= (3, 9) else 1)" 2>$null
            if ($LASTEXITCODE -eq 0) {
                return $command
            }
        }
    }
    return $null
}

function Start-CodexStrictLoad {
    param(
        [string]$CodexPath,
        [string]$CodexHome,
        [int]$TimeoutSeconds
    )

    $startInfo = [System.Diagnostics.ProcessStartInfo]::new()
    $startInfo.UseShellExecute = $false
    $startInfo.RedirectStandardInput = $true
    $startInfo.RedirectStandardOutput = $true
    $startInfo.RedirectStandardError = $true
    $startInfo.CreateNoWindow = $true
    $startInfo.Environment["CODEX_HOME"] = $CodexHome
    $startInfo.WorkingDirectory = $CodexHome

    if ($CodexPath.EndsWith(".cmd", [System.StringComparison]::OrdinalIgnoreCase) -or
        $CodexPath.EndsWith(".bat", [System.StringComparison]::OrdinalIgnoreCase)) {
        $startInfo.FileName = $env:ComSpec
        $startInfo.ArgumentList.Add("/d")
        $startInfo.ArgumentList.Add("/s")
        $startInfo.ArgumentList.Add("/c")
        $commandLine = "`"$CodexPath`" app-server --strict-config --listen stdio://"
        $startInfo.ArgumentList.Add('"' + $commandLine + '"')
    }
    elseif ($CodexPath.EndsWith(".ps1", [System.StringComparison]::OrdinalIgnoreCase)) {
        $startInfo.FileName = (Get-Command pwsh -ErrorAction Stop).Source
        foreach ($argument in @(
            "-NoProfile",
            "-NonInteractive",
            "-File",
            $CodexPath,
            "app-server",
            "--strict-config",
            "--listen",
            "stdio://"
        )) {
            $startInfo.ArgumentList.Add($argument)
        }
    }
    else {
        $startInfo.FileName = $CodexPath
        foreach ($argument in @("app-server", "--strict-config", "--listen", "stdio://")) {
            $startInfo.ArgumentList.Add($argument)
        }
    }

    $process = [System.Diagnostics.Process]::new()
    $process.StartInfo = $startInfo
    if (-not $process.Start()) {
        throw "Unable to start Codex strict-load process."
    }

    # Drain both pipes while waiting; reading only after exit can deadlock once a full pipe blocks the child.
    $stdoutTask = $process.StandardOutput.ReadToEndAsync()
    $stderrTask = $process.StandardError.ReadToEndAsync()
    $process.StandardInput.Close()
    if (-not $process.WaitForExit($TimeoutSeconds * 1000)) {
        $process.Kill($true)
        $process.WaitForExit()
        throw "Codex strict-load timed out after $TimeoutSeconds seconds."
    }

    $stdout = $stdoutTask.GetAwaiter().GetResult().Trim()
    $stderr = $stderrTask.GetAwaiter().GetResult().Trim()
    if ($process.ExitCode -ne 0) {
        $diagnostic = (@($stderr, $stdout) | Where-Object { $_ }) -join "`n"
        throw "Codex strict-load exited with code $($process.ExitCode): $diagnostic"
    }
}

if (-not (Test-Path -LiteralPath $metadataPath)) {
    throw "Missing Codex schema metadata: $metadataPath"
}
if (-not (Test-Path -LiteralPath $snapshotPath)) {
    throw "Missing Codex schema snapshot: $snapshotPath"
}
if (-not (Test-Path -LiteralPath $validatorPath)) {
    throw "Missing Codex config validator: $validatorPath"
}

$metadata = Get-Content -LiteralPath $metadataPath -Raw | ConvertFrom-Json
$snapshot = Get-Item -LiteralPath $snapshotPath
if ($snapshot.Length -ne [long]$metadata.byte_length) {
    throw "Tracked schema byte length differs from metadata."
}
$snapshotHash = Get-Sha256 -Path $snapshotPath
if ($snapshotHash -cne ([string]$metadata.sha256).ToUpperInvariant()) {
    throw "Tracked schema SHA-256 differs from metadata."
}

$python = Get-PythonCommand
if (-not $python) {
    throw "Python 3.9+ is required as 'python' or 'python3'."
}
$codex = Get-Command codex -ErrorAction Stop
$codexVersionOutput = (& $codex.Source --version 2>&1 | Out-String).Trim()
if ($LASTEXITCODE -ne 0) {
    throw "Unable to read Codex version: $codexVersionOutput"
}
$versionMatch = [regex]::Match($codexVersionOutput, '(?<version>[0-9]+\.[0-9]+\.[0-9]+(?:-[0-9A-Za-z.-]+)?)')
if (-not $versionMatch.Success -or $versionMatch.Groups['version'].Value -cne [string]$metadata.source_version) {
    throw "Installed Codex version '$codexVersionOutput' does not match schema version $($metadata.source_version)."
}

$systemTempRoot = [System.IO.Path]::GetFullPath([System.IO.Path]::GetTempPath()).TrimEnd(
    [System.IO.Path]::DirectorySeparatorChar,
    [System.IO.Path]::AltDirectorySeparatorChar
)
$runRootPrefix = "codex-claude-kit-release-"
$runRoot = Join-Path $systemTempRoot ($runRootPrefix + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $runRoot | Out-Null

try {
    $liveSchemaPath = Join-Path $runRoot "live-config.schema.json"
    Invoke-WebRequest -Uri $metadata.live_source_url -OutFile $liveSchemaPath

    $liveHash = Get-Sha256 -Path $liveSchemaPath
    if ($liveHash -cne $snapshotHash) {
        throw "Official live Codex schema has drifted from the tracked $($metadata.source_version) snapshot."
    }

    & $python.Source -X utf8 $validatorPath --schema $liveSchemaPath
    if ($LASTEXITCODE -ne 0) {
        throw "Codex examples failed validation against the live schema."
    }

    foreach ($relativePath in $configPaths) {
        $sourcePath = Join-Path $root $relativePath
        $safeName = ($relativePath -replace '[^A-Za-z0-9.-]', '-')
        $isolatedHome = Join-Path $runRoot $safeName
        New-Item -ItemType Directory -Path $isolatedHome | Out-Null
        Copy-Item -LiteralPath $sourcePath -Destination (Join-Path $isolatedHome "config.toml")
        Start-CodexStrictLoad -CodexPath $codex.Source -CodexHome $isolatedHome -TimeoutSeconds $StrictLoadTimeoutSeconds
        Write-Host "Codex strict-load passed: $relativePath" -ForegroundColor Green
    }

    Write-Host "Release validation passed (live schema, Codex $($metadata.source_version), $($configPaths.Count) strict-loads)." -ForegroundColor Green
}
finally {
    $resolvedRunRoot = [System.IO.Path]::GetFullPath($runRoot)
    $expectedPrefix = $systemTempRoot + [System.IO.Path]::DirectorySeparatorChar
    $leaf = Split-Path -Leaf $resolvedRunRoot
    $isWithinTemp = $resolvedRunRoot.StartsWith($expectedPrefix, [System.StringComparison]::OrdinalIgnoreCase)
    if (-not $isWithinTemp -or -not $leaf.StartsWith($runRootPrefix)) {
        throw "Refusing to remove an unverified temporary path: $resolvedRunRoot"
    }
    if (Test-Path -LiteralPath $resolvedRunRoot) {
        Remove-Item -LiteralPath $resolvedRunRoot -Recurse -Force
    }
}
