# 安装说明

codex-claude-kit 提供配置、规则、指令、提示词与 Skills 模板，以 Codex 和 Claude Code 为主要入口，同时覆盖 Claude 网页版／桌面版适用的指令与 Skills，以及 ChatGPT 网页版专用指令。请审阅并合并到目标作用域，不要盲目覆盖已有文件。

<a id="source-and-destination-map"></a>

## 源与安装目标映射

规则、settings/MCP 和 Skills 分别选择。源模板不活动；安装时去掉 `.template` 后缀，已有目标先做可验证备份再合并。中文通常使用下表源路径前加 `zh-CN/`；Claude 账户指令指南直接使用所链接的共用英文版文档（无中文版指令正文）。不要递归复制源适配目录，也不要把账号同步缓存作为源。

| 载体 | 源 | 原生安装目标 |
|---|---|---|
| 共享项目规则 | `rules/project/AGENTS.md.template` | `{project}/AGENTS.md` |
| Codex 全局规则 | `codex/global/AGENTS.md.template` | `{CODEX_HOME}/AGENTS.md` （默认 `~/.codex`） |
| Codex 用户配置 | `codex/examples/config.example.toml` | `{CODEX_HOME}/config.toml` |
| Codex 项目配置 | `codex/project/config.example.toml` | `{project}/.codex/config.toml` （受信任项目） |
| Claude 全局/项目规则 | `claude/{global,project}/CLAUDE.md.template` | `~/.claude/CLAUDE.md`; `{project}/CLAUDE.md` |
| Claude 用户/项目 settings | `claude/{global,project}/settings.example.json` | `~/.claude/settings.json`; `{project}/.claude/settings.json` |
| Claude 项目 MCP | `claude/project/mcp.example.json` | `{project}/.mcp.json` |
| Claude Code 提示词 | `claude/project/PROMPTS.md` | 选用任务启动提示词；不是常驻规则 |
| Claude 账户指令 | [Claude 账户指令指南](../../docs/claude-personalized-instructions.md) | Claude 网页版／桌面版账户自定义指令 |
| ChatGPT 网页版专用指令 | `docs/personalized-custom-instructions.md` | ChatGPT 网页版自定义指令 |
| 本地共享 Skills | `skills/rd-*` | 所选用户/项目 Skill 根 |
| Claude 账号 Skills | `skills/rd-*`, 通过上传打包脚本 | claude.ai Customize → Skills；Code 接收账号同步 |

Claude 用户/local MCP 在 `~/.claude.json`，用 `claude mcp add --scope user` 或 `--scope local` 管理，不是 settings JSON 中的服务器定义。settings 与 MCP 的作用域和存储位置须分别选择，见 [Claude 适配说明](../claude/README.md)。源目录迁移不会更新个人安装，见[布局迁移](layout-migration.md)。

## Codex 规则

安装全局规则：

```bash
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -s "$codex_home/AGENTS.override.md" ] && [ ! -e "$codex_home/AGENTS.md" ]; then
  cp zh-CN/codex/global/AGENTS.md.template "$codex_home/AGENTS.md"
fi
```

安装项目规则：

```bash
if [ ! -s /path/to/your-project/AGENTS.override.md ] && [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp zh-CN/rules/project/AGENTS.md.template /path/to/your-project/AGENTS.md
fi
```

如同一层级存在非空 `AGENTS.override.md`，它是当前生效的指令来源；应先创建独立备份并有意识地合并，不要创建不会生效的 `AGENTS.md`。如已有 `AGENTS.md`，也应先备份，再只合并需要的章节，并保留现有个人或项目特定约束；不得直接替换个人全局文件。模板包含角色、语言、推理深度、授权和交付纪律等观点化默认值，应按实际用户、团队与仓库调整；`zh-CN/` 全局模板有意默认使用简体中文。

