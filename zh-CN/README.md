# Codex Three-Layer Delivery 简体中文包

本目录是 `Codex Three-Layer Delivery` 的简体中文翻译包（translation pack）。本项目面向系统设计师、系统架构师、技术方案作者、产品经理和标准/文档评审人员，聚焦需求分析、可研、方案、概要设计、详细设计、标准规范和文档评审。英文根目录是权威基线（canonical baseline）；本目录只提供中文阅读、复制和安装使用入口，不单独定义新的工程规则。

> 本项目独立维护，不隶属于 OpenAI、Cursor、Anthropic 或任何参考框架。具体灵感参考与许可证边界见根目录 `ATTRIBUTION.md`。

## 使用边界

- 英文根目录保持发布基线和结构基线。
- 仓库根 `AGENTS.md` 只治理本源码仓库的维护工作，与供下游项目复制的 `codex/project/AGENTS.md` 模板保持不同责任。
- `zh-CN/` 只翻译当前仓库的 Codex、Claude Code、Skills 和文档入口。
- Cursor 英文适配包位于 `cursor/project/`；Cursor 平台专用中文兼容包继续保留在 `cursor/zh-CN/`。
- 不把灵感参考表述为直接派生、实质移植或上游背书。

## 三层结构

```text
Layer 1: 全局指令
  zh-CN/codex/global/AGENTS.md
  zh-CN/claude/global/CLAUDE.md

Layer 2: 项目文档交付纪律
  zh-CN/codex/project/AGENTS.md（共享项目核心）
  zh-CN/claude/project/CLAUDE.md（通过 @AGENTS.md 导入共享核心的 Claude Code 薄适配）

Layer 3: 文档交付 Skills
  zh-CN/skills/rd-*/SKILL.md
  zh-CN/claude/project/.claude/skills/rd-*/SKILL.md
```

Skill 清单（8 个专业 Skill + 1 个显式编排 Skill）：

| Skill | 主要交付物 | 典型工作 |
|------|------------|----------|
| `$rd-requirement` | PRD / SRS / 结构化需求 | 需求分析、场景建模、优先级和验收标准 |
| `$rd-feasibility` | 可研报告 / 可行性分析 | 技术、经济、进度、合规、运行和风险可行性评估 |
| `$rd-research` | 证据包 / 研究笔记 / 事实核查矩阵 | 研究标准、开源、AI 工具、配置行为和争议主张 |
| `$rd-solution` | 技术方案 / 概要设计 / 建设方案 | 候选方案比较、推荐方案、架构和建设设计 |
| `$rd-design` | 详细设计文档 | 接口、数据模型、流程、状态机、错误和安全设计 |
| `$rd-specification` | 标准规范草案 / 条款级修订 | 国家、行业、企业或内部标准规范制定与修订 |
| `$rd-writing` | 技术文章 / 白皮书 / 证据报告 / 决策简报 | 将已核实材料转为面向受众的专业文档 |
| `$rd-review` | 独立评审报告 | 评审工程文档、研究报告、标准规范及技术或时政文章 |
| `$rd-delivery` | 交付章程 / 制品地图 / 阶段门禁 / 交接 | 显式编排多阶段、多文档或跨会话任务 |

表中前 8 个专业 Skill 可独立使用，不强制组成流水线；`rd-delivery` 是第 9 个 Skill，仅作为显式编排器使用。需要外部或争议证据时使用 `$rd-research`，需要把已核实证据组织为面向受众的成稿时使用 `$rd-writing`，需要独立结论时使用 `$rd-review`。仅当请求明确要求跨制品编排、阶段门禁或持久化交接时，才使用 `$rd-delivery`；请求不必点名该 Skill，但仅因任务复杂或存在多个输出不构成使用理由。该边界由 Skill 描述、共享路由规则和触发评测共同约束，不再使用将其限制为点名调用的平台专用开关。

每个 Skill 都在 `evals/` 下提供输出质量和触发边界用例，并在 `agents/openai.yaml` 中提供 ChatGPT/Codex 桌面元数据。多模式 Skill 在 `SKILL.md` 中保留公共流程，只按所选模式加载 `references/` 检查表。共享 Skill 正文使用中性 `rd-*` 标识；Codex 示例使用 `$rd-*`，Cursor 和 Claude Code 显式调用使用 `/rd-*`。

如需了解对历史虚构评估回答进行可选外部模型检查的试验，见 [Jev 语义检查试验](docs/jev-pilot.md)。记录保留了一条高置信度误报，Jev 仅作辅助，不是默认依赖、Skill 路由或发布门禁。

维护规则和显式 `rd-delivery` 工作流遵循价值优先：先明确当前阶段与首要结果，验证最短证据路径，并复用适用门禁，再扩展辅助工作。新增通用 Validator、宽泛测试矩阵、安全加固专项或框架，必须由已批准范围、已复现缺陷、权威要求或重大风险驱动。行为评测按环境 smoke test、变更面用例、相关回归逐层推进；只有共享路由、公共契约、发布决策、已观察到跨表面风险或用户明确要求时，才运行完整跨平台矩阵。

