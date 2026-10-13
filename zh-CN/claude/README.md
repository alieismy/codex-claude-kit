# Claude 简体中文使用说明

Claude Code 是 Codex & Claude Kit 的主要 Claude 入口。本目录将共享文档交付模型映射到 Claude Code 原生规则、选定 settings/MCP 示例、提示词与独立 Skill 来源，同时维护 Claude 网页版／桌面版适用的指令与 Skills。Codex 仍保留最完整的配置示例，各平台能力并不完全相同。

本地或账户同步 Skill 的调用见 [Claude Code 提示词](project/PROMPTS.md)。Claude 网页版／桌面版个性化设置见独立的 [Instructions for Claude（仅英文版）](../../docs/claude-personalized-instructions.md)，其账户设置与本地 `CLAUDE.md` 规则作用域不同；账户 Skills 见 [claude.ai 上传流程](#claudeai-skill-upload)。这些入口不表示所有 Claude 产品均已完成运行验收。

参考的 Claude Code 官方载体：

- memory（记忆）：`CLAUDE.md`
- settings：`.claude/settings.json`
- skills：`.claude/skills/*/SKILL.md`

官方文档：

已于 2026-09-04 重新核查；memory 页面已于 2026-10-01 针对 `AGENTS.md` 支持再次核查：

- https://code.claude.com/docs/en/memory
- https://code.claude.com/docs/en/settings
- https://code.claude.com/docs/en/permissions
- https://code.claude.com/docs/en/skills

## 当前结构

```text
zh-CN/claude/
  global/CLAUDE.md.template
  global/settings.example.json
  project/CLAUDE.md.template       # @AGENTS.md + Claude-specific guidance
  project/settings.example.json
  project/mcp.example.json
  project/PROMPTS.md
```

共享项目核在 `zh-CN/rules/project/AGENTS.md.template`；Skills 只在 `zh-CN/skills/`。源模板不活动，安装时去掉 `.template` 后缀；按需分别选规则、settings、MCP 和 Skills，不递归复制适配目录。完整[源到目标映射](../docs/installation.md#source-and-destination-map)与[迁移说明](../docs/layout-migration.md)。

项目 settings 保留常见密钥路径 Read deny 和危险命令 ask 护栏；Read 拒绝规则自 v2.1.208 覆盖内置 Edit、自 v2.1.228 覆盖 Write，但不覆盖 NotebookEdit，也不能阻止任意脚本自行读取文件。Windows 上不应据此宣称完整沙箱隔离。用户 settings 示例仅提供选定的 attribution 和 MCP 审批偏好；`enableAllProjectMcpServers=false` 不能证明 headless 会话不会连接项目 MCP。[官方 settings](https://code.claude.com/docs/en/settings)、[MCP](https://code.claude.com/docs/en/mcp)

项目 MCP 示例是 OpenAI 官方文档 HTTP 服务 `https://developers.openai.com/mcp`；合并/复制到项目根 `.mcp.json` 后才作为项目配置使用。用户和 local MCP 定义在 `~/.claude.json`，通过 `claude mcp add --scope user` 或 `--scope local` 管理，不能复制到 settings JSON 充当服务器定义。示例静态存在不证明运行连接成功。

## 安装

用户全局规则安装到 `~/.claude/CLAUDE.md`；用户 settings 示例合并到 `~/.claude/settings.json`。项目配方仅装共享核心、薄适配和 settings，不默认安装项目 Skills。

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

安装共享项目核心和 Claude Code 项目适配文件。目标项目已有 `AGENTS.md`（例如已按 Codex 方式安装）时保留并手动合并，不要覆盖：

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

如果目标文件已存在，请手动合并。不要盲目覆盖已有 `CLAUDE.md`、`.claude/settings.json` 或 Skills。

存在非空 `AGENTS.override.md` 时，示例会在安装适配文件前停止。应先有意识地合并这一 Codex 生效来源，再选择对应的 Claude 导入（例如 `@AGENTS.override.md`）后继续；Claude 不会自动发现 override 文件。已有但为空的 `AGENTS.md` 也必须先手动修复。

Bash 项目安装在子 shell 中运行，guard 失败不会退出父交互式 shell。Windows 用户可使用[原生 PowerShell 示例](../docs/installation.md#windows-powershell-项目安装)。

## 共享项目核心

`project/CLAUDE.md.template` 是薄适配文件：其中的 `@AGENTS.md` 行导入来自 `zh-CN/rules/project/AGENTS.md.template` 的共享项目核心，其余内容只保留 Claude Code 专有指引。项目通用行为应修改 `zh-CN/rules/project/AGENTS.md.template`，不要改适配文件。

Claude Code v2.1.277 及以上版本可直接读取 `AGENTS.md`，但仅限不存在 `CLAUDE.md` 的情况。本适配包含 `CLAUDE.md`，因此通过显式导入保持 `AGENTS.md` 被加载；该方式同样适用于更早版本，且不会重复加载（[memory 文档](https://code.claude.com/docs/en/memory#agents-md)，2026-10-01 核查）。在 Windows 上应使用导入而不是软链接。可在新会话中运行 `/memory` 或 `/context` 确认两个文件均已加载。

导入只共享文本指令，不能替代 Claude Code 的 settings、permissions、hooks、Skill 发现或其他平台控制；导入内容仍会占用上下文。

<a id="claudeai-skill-upload"></a>

## claude.ai Skill 上传

当 RD Skills 需要随 Claude 账户出现在 claude.ai 对话、Cowork 和 Claude Code 中，而不是按项目安装时，使用这一路径。上传的 Skill 保存在账户中；以同一账户登录的 Claude Code 会把它们下载到 `~/.claude/skills/synced/`，名称为 `anthropic-skills:rd-*`（[Claude Code skills 文档](https://code.claude.com/docs/en/skills)，2026-10-09 核查）。

```powershell
pwsh -File ./scripts/package-claude-ai-skills.ps1 -Language zh-CN            # 全部九个压缩包
pwsh -File ./scripts/package-claude-ai-skills.ps1 -Language zh-CN -Changed   # 仅与本地最近同步副本比较
```

- 脚本把所选语言的 canonical `skills/` 或 `zh-CN/skills/` 源打包到 `.tmp/local/claude-ai-skills/<language>/rd-*.zip`（已被忽略，可随时重新生成）：每个 Skill 一个压缩包，压缩包顶层是 Skill 文件夹，这是 claude.ai 的要求（[Create custom skills](https://claude.com/docs/skills/how-to)）。`evals/` 和 `agents/` 是仓库测试定义和 Codex 元数据，不打包。`manifest.json` 记录源提交和压缩包哈希。
- 源目录存在未提交改动时脚本拒绝打包，使每次上传都能对应到提交；试验性打包可加 `-AllowDirty`。
- `-Changed` 将运行时载荷与 Claude Code 最近同步的副本比较，因此 Claude Code 必须以同一账户登录并开启技能同步。claude.ai 上传时会改写 `SKILL.md` frontmatter 的排版，因此比较时 `name` 和 `description` 按取值比较，其余内容逐字节比较。存在多个同步账户目录时，用 `-SyncedRoot` 指定。
- 在 **Customize > Skills** 中逐个上传：选择 **+**，再选 **Create skill > Upload a skill**。每个 Skill 只保留一份：claude.ai 文档未说明上传同名 Skill 是否会替换原有版本，因此应删除或替换旧版本。下次同步后再运行 `-Changed`，输出 "nothing to upload" 只表示本地最近同步副本与源一致，不确认远端账户当前状态。
- 每个环境只保留一个来源。项目 `.claude/skills/rd-*` 或个人 `~/.claude/skills/rd-*` 副本不会隐藏同步副本：两者都会加载，本地副本占用 `/rd-*`，同步副本仍可通过 `/anthropic-skills:rd-*` 使用。使用上传的 Skill 时，项目规则配方保持不复制 Skills，也不另行默认安装本地 fallback 副本。

## 支持与验证范围

本适配提供用户/项目原生规则、选定 settings/MCP 入口和独立 Skill 来源。规则导入、载体位置和 Skill scope 已核对官方文档；当前布局的源码维护隔离只在记录的 Claude CLI fixture 中做有界验证，不能升级为全部指令、配置、MCP 或账户行为验收。静态门禁、打包比对与真实客户端结果分别报告，见[兼容性记录](../docs/compatibility.md)。

项目权限模式属于护栏；wrapper/复杂命令拦截、MCP 连接、账户远端最新状态、交互菜单和业务验收需在目标环境核验。修改 `CLAUDE.md`、settings 或 Skills 时复核相关载体与版本，不从其他产品的行为推导 Claude 结果。

## 本地 fallback 与验证边界

账户上传适用于 Claude 桌面/聊天与登录同一账户的 Claude Code；本地项目/团队或不采用账号 Skill 的环境仍可从 `zh-CN/skills/` 安装到 `.claude/skills/` 或 `~/.claude/skills/`，见[可选安装](../docs/installation.md#optional-projectteam-and-claude-code-local-fallback)。默认调用账户全名 `/anthropic-skills:rd-*`；明确采用本地 fallback 时才使用 `/rd-*`。同步缓存只作只读比较目标，不编辑、不打包为源。目录迁移没有上传账户或修改用户安装，也没有完成全部客户端验收。