Codex 加载全局和适用的项目 `AGENTS.md` 规则链，这一过程不依赖是否选中 Skill。因此，全局 v7.8 模板把真实性纪律、响应模式、价值优先执行、上下文健康、执行效率与上下文卫生、输出前审核、输出规则、证据状态边界、“无需修改”合法性、有边界的实现纪律、既有行为与指令面保护、验证失败归因和精简的 RD 交付基线作为常驻能力：未触发 RD Skill 时仍然生效；触发匹配 Skill 后，只叠加完整专业工作流；上述控制规则仍由全局模板常驻提供，不以 Skill 作为唯一来源。

Codex 在每次运行开始时发现一次指令链。同一层级存在非空 `AGENTS.override.md` 时，它优先于 `AGENTS.md`；全局规则先加载，项目规则再从仓库根目录向当前工作目录依次加载，因此更靠近当前目录的规则优先级更高。合并内容达到 `project_doc_max_bytes` 后停止加载；修改指令文件后，需要新建运行或会话才会生效。详见 OpenAI 官方文档 [Custom instructions with AGENTS.md](https://learn.chatgpt.com/docs/agent-configuration/agents-md)。

### 验证指令加载

在仓库根目录启动一次新的非交互运行，让它报告已加载的全局和项目指令来源：

```text
codex --sandbox read-only --ask-for-approval never exec "Summarize the current instructions and list their source files in precedence order."
```

需要验证更靠近工作目录的 `AGENTS.md` 或 `AGENTS.override.md` 时，再从嵌套目录运行：

```text
codex --cd path/to/nested-directory --sandbox read-only --ask-for-approval never exec "List the instruction sources you loaded in precedence order, then summarize the effective guidance."
```

`--sandbox read-only` 可防止这次诊断运行修改工作区；`--ask-for-approval never` 只禁用审批提示，`never` 本身不提供只读边界。设置 `CODEX_HOME` 后，Codex 从该目录读取全局指令；未设置时默认使用 `~/.codex`。指令文件修改后应再次新建运行，因为指令链只在每次运行或 TUI 会话启动时构建一次。这些检查只能证明该次运行报告了哪些来源以及如何概括其内容，不能保证以后必然遵守，也不构成运行验收或业务验收。详见 OpenAI 官方的 [`codex exec` 说明](https://learn.chatgpt.com/docs/developer-commands#codex-exec)和[只读非交互安全组合](https://learn.chatgpt.com/docs/agent-approvals-security#common-sandbox-and-approval-combinations)。

## Codex Skills

### 按交付物逐步采用

新项目从当前交付物的责任 Skill 开始：需求、证据、可研、方案、设计、规范、写作或评审。安装整套 Skills 不代表每个任务必须经过九个 Skill；只有明确要求多阶段或多文档编排时才使用 `rd-delivery`。

既有项目应保留控制性文档、术语、批准记录和工作惯例。先在一个范围明确的真实任务上使用合适的专业 Skill，检查输出与证据边界，再按实际收益扩大采用。研究和评审在任务确实需要时是合适入口，不是所有文档的强制前置阶段。

采用范围与安装范围不同：下方 PowerShell 安装器管理全部九个声明的 `rd-*` 目录，不提供单 Skill 选择功能；可以先使用已安装套件中的少数能力。组合多个客户端前，先明确来源与作用域，并按下方平台说明检查实际发现结果；多装一份不代表多获得一项有效能力。

已有明确用户级安装时优先复用，不默认追加项目 Skill。首次本地安装可用下方配方；项目/团队和 Claude Code 本地 fallback 属于单独选择。Claude 桌面/聊天和 Claude Code 账户共享见 [claude.ai 上传](../claude/README.md#claudeai-skill-upload)。

### Skill 来源与作用域

英文 `skills/` 是仓库的 canonical Skill 源；`zh-CN/skills/` 是对应的简体中文翻译包。`~/.agents/skills/`（或 `$HOME/.agents/skills/`）下的用户级副本是已安装的个人副本，不是第二个仓库源。应为每个项目在明确的作用域选择一个明确来源安装。若多个用户级或项目级发现目录中存在同名 Skill，Codex 不会合并这些目录；选择和优先级可能产生歧义，因此应先检查发现到的副本，只有在获得明确授权后才移除或迁移无意中的重复副本。

安装前记录目标语言/来源、目标作用域（用户级或项目级）和 Skill 集合。目标已存在时，应先作合并或替换决策，不得盲目覆盖。下面的 PowerShell 脚本会在替换声明的 9 个 `rd-*` 目录前创建并校验备份；它不授权替换无关 Skill，也不会改变 Codex 的运行时选择策略。

全局安装：

```bash
skill_target="$HOME/.agents/skills"
mkdir -p "$skill_target"
for skill_source in zh-CN/skills/rd-*; do
  skill_name=$(basename "$skill_source")
  if [ -e "$skill_target/$skill_name" ]; then
    printf 'Refusing to overwrite existing Skill: %s\n' "$skill_target/$skill_name" >&2
    exit 1
  fi
done
cp -R zh-CN/skills/rd-* "$skill_target/"
```

在 PowerShell 中，推荐使用带完整校验的用户级安装脚本：

```powershell
pwsh -File ./scripts/install-rd-skills.ps1 -Language zh-CN
pwsh -File ./scripts/install-rd-skills.ps1 -Language zh-CN -CheckOnly
```

该脚本只管理声明的 9 个 `rd-*` 目录：先在 `$HOME/.agents/backups` 下建立并校验 SHA-256 备份，再暂存并校验待安装文件；替换失败时恢复原安装，成功后逐文件比对安装树与所选源目录。`-CheckOnly` 只执行最终比对，不写入文件。

项目级安装：

```bash
skill_target="/path/to/your-project/.agents/skills"
mkdir -p "$skill_target"
for skill_source in zh-CN/skills/rd-*; do
  skill_name=$(basename "$skill_source")
  if [ -e "$skill_target/$skill_name" ]; then
    printf 'Refusing to overwrite existing Skill: %s\n' "$skill_target/$skill_name" >&2
    exit 1
  fi
done
cp -R zh-CN/skills/rd-* "$skill_target/"
```

<a id="optional-projectteam-and-claude-code-local-fallback"></a>

### 可选项目/团队与 Claude Code 本地 fallback

```powershell
pwsh -File ./scripts/install-rd-skills.ps1 -Language zh-CN -DestinationRoot 'path/to/your-project/.agents/skills'
pwsh -File ./scripts/install-rd-skills.ps1 -Language zh-CN -DestinationRoot 'path/to/your-project/.agents/skills' -CheckOnly
# Claude Code local fallback: choose instead of account Skills where required
pwsh -File ./scripts/install-rd-skills.ps1 -Language zh-CN -DestinationRoot 'path/to/your-project/.claude/skills'
```

源始终是对应语言的共享 Skills 树。选择项目/团队安装时明确谁负责更新与验收；Claude Code 官方支持 `.claude/skills`，不能把 `.agents/skills` 宣称为 Codex 与 Claude Code 通用发现根。用户级 fallback 可将目标设为 `$HOME/.claude/skills`。先盘点同名来源，已有用户/account 副本时不默认追加；仅在授权范围内替换。

<a id="mixed-client-teams"></a>

### 混合客户端团队

Codex 与 Claude Code 没有共同的已文档化项目 Skill 发现根。Codex 读取仓库内 `.agents/skills` 和 `$HOME/.agents/skills`；Claude Code 文档列出 `.claude/skills` 和账号同步 Skills，未列出 `.agents/skills`。每个项目选择一种安排，并记录语言和源修订：

| 安排 | 覆盖 | 代价 |
|---|---|---|
| 项目 `.agents/skills`；Claude Code 使用账号 Skills | Codex 使用随仓库版本管理的副本；Claude Code 使用账号上传 | Claude Skill 版本取决于各成员的账号上传，不随仓库修订 |
| 项目 `.agents/skills` 与 `.claude/skills` 来自同一源修订 | Codex 与 Claude Code 各自读取原生项目副本 | 两份副本须一起更新和核对 |
| 仅项目 `.claude/skills` | Claude Code 使用项目副本 | Codex 文档列出的根不含 `.claude/skills`，Codex 成员需另做用户级安装 |

第一种安排与 Claude 适配优先使用账号 Skills 的约定一致，且只保留一份项目副本。每份本地副本用安装脚本更新，并用 `-CheckOnly` 确认。加入个人 `~/.claude/skills` fallback 前应盘点同名账号／用户／项目来源。原生发现根和账号同步契约分别适用；静态安装不能证明实际选中来源。[Codex Skills](https://learn.chatgpt.com/docs/build-skills)、[Claude Code Skills](https://code.claude.com/docs/en/skills)（2026-10-12 核对）

## Codex 配置

### 项目配置示例

审阅 `zh-CN/codex/project/config.example.toml` 后，按需合并为目标项目 `.codex/config.toml`；该最小示例采用 `on-request`、`workspace-write` 和禁用沙箱网络。项目须经 Codex 信任后才读取项目配置。它不替代用户 `config.toml`，也不授权安装或部署。

### 用户配置示例

从经过评审、具有明确取向的 `workspace-write` 示例开始：

```bash
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -e "$codex_home/config.toml" ]; then
  cp zh-CN/codex/examples/config.example.toml "$codex_home/config.toml"
fi
```

如果 `$CODEX_HOME/config.toml` 已存在（默认路径为 `~/.codex/config.toml`），先检查实际内容，再只合并需要的片段；不得盲目覆盖正常工作的个人配置。

标准示例有意设置 `web_search = "live"`、启用 `features.memories`、完整继承父 shell 环境，并设置 `ignore_default_excludes = false`，使 Codex 仍过滤名称中含 `KEY`、`SECRET` 或 `TOKEN` 的环境变量。这些选择与维护者已评审的运行基线一致，但不是适用于所有账户、工作区和威胁模型的通用安全或隐私默认值。

高权限配置档需要显式选择：

```text
zh-CN/codex/examples/config.full-access.example.toml
```

不要在不可信仓库中使用 `full access`（完全访问权限）。

## Claude Code 适配包

安装用户级 Claude Code memory（记忆）：

```bash
(
set -e
if [ -e ~/.claude/CLAUDE.md ] || [ -L ~/.claude/CLAUDE.md ]; then
  printf '%s\n' 'Stop: merge existing user-level Claude memory manually before installing.' >&2
  exit 1
fi
mkdir -p ~/.claude
cp zh-CN/claude/global/CLAUDE.md.template ~/.claude/CLAUDE.md
)
```

安装项目级 Claude Code 规则和 settings，不复制 Skills。项目级 `CLAUDE.md` 是通过 `@AGENTS.md` 导入共享项目核心的薄适配文件；目标项目已有 `AGENTS.md`（例如已按 Codex 方式安装）时保留并手动合并，不要覆盖：

```bash
(
set -e
if [ -e /path/to/your-project/CLAUDE.md ] || [ -L /path/to/your-project/CLAUDE.md ] || [ -e /path/to/your-project/.claude ] || [ -L /path/to/your-project/.claude ]; then
  printf '%s\n' 'Stop: merge existing Claude project files manually before installing.' >&2
  exit 1
fi
if [ -s /path/to/your-project/AGENTS.override.md ]; then
  printf '%s\n' 'Stop: merge the effective override and select the Claude import target manually before installing.' >&2
  exit 1
fi
if [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp zh-CN/rules/project/AGENTS.md.template /path/to/your-project/AGENTS.md
fi
if [ ! -s /path/to/your-project/AGENTS.md ]; then
  printf '%s\n' 'Stop: the shared AGENTS.md import target must be non-empty.' >&2
  exit 1
fi
cp zh-CN/claude/project/CLAUDE.md.template /path/to/your-project/CLAUDE.md
mkdir -p /path/to/your-project/.claude
cp zh-CN/claude/project/settings.example.json /path/to/your-project/.claude/settings.json
)
```

存在非空 `AGENTS.override.md` 时，示例会在安装适配文件前停止。应先有意识地合并这一 Codex 生效来源，再选择对应的 Claude 导入（例如 `@AGENTS.override.md`）后继续；Claude 不会自动发现 override 文件。已有但为空的 `AGENTS.md` 也必须先手动修复。

如果目标项目已有 `CLAUDE.md` 或 `.claude/`，请手动合并。

用户 settings 可从 `zh-CN/claude/global/settings.example.json` 合并到 `~/.claude/settings.json`；项目 MCP 可从 `zh-CN/claude/project/mcp.example.json` 合并到项目根 `.mcp.json`。规则安装不会自动启用这两项。用户/local MCP 应通过 CLI 管理 `~/.claude.json`；`enableAllProjectMcpServers=false` 不能证明 headless 会话连接被阻止。

## 环境变量

复制环境变量示例：

```bash
cp .env.example .env
```

只填写你实际启用的 MCP 服务器所需 API key。不要提交 `.env`。

Windows 用户级环境变量也可用 `setx` 设置，但设置后需要重启 shell、Codex CLI、Codex App 或 Claude Code。

英文根目录仍是权威基线；`zh-CN/` 是简体中文翻译包。目标文件已存在时，应手动合并，避免覆盖本地项目规则。

### Windows PowerShell 项目安装

在本仓库根目录运行，目标项目目录应已存在。该示例仅安装项目层，保留已有共享核心，并在覆盖已有 Claude 文件前停止。替换目标占位路径；已有文件应手动合并。`throw` 会停止安装块，但保留交互式 PowerShell 会话。

```powershell
& {
    $target = (Resolve-Path -LiteralPath 'path/to/your-project').Path
    if ((Test-Path -LiteralPath (Join-Path $target 'CLAUDE.md')) -or
        (Test-Path -LiteralPath (Join-Path $target '.claude'))) {
        throw 'Stop: merge existing Claude files manually before installing.'
    }
    $override = Join-Path $target 'AGENTS.override.md'
    if ((Test-Path -LiteralPath $override) -and (Get-Item -LiteralPath $override).Length -gt 0) {
        throw 'Stop: merge the effective override and select the Claude import target manually before installing.'
    }
    $core = Join-Path $target 'AGENTS.md'
    if (-not (Test-Path -LiteralPath $core)) {
        Copy-Item -LiteralPath 'zh-CN/rules/project/AGENTS.md.template' -Destination $core -ErrorAction Stop
    }
    if (-not (Test-Path -LiteralPath $core) -or (Get-Item -LiteralPath $core).Length -eq 0) {
        throw 'Stop: the shared AGENTS.md import target must be non-empty.'
    }
    Copy-Item -LiteralPath 'zh-CN/claude/project/CLAUDE.md.template' -Destination (Join-Path $target 'CLAUDE.md') -ErrorAction Stop
    New-Item -ItemType Directory -Path (Join-Path $target '.claude') -ErrorAction Stop | Out-Null
    Copy-Item -LiteralPath 'zh-CN/claude/project/settings.example.json' -Destination (Join-Path $target '.claude/settings.json') -ErrorAction Stop
}
```

Bash 项目安装示例使用子 shell，因此 guard 中的 `exit 1` 只停止安装块，不退出父交互式 shell；这些命令仍需 Bash，例如 Windows 上的 Git Bash。上面的 PowerShell 示例使用原生命令。安装后检查非空共享核心、`@AGENTS.md` 导入和 settings；Skills 按所选来源/作用域单独验收。回退时先检查后续编辑，仅移除本次新建的文件；主动合并的文件应从安装前备份恢复。