角色任务覆盖矩阵、非目标、外部设计依据以及采用 8 个专业 Skill 加 1 个显式编排 Skill 的理由，见 [RD Skills 评估与演进说明](docs/rd-skills-assessment.md)。

如需可粘贴到 ChatGPT 网页版的已确认中文个性化指令、完整英文参考译文和字符限制说明，见[网页版 ChatGPT 个性化自定义指令](docs/personalized-custom-instructions.md)。

如需已确认的 Claude 网页版英文指令、精确字符数、账户设置适用范围和验证边界，见 [Instructions for Claude（仅英文版）](../docs/claude-personalized-instructions.md)。

## 快速开始

完整的 Codex、Claude Code、Cursor、配置示例和环境变量安装说明见[安装说明](docs/installation.md)。

### Codex

安装全局指令：

```bash
codex_home="${CODEX_HOME:-$HOME/.codex}"
mkdir -p "$codex_home"
if [ ! -s "$codex_home/AGENTS.override.md" ] && [ ! -e "$codex_home/AGENTS.md" ]; then
  cp zh-CN/codex/global/AGENTS.md "$codex_home/AGENTS.md"
fi
```

安装项目规则：

```bash
if [ ! -s /path/to/your-project/AGENTS.override.md ] && [ ! -e /path/to/your-project/AGENTS.md ]; then
  cp zh-CN/codex/project/AGENTS.md /path/to/your-project/AGENTS.md
fi
```

安装 Skills：

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

PowerShell 用户可使用带备份和安装树精确比对的脚本：

```powershell
pwsh -File ./scripts/install-rd-skills.ps1 -Language zh-CN
pwsh -File ./scripts/install-rd-skills.ps1 -Language zh-CN -CheckOnly
```

如同一层级存在非空 `AGENTS.override.md`，它是当前生效的指令来源；应先备份并有意识地合并，不要创建不会生效的 `AGENTS.md`。如已有 `AGENTS.md`，也应先备份，再只合并需要的章节。不要直接替换现有个人全局指令或项目规则。模板包含角色、语言、推理深度、授权和交付纪律等观点化默认值，应按实际用户、团队与仓库调整；`zh-CN/` 全局模板有意默认使用简体中文。

可选的记忆模型与生成范围、Fast 选择、Windows MXC，以及验证和恢复步骤，见 [Codex 配置使用指南](docs/codex-configuration-guidance.md)。这些配方不改变公共默认值。

### Claude Code

安装用户级 Claude Code memory（记忆）：

```bash
(
set -e
if [ -e ~/.claude/CLAUDE.md ] || [ -L ~/.claude/CLAUDE.md ]; then
  printf '%s\n' 'Stop: merge existing user-level Claude memory manually before installing.' >&2
  exit 1
fi
mkdir -p ~/.claude
cp zh-CN/claude/global/CLAUDE.md ~/.claude/CLAUDE.md
)
```

安装项目级 Claude Code 规则和 Skills。项目级 `CLAUDE.md` 通过 `@AGENTS.md` 导入共享项目核心；目标项目已有 `AGENTS.md`（例如已按 Codex 方式安装）时保留并手动合并，不要覆盖：

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
  cp zh-CN/codex/project/AGENTS.md /path/to/your-project/AGENTS.md
fi
if [ ! -s /path/to/your-project/AGENTS.md ]; then
  printf '%s\n' 'Stop: the shared AGENTS.md import target must be non-empty.' >&2
  exit 1
fi
cp zh-CN/claude/project/CLAUDE.md /path/to/your-project/CLAUDE.md
cp -r zh-CN/claude/project/.claude /path/to/your-project/.claude
)
```

存在非空 `AGENTS.override.md` 时，示例会在安装适配文件前停止。应先有意识地合并这一 Codex 生效来源，再选择对应的 Claude 导入（例如 `@AGENTS.override.md`）后继续；Claude 不会自动发现 override 文件。已有但为空的 `AGENTS.md` 也必须先手动修复。

### Cursor

Cursor 英文适配包位于：

```text
cursor/project/
```

Cursor 中文适配包位于：

```text
cursor/zh-CN/
```

复制方式：

```bash
cp -r cursor/zh-CN/.cursor /path/to/your-project/.cursor
cp cursor/zh-CN/PROMPTS.md /path/to/your-project/PROMPTS.cursor.zh-CN.md
```

Cursor MCP 配置以 `mcp.example.json` 形式发布，且只包含已测试的 Context7。需要启用时，先审查凭据和数据流，再复制为目标项目的 `.cursor/mcp.json`；其它 server 应按已验证用途逐项加入，不要一次复制完整路由目录。

## 文件清单

```text
zh-CN/
  README.md
  PROMPTS.md
  codex/
    global/AGENTS.md
    project/AGENTS.md
    examples/
      config.example.toml
      config.full-access.example.toml
  claude/
    README.md
    global/CLAUDE.md
    project/CLAUDE.md
    project/.claude/settings.json
    project/.claude/skills/rd-*/SKILL.md
  skills/
    rd-*/SKILL.md
  docs/
    compatibility.md
    installation.md
    mcp-routing.md
    design-principles.md
    personalized-custom-instructions.md
    rd-skills-assessment.md
    release-checklist.md
```

## 已评审的公共默认值

公共示例同时包含安全边界和明确的能力选择；它们经过评审且具有倾向性，并非适合所有用户或威胁模型的无条件保守默认值：

- Codex 示例使用 `workspace-write`、实时 Web 搜索、Memories、完整 shell 环境继承，并通过 `ignore_default_excludes = false` 保留对名称含 `KEY`、`SECRET`、`TOKEN` 的默认过滤；应结合目标环境手动合并。
- Codex 外部 MCP server 默认禁用，直到凭据、数据流和使用场景被明确审查。
- Cursor 适配包只发布单一 Context7 的 `.cursor/mcp.example.json`，不直接发布活动 `.cursor/mcp.json`。
- 不使用 `@latest` 作为 npm MCP 包版本。
- Claude Code 项目设置默认禁止直接读取工作目录及其任意子目录中的常见密钥路径，并对匹配的 Bash 和 Windows PowerShell commit、push、tag、publish、delete 以及会丢弃未提交工作的 Git 命令前缀（`reset --hard`、`clean`、`checkout --`、`restore`）要求确认；这些权限模式属于防护措施，不能替代针对所有包装命令和复杂命令的完整安全边界。
- Codex/Cursor Context7 示例统一使用不带版本后缀的包名；[兼容性文档](docs/compatibility.md)保留历史已测试版本，实际解析版本仍需单独进行客户端运行核验。

## 验证

运行仓库正向门禁和 Validator 负向回归：

```powershell
python -m pip install -r requirements-validation.txt
pwsh ./scripts/validate.ps1
pwsh ./scripts/test-validator.ps1
```

Skill YAML/reference 和 Codex TOML/JSON Schema 门禁需要 Python 3.9+ 及 `requirements-validation.txt` 中固定的依赖，建议安装到隔离环境。二十四项负向回归在既有 Skill、镜像、证据、全局规则、上下文、提示词、临时数据与平台配置用例之外，新增覆盖 Codex Schema/运行基线一致的配置契约、Cursor 仅一条常驻规则的加载策略、跨平台推理与长期指引治理，GSD 当前/归档来源归属、明确交付编排请求边界及 Claude 共享导入安装保护。

公开发布前还必须执行联网动态门禁：

```powershell
pwsh ./scripts/validate-release.ps1
```

该门禁比较仓库内 Codex Schema 与当前官方 Schema，使用实时副本验证四份示例，核对已安装 Codex 版本，并从隔离的临时 `CODEX_HOME` 严格加载每份示例。静态门禁通过不能替代这项发布检查。

## 版本维护

英文根目录是唯一发布基线。更新英文 rules、skills、MCP 版本或平台适配后，再同步本目录。

同步时至少检查：

- `zh-CN/skills/rd-*` 与根目录 `skills/rd-*` 数量一致；
- `zh-CN/claude/project/.claude/skills/rd-*` 与 `zh-CN/skills/rd-*` 数量一致；
- JSON/TOML 可解析；
- 不引入真实 secrets、私有 relay URL 或旧仓库名；
- 不重新引入编码开发、代码评审、测试执行或部署执行类 Skill；
- 不把灵感参考写成直接派生或上游背书。

仓库维护者发布本项目时应使用[发布检查清单](docs/release-checklist.md)。该清单只治理仓库发布，不扩展 RD Skills 的职责。

## 致谢

本项目在整理过程中参考了以下公开项目的思路与实践。列出这些项目不代表对方背书、合作、兼容或直接派生，详细归属见 [`ATTRIBUTION.md`](../ATTRIBUTION.md)。

- [Matt Pocock Skills](https://github.com/mattpocock/skills.git)
- [Everything Claude Code](https://github.com/affaan-m/everything-claude-code.git)
- [GSD Core](https://github.com/open-gsd/gsd-core)
- [Rlues](https://github.com/WenJunDuan/Rlues.git)
- [Superpowers](https://github.com/obra/superpowers.git)
- [oh-my-codex](https://github.com/Yeachan-Heo/oh-my-codex.git)
- [Trellis](https://github.com/mindfold-ai/Trellis.git)
- [Addy Osmani Agent Skills](https://github.com/addyosmani/agent-skills)
- 感谢 [LINUX DO](https://linux.do/) 社区为开源项目提供交流与推广空间。

源码维护者注意：根 `.claude/settings.json` 仅隔离本仓库的指令模板，不属于可分发的 Claude 适配配置。见[兼容性证据](docs/compatibility.md)。
