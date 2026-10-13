# 兼容性

npm registry 最新版本已于 2026-10-13 重新核查；本机 Codex CLI 与发布 Schema 基线均为 `0.162.1`，本机 Claude Code CLI 为 `2.1.296`。早先 Claude Code `2.1.287` 的观察日期仍为 2026-10-02，当前 registry 版本不代表已通过运行测试。其它已安装版本和运行测试保留各自原有日期：Cursor 版本为 2026-09-11，Cursor Rules、Skills 和 FAQ 文档为 2026-09-16，Claude Code 详细文档检查为 2026-09-04，Context7 有边界 stdio 探针为 2026-08-14。每次公开发布前重新核查 registry 最新版本和影响结论的工具/API surface。

## 2026-10-13 当前支持范围

仓库采用 `codex-claude-kit` 名称，以 Codex 和 Claude Code 为主要入口，保留 Claude 网页版／桌面版适用的自定义指令与 Skills，以及 ChatGPT 网页版专用指令。Cursor 专属分发源、安装配方与当前验证契约退役；此前日期化 Cursor 文档检查、路径和探针保留为历史证据。

这次调整涉及支持范围、源布局与引用，不改变软件或包版本。当前来源见下方映射，安装见[安装说明](installation.md)，退役和提示词迁移见[布局迁移](layout-migration.md)。

2026-10-13 的 v3.0.0 发布预检重新核查两个已安装 CLI 和全部九项 registry 版本，均与 2026-10-12 的值一致。发布门禁确认实时 Codex Schema 与仓库内 `0.162.1` 快照一致，六份公开用户／项目配置示例均通过 Schema 校验，并在隔离的 `CODEX_HOME` 中完成六项严格加载检查。这仅建立 Schema 与 Codex 配置启动层面的证据，不新增 Claude 运行、MCP 集成、账户上传或业务／生产验收结论。

## 2026-10-12 布局与平台契约（历史记录）

本次源布局把共享项目核移至 `zh-CN/rules/project/AGENTS.md.template`，全局/Claude/Cursor 分发指令采用 `.template` 后缀与非原生源目录，中文 Cursor 统一在 `zh-CN/cursor/`，四棵平台 Skill 镜像移除；仅维护 `skills/` 与 `zh-CN/skills/`。路径映射及独立个人安装边界见[布局迁移](layout-migration.md)，当前安装配方见[安装说明](installation.md)。以下日期化记录中的旧路径、样本数、版本、fixture 和运行结果均保留为历史布局证据，不用于验证新布局。

2026-10-12 实际打开的官方文档确认：Claude 用户/项目 settings 与 MCP 的作用域、存储位置不同，项目 MCP 使用根 `.mcp.json`，用户/local MCP 在 `~/.claude.json`；Claude Skills 官方列 `.claude/skills`，未将 `.agents/skills` 列为通用发现根。Cursor 官方支持用户/项目 `.agents/skills` 并兼容其他客户端根，User Rules 与项目 MDC、IDE settings、CLI config 分属不同载体。[Claude settings](https://code.claude.com/docs/en/settings)、[Claude MCP](https://code.claude.com/docs/en/mcp)、[Claude Skills](https://code.claude.com/docs/en/skills)、[Cursor Skills](https://cursor.com/docs/skills)、[Cursor rules](https://cursor.com/help/customization/rules)、[Cursor CLI config](https://cursor.com/docs/cli/reference/configuration)

新增的 Codex 项目配置与 Claude 用户 settings/项目 MCP 是选定本机配置入口，Cursor 全局模板供 Customize → Rules 选用，不构成完整 CLI/cloud 支持。Claude 项目 MCP 示例是 OpenAI 官方文档 HTTP 服务；安装到 `.mcp.json` 才成为项目配置。`enableAllProjectMcpServers=false` 不能证明 headless 连接被阻止。claude.ai 打包从 canonical 两语言源读取，账号缓存只作只读比较目标。

根维护者 `.claude/settings.json` 现为空对象；旧 `claudeMdExcludes` 排除列表因源模板改名而移除。目录形状与静态门禁不能单独证明维护会话隔离。迁移没有更改个人安装或上传账号，也没有真实 Cursor 客户端核验。

[本轮脱敏证据](../../docs/evidence/layout-migration-2026-10-12.json)记录一次 Windows Claude Code `2.1.296` 隔离 fixture：八个当前双语规则模板按源相对路径原样放入独立临时 Git 仓库，并配置原生 memory/Skill 正向控制。9 个请求读取均执行；`InstructionsLoaded` 记录根、继承用户/managed 与控制目录的原生 `CLAUDE.md`，未记录任何 `.template` memory 加载；控制 Skill 成功调用，两条旧目录限定 `rd-research` 名称均返回 `Unknown skill`。初始列表发现九个账号 RD Skills，但没有逐个调用。进程退出码 0、14.5 秒。用户级配置和账号 Skills 仍继承，本结果限于单次 fixture，不能泛化 Cursor、Codex 指令加载、MCP 连接、桌面行为或远端账号最新状态。 `InstructionsLoaded` 不报告直接 `AGENTS.md` 加载，因此 hook 不能单独证明 AGENTS 模板的加载或隔离；八个文件是 fixture 输入，不代表全部八个输入均受该 hook 观测。

同一记录的 `installationRecipes` 从两语安装指南原文提取 Cursor/Claude 项目 PowerShell 配方，在四个独立临时目标执行：四条正常安装路径的原生文件均与源 SHA-256 一致（每套 Cursor 10 个 `.mdc`，每套 Claude 3 个项目文件），四次重复安装均拒绝且未改变目标；Claude 配方未创建项目 Skills。这仅验证 PowerShell 文件安装，不涉及个人目录、Bash、客户端启动/发现、MCP 激活或运行验收。

同一记录还保留双语各 9 个 ZIP（各 24 个运行载荷文件）与 canonical 源及迁移前基线的精确载荷比对；两语源各 62 个文件保持不变，`evals/` 和 `agents/` 按打包契约排除。这证明打包载荷一致，不证明已经上传或服务端替换。

## 当前源映射（2026-10-13）

| 当前载体 | 英文源路径 | 中文源路径 |
|---|---|---|
| Codex 全局规则 | `codex/global/AGENTS.md.template` | `zh-CN/codex/global/AGENTS.md.template` |
| Codex 用户配置 | `codex/examples/config{,.full-access}.example.toml` | 同一布局位于 `zh-CN/codex/examples/` |
| Codex 项目配置 | `codex/project/config.example.toml` | `zh-CN/codex/project/config.example.toml` |
| Codex 提示词 | `PROMPTS.md` | `zh-CN/PROMPTS.md` |
| 共享项目规则 | `rules/project/AGENTS.md.template` | `zh-CN/rules/project/AGENTS.md.template` |
| Claude 全局/项目规则 | `claude/{global,project}/CLAUDE.md.template` | 同一布局位于 `zh-CN/claude/` |
| Claude settings/MCP | `claude/global/settings.example.json`；`claude/project/{settings,mcp}.example.json` | 同一布局位于 `zh-CN/claude/` |
| Claude Code 提示词 | `claude/project/PROMPTS.md` | `zh-CN/claude/project/PROMPTS.md` |
| ChatGPT 网页版专用指令 | `docs/personalized-custom-instructions.md` | `zh-CN/docs/personalized-custom-instructions.md` |
| Claude 账户指令 | `docs/claude-personalized-instructions.md` | 共用英文版，无中文版指令正文 |
| Skills | `skills/rd-*` | `zh-CN/skills/rd-*` |

## Codex

另行进行的 2026-10-05 [前瞻 RD 改进](forward-looking-rd.md)修改了共享指令和部分 RD 契约，并记录 Astra `max` / Sol 6.1 `high` 的有界给定文本比较。它不能证明这些变更的原生 Skill 发现、委派或跨客户端加载行为。

2026-10-05 的[配置与 Skill 补充验证](config-skill-tuning.md)使用 CLI `0.160.0`，有界比较了给定文本后 Astra `xhigh/max` 和 Sol 5.6/6.1 `high` 的表现，保留失败样本和继承上下文限制；同时检查 Hugging Face 描述收窄、移除公共示例中的退役 personality 设置，并澄清 explorer 权限表述。原生工具执行受阻，因此不扩大下方更广运行基线的适用范围。

| 组件 | 已测试版本 | registry 最新核查版本 | 备注 |
|---|---:|---:|---|
| `@openai/codex` npm 包 | `0.147.0` | `0.162.1` | registry 与本机 CLI `0.162.1` 已于 2026-10-12 重新核查。已为本次发布基线获取 tag 固定的 `0.162.1` Schema；发布门禁会将其与实时 Schema 比较并检查全部维护的用户/项目示例。更广的测试基线仍为 `0.147.0`。不要把该版本写进仓库名或 AGENTS 规则。 |

仓库在 `schemas/` 下保存带来源和 SHA-256 元数据的 Codex `0.162.1` 配置 Schema 离线快照。`scripts/validate.ps1` 确定性使用该快照；仅发布前执行的 `scripts/validate-release.ps1` 会将其与当前官方 Schema 比较，核对已安装 CLI 版本，使用实时副本验证全部六份用户/项目示例，并从隔离的临时 `CODEX_HOME` 严格加载每份示例。

独立的 2026-09-20 [双模型评估](dual-model-compatibility.md)使用 CLI `0.155.1`，请求 `gpt-5.6-sol` 与 `gpt-6-astra`，两者均为 high 推理和 high 输出详细程度。基于所提供文本的断言分别为 42/48 和 46/48，四次原生尝试均受阻。报告保留失败与限制，不证明后端模型身份或隐式路由，也不替代上述发布 Schema 或更广测试基线。

2026-10-02 的[原生路由冒烟记录](../../docs/evidence/skill-routing-smoke-2026-10-02.json)保留五次英文虚构用例尝试：四次符合加载期望，一次 Codex 编排尝试在加载 delivery 正文后超时。两个工具均未对不要求编排的“PRD 加摘要”加载 `rd-delivery`；Claude 完成了未点名 Skill 的编排请求。测试沿用现有用户级上下文，仅验证有界选择与加载，不证明输出质量、干净环境行为、导入完整性或 Cursor 兼容性。

[相同上限的补测](../../docs/evidence/skill-routing-followup-2026-10-02.json)在 Codex 和 Claude 中分别以 300 秒上限运行 T3 和无否定提示的 T6，四次均通过。明确编排请求加载 `rd-delivery`；仅要求 PRD 加简短摘要时没有加载。此次有界观察保留此前超时，不能证明统计稳定性或文档质量。

[带逐次计时的中文 CLI 补测](../../docs/evidence/skill-routing-zh-cli-2026-10-02.json)将中文项目模板和全部九个中文 Skills 复制到临时项目。修正 UTF-8 捕获和客户端事件评分后，四次 300 秒上限的尝试均通过，并保留每次进程耗时及包含任务启动开销的耗时。最初四次评分失败和两次文件编码诊断失败也保留：PowerShell 捕获器继承代码页 936，错误解码 CLI 的 UTF-8 输出；旧评分器也未将 Claude 的实际 Skill 调用计为选择证据。确定性字符捕获探针验证了修复。这些属于测量失败，不能据此判定路由回归。最终四次使用原中文提问，不附加编码或路由提示。测试仍继承用户级上下文，同名 Skill 优先级未验证；不构成桌面端验收或可靠性估计。此前英文尝试的逐次耗时和 10 月 1 日的实际调用上限仍分别为未测量和未知。

2026-10-05 的[上游学习对照](upstream-learning-pilot.md)使用 CLI `0.160.0`，请求 `gpt-6-astra`、推理 `max`、输出详细程度 `medium`。六次原生首次尝试比较暂存的中文 `rd-review` 与目标禁用条件：两次启用目标的评审请求均成功读取完整正文，两个禁用对照均未读取；资料整理这一相邻请求的两组也均未读取。经盲化任务代理评分和维护者核对，24 条冻结语义断言全部通过。这说明选定案例的加载边界及断言结果相当，尚不能证明增量质量收益，也不构成禁用既有 Skill 的依据。记录保留逐次耗时、缓存和 token 字段、本地精确文件选择器探针，以及独立的给定文本方法比较。继承上下文、后端身份、重复稳定性、英文行为、其他客户端及真实工作流收益不在该结果的证明范围内。

2026-10-09 的发布基线复核确认：`0.162.0` 标签 Schema 与官方实时副本逐字节一致。相对于 `0.160.0`，Schema 新增了可选能力并移除了插件 `ema_auth` 配置；四份公共示例均未使用被移除字段，因此保留配置值及权限默认值。Schema 存在某字段不代表对应功能可用。发布门禁分别验证 Schema、CLI 版本和严格加载，不扩大历史运行结论。

2026-10-10 的发布预检最初失败，原因是本机 Codex `0.162.1` 与 `0.162.0` Schema 版本固定值不一致。随后核对了 tag 固定的 `0.162.1` Schema 和许可证：tag Schema、当前实时 Schema 与既有快照逐字节一致，许可证也未变化。本次只刷新来源元数据、版本注释和兼容性记录，没有修改示例配置值或权限。现有发布门禁保持不变，必须在刷新后的基线上通过。

<a id="codex-configuration-guidance-2026-10-11"></a>

### 2026-10-11 配置使用指南

[配置使用指南](codex-configuration-guidance.md)新增可选 Markdown 配方以及验证和恢复说明。公开配置值、权限默认值、全局指令和 Skills 保持不变。本机 CLI 已重新核查为 `0.162.1`，离线 Schema 基线仍为 `0.162.1`。本次不构成新的 registry 或发布基线核查。

本日检查了官方[配置参考](https://learn.chatgpt.com/docs/config-file/config-reference)、[记忆控制](https://learn.chatgpt.com/docs/customization/memories)和 [profile 说明](https://learn.chatgpt.com/docs/config-file/config-advanced#profiles)。Profile 使用独立的 `<name>.config.toml` 文件。模型访问权限、生成资格、已有记忆的使用和配置加载成功是不同问题。

本日官方 [Standard token 费率](https://learn.chatgpt.com/docs/pricing#token-rates)如下：

| 模型 | 每百万输入 token 的 credits | 每百万缓存输入 token 的 credits | 每百万输出 token 的 credits |
|---|---:|---:|---:|
| GPT-5.6 Sol | 100 | 10 | 500 |
| GPT-6.1 Sol | 50 | 2.5 | 250 |

这些费率不能证明后台记忆的实际用量或质量。Credits 价格本身不能决定订阅内含用量；API key 用量和部分 Enterprise 协议适用其他计价方式。因此，指南将两个阶段均使用 GPT-6.1 Sol 作为可选候选，而非实测最优组合或公共默认值，也不假定旧提取模型更便宜。

[Windows 指南](https://learn.chatgpt.com/docs/windows/windows-sandbox#enable-mxc)推荐在兼容设备上优先采用 MXC，而本地 `codex features list` 将 `prefer_mxc` 标为 `under development`。配置参考说明独立 CLI 默认关闭；Desktop rollout 与本地覆盖另行影响选择。这些属于不同证据，不能据此认定已普遍成熟。官方 [MXC 兼容性探针](https://learn.chatgpt.com/docs/windows/windows-sandbox#mxc-compatibility)要求 CLI `0.162.0` 或更新版本。所列命令只检查启动；本次文档变更不验证沙箱隔离或脱离终端运行的服务行为。

指南区分基础配置的 app-server 严格加载和支持 profile 的 CLI 加载。CLI `0.162.1` 的 `codex app-server --help` 列出 `--strict-config`，没有 profile 选择器；主 CLI 提供 `--profile`。配置加载不能验证 MCP 调用、记忆生成、计费、质量或 Desktop 是否保持基础配置与 profile 边界。Markdown 片段不在现有四份公开 TOML 的检查清单内；未来若分发独立 profile，必须将其纳入维护的验证清单。

随后在 2026-10-11 进行的 v1.8.6 发布预检重新核查了 Codex、Claude Code 和七个 MCP 包的 registry 条目，所列最新版本均未变化。联网发布门禁确认实时 Schema 与仓库快照一致，并使用 Codex `0.162.1` 通过四次隔离严格加载。另行检查的中英文指南共八个 TOML 片段及其八个合并候选均通过固定 Schema 验证；四份公共示例解析后的值完全不变。这些检查不扩大运行行为或模型质量结论。

## Claude Code

发布前的[安装保护探针](../../docs/evidence/claude-installation-guards-2026-10-02.json)在 Windows Git Bash 中使用隔离的 HOME 和项目目标，执行全部十一个已发布 Claude Bash 安装块。52 个用例全部通过，包含既有项目/用户记忆、既有 settings、空共享核心和有效 override。guard 失败时原文件保持不变，用户记忆不会在项目预检前复制。这只证明有边界的安装文件行为，不证明 Claude 指令加载；未测试并发安装。

| 组件 | 已测试 / 已固定版本 | registry 最新核查版本 | 备注 |
|---|---:|---:|---|
| `@anthropic-ai/claude-code` npm 包 | 本仓库不固定 | `2.1.296` | registry 与本机 CLI `2.1.296` 已于 2026-10-12 重新核查；早先 `2.1.287` 的观察日期为 2026-10-02；settings Schema、适配器结构和 `claude doctor` 最近一次使用 `2.1.260` 重新核查的日期仍为 2026-09-04。未实际执行危险命令验证权限行为；settings 校验不能证明所有包装命令或复合命令都会被拦截。 |

2026-10-01 核查的 [memory 文档](https://code.claude.com/docs/en/memory#agents-md) 说明：Claude Code 自 v2.1.277 起仅在不存在 `CLAUDE.md` 时直接读取 `AGENTS.md`；`CLAUDE.md` 中的 `@AGENTS.md` 导入不会导致重复读取。项目适配因此采用导入方式。这是文档证据，尚未在维护者本机 CLI 上验证加载行为。

Claude Code 官方文档核查入口：

- https://code.claude.com/docs/en/memory
- https://code.claude.com/docs/en/settings
- https://code.claude.com/docs/en/permissions
- https://code.claude.com/docs/en/skills

2026-10-09 的 claude.ai Skill 打包核查观察到本机 CLI 为 `2.1.295`。2026-10-01 上传的九个 RD Skill，其同步副本的 `SKILL.md` 与 Claude 适配目录的历史 blob 逐字节一致，且没有新增文件。2026-10-09 上传 `scripts/package-claude-ai-skills.ps1` 生成的九个英文压缩包后，同步副本没有新增文件，references 与 `SKILL.md` 正文逐字节一致，但每个折叠的 `description: >-` 块都被改写为单行标量；九个 Skill 解析后的 `name` 与 `description` 取值均一致。仅按字节比较的 `-Changed` 因此把九个都报告为 changed；脚本现已按取值比较这部分元数据并报告为 current，无法解析的 frontmatter 形式按 changed 处理。同一会话中，个人 `~/.claude/skills/rd-*` 副本与同步的 `anthropic-skills:rd-*` 副本同时出现在技能列表中，与文档所述“短名优先但不去重”一致。claude.ai 的同名替换行为和同步时延尚未测量。

同日的冒烟检查把修订后的英文项目适配（不含 `.claude/skills/`）复制到隔离的临时项目。一次 headless 运行在 PRD 请求下选用了账户同步的 `anthropic-skills:rd-requirement`；另一次询问应在哪里修改 `rd-review`，回答指向账户源副本，并引用了“不要修改同步副本、不要再添加项目副本”的指令。每个场景只运行一次，继承了用户级上下文，且没有基线对照。维护本仓库时，编辑 `claude/project/CLAUDE.md` 和 `zh-CN/claude/project/CLAUDE.md` 会使 Claude Code 把各自适配目录下的 `.claude/skills/rd-*` 作为目录限定的嵌套 Skill（`claude/project:rd-*`、`zh-CN/claude/project:rd-*`）与账户副本一同加载；下文探针验证了一种仅限维护者本地的缓解方式。

[2026-10-09 嵌套 Skill 覆盖探针](../../docs/evidence/claude-nested-skill-overrides-2026-10-09.json)在 CLI `2.1.295` 上用 headless `claude -p` 运行，每种写法一次，临时 fixture 中含两个适配目录的 `rd-research`。不加覆盖时，读取单个适配目录中的文件会以短名 `rd-research` 加载该副本，并由它取代账户副本被调用；读取两个适配目录中的文件则加载 `claude/project:rd-research` 和 `zh-CN/claude/project:rd-research`，短名 `rd-research` 返回 `Unknown skill`。两种 `skillOverrides` 写法失败：只用目录限定名的 `off` 键能屏蔽两个限定名副本，但漏掉单个适配目录的加载，因为该副本保留短名；只写短名 `"rd-research": "off"` 会把 `anthropic-skills:rd-research` 也从会话初始 Skill 列表中移除。短名 `off` 键配合 `"anthropic-skills:rd-research": "on"` 在两种加载形态下都屏蔽了嵌套副本，并保留账户副本可列出、可调用。

随后把这一组合扩展到全部九个名称，写入被忽略的 `.claude/settings.local.json`，在本仓库中只读复核。读取两个适配目录的 `CLAUDE.md` 后，`claude/project:rd-review` 与 `zh-CN/claude/project:rd-review` 返回 `skillOverrides` 错误，九个 `anthropic-skills:rd-*` 均在初始 Skill 列表中，`anthropic-skills:rd-review` 正常运行。Skills 文档没有说明短名键会匹配目录限定的嵌套 Skill，CLI 升级后需要复核。短名 `off` 键也会隐藏同名的个人或项目 Skill。嵌套副本加载后，短名会命中被禁用的副本或返回 `Unknown skill`，不会运行账户副本，因此应使用全名 `anthropic-skills:rd-*` 调用。只实际调用了 `rd-research` 与 `rd-review`，未检查交互式 `/` 菜单。仓库不提交该覆盖，因为它取决于各维护者的 Skill 来源；该历史布局的维护者 `.claude/settings.json` 当时只包含 `claudeMdExcludes`。

[2026-10-09 Opus 5.5 指令评估](opus-5-5-instruction-review.md)原先对 Claude 全局模板的中英文版本做了三处修改：限制用子代理验证模型自己的工作；删除输出前自我审核；删除三项思维方法。采纳前，在 CLI `2.1.295` 上以 `claude-opus-5-5`、`xhigh` 运行了 12 次 headless `claude -p`，覆盖 4 个 eval 任务 × 3 个臂，每格一个样本。每个历史实验臂都通过了 29 条冻结断言中的 28 条，且三个臂都未通过同一项 T2 字数限制。[历史证据记录](../../docs/evidence/opus-5-5-instruction-ab-2026-10-09.json)保留了完整回复。该结果只说明这些臂未检测到回归，不说明有所改进。

2026-10-10，用户要求保留第一性原理拆解、任务分类和多视角推演。Claude 全局模板恢复全部六项思维方法，同时保留 R1/R2；当前模板不是历史 A2 臂，旧比较不验证新组合。补充修订纠正了理由：这些方法属于分析偏好，不要求披露内部推理。针对明确的硬性篇幅限制，`rd-writing` 补充修订要求明确计数单位与范围、对最终文本做确定性计数、最后一次编辑后重新计数，无法计数时说明限制而不虚报通过，并同步必要适配镜像。[补充证据](../../docs/evidence/claude-instruction-followup-2026-10-10.json)单独记录新探针及结果。打包脚本的无变化提示现只描述本地最近同步副本；本地相等不能确认 claude.ai 当前状态。2026-10-10 核查的[官方 Skills 上传契约](https://code.claude.com/docs/en/skills#using-skill-frontmatter-outside-claude-code)明确：claude.ai 只允许标准 Agent Skills 字段，不包括 Claude Code 的 `effort`，不支持的字段会在打包或上传时被拒绝。这些仓库修改不代表更新个人安装或账户。


[2026-10-01 历史冒烟记录](../../docs/evidence/skill-routing-smoke-2026-10-01.json)保留四次完成的 Codex 尝试和四次 Claude 鉴权阻塞（`Not logged in`）。用户确认 10 月 2 日 Claude 通过前已经登录，不能据此归因为升级修复。Codex T3 此前约 271 秒才完成文件捕获，后次上限为 180 秒，不是受控的路由回归比较。

[2026-10-02 源码维护隔离探针](../../docs/evidence/claude-source-isolation-2026-10-02.json)复现了两个 Claude 全局语言模板的嵌套指令加载。排除对应路径后，这些加载消失，正向控制指令仍加载，虚构文件仍可读取；随后用最终排除配置复核了八个模板目录、正向控制文件及根维护者规则的读取。因此历史布局曾增加仅用于维护的 `.claude/settings.json`，排除八个声明的指令模板；此结果不验证本次改名后空配置的行为。不得将根维护配置复制到下游项目。直接加载 AGENTS 不触发 `InstructionsLoaded`，不能仅凭 hook 证明 AGENTS 的加载或排除行为。测试仍沿用用户级上下文。

上轮安装探针曾意外执行组合安装块中的用户级复制，将当时的中文公共模板覆盖到用户 `~/.claude/CLAUDE.md`。本轮识别了该偏离，原文件尚未从可验证备份恢复。当前安装探针隔离 HOME 和目标目录，解读继承上下文时保留这一限制；此处不保留个人标识或凭据。

用户随后确认没有原备份，并授权以本轮修订后的中文全局模板为准；已先备份当前文件，再更新用户级 `~/.claude/CLAUDE.md`，文件哈希与中文模板一致。这是采用新基线，不是恢复原内容；上述探针均发生在该更新之前。

## Cursor（退役支持，历史证据）

本节保留此前检查时的文档契约与布局，不构成当前支持或安装说明。

Cursor Rules、Skills 和 FAQ 官方文档已于 2026-09-16 重新核查；2026-09-11 观察到的本机 Windows 桌面版本为 `3.20.10`（system setup）：

- [Rules](https://cursor.com/docs/rules.md)：项目规则必须是 `.cursor/rules` 下的 `.mdc` 文件；规则系统会忽略普通 `.md` 文件。需要普通 Markdown 指令时，应使用 `AGENTS.md`。Cursor 支持嵌套 `AGENTS.md`，在处理其所在目录或后代目录中的文件时应用这些指令，将其与父级指令合并，并使更具体的指令优先。
- [Skills](https://cursor.com/docs/skills.md)：Agent Skills 是可版本化的能力包，可包含脚本、模板和参考资料。Cursor 会从 `.agents/skills/`、`.cursor/skills/`、`~/.agents/skills/` 和 `~/.cursor/skills/` 发现项目级和用户级 Skill，也会加载 `.claude/skills/`、`.codex/skills/`、`~/.claude/skills/` 和 `~/.codex/skills/`。官方文档没有定义多个根发现同名 Skill 时的优先级或去重行为。共享/Codex Skills 安装在 Agents 根中，再与 Cursor 适配包的 `.cursor/skills/` 组合时，即使未安装 Claude Code，也已经属于多来源安装。自 2026-10-01 起，共享、Claude Code 和 Cursor 的 `rd-delivery` 副本内容一致，均不再使用平台专用调用开关；同名定义的选择歧义仍然存在。
- [MCP](https://cursor.com/docs/mcp.md)：项目级 MCP 服务器通过 `.cursor/mcp.json` 配置，全局 MCP 服务器使用 `~/.cursor/mcp.json`。
- [Rules FAQ](https://cursor.com/help/customization/rules#how-does-claudemd-work-in-cursor)（2026-09-16 核查）：Cursor 读取 `CLAUDE.md` 的方式与 `AGENTS.md` 相同，且 `CLAUDE.md` 会始终应用于每个会话，不受任何 `alwaysApply` frontmatter 设置影响。因此组合 Claude Code 和 Cursor 适配包会再增加一个常驻指令文件和一个可发现 Skill 来源；详见历史源路径 `cursor/README.md`。

2026-09-16 的一次维护者会话报告：`codex/` 与 `zh-CN/codex/` 下四份可分发 `AGENTS.md` 模板，以及英文和中文 Cursor 的两份 `00-global-principles.mdc`，被同时列为生效指令。该历史记录中的六个文件合计 64,928 bytes，并包含互相冲突的语言指令。该结果属于单次会话运行观察，不是已独立复现的加载契约；官方嵌套 `AGENTS.md` 文档描述的是目录范围内应用。该历史观察没有已验证的隔离机制；本次改名的运行隔离结果须另行核验。应把该观察视为源仓库尚未解决的兼容性风险，不能据此断言每个 Cursor 会话都会加载全部六个文件，也不能断言根维护者文件一定能覆盖它们。

下表保留退役前适配布局；当前仓库已不提供 Cursor 安装入口。

| 历史适配面 | 历史仓库路径 | 当时公开发布姿态 |
|---|---|---|
| 英文规则 | `cursor/project/.cursor/rules/*.mdc` | Cursor 原生项目规则 |
| 英文 Skills | `cursor/project/.cursor/skills/rd-*/SKILL.md` | 与根目录 `skills/rd-*` 镜像 |
| 英文 MCP 示例 | `cursor/project/.cursor/mcp.example.json` | 仅示例；审查后复制为 `.cursor/mcp.json` |
| 中文规则 | `cursor/zh-CN/.cursor/rules/*.mdc` | Cursor 平台专用中文兼容包 |
| 中文 Skills | `cursor/zh-CN/.cursor/skills/rd-*/SKILL.md` | 与 `zh-CN/skills/rd-*` 镜像 |
| 中文 MCP 示例 | `cursor/zh-CN/.cursor/mcp.example.json` | 仅示例；审查后复制为 `.cursor/mcp.json` |

退役前仓库不直接发布活动 Cursor `.cursor/mcp.json`，也未在公开模板中依赖 `disabled` 或 `alwaysAllow` 等未确认的 Cursor MCP 字段。

## MCP 包

| MCP 服务器 | 包名 | 已测试版本 | registry 最新核查版本 | 公开配置默认值 |
|---|---|---:|---:|---|
| Context7 | `@upstash/context7-mcp` | `4.0.2` | `4.3.0` | Codex 示例禁用 |
| Tavily | `tavily-mcp` | `0.2.19` | `0.2.22` | Codex 示例禁用 |
| Sequential Thinking | `@modelcontextprotocol/server-sequential-thinking` | `2025.12.18` | `1.0.0` | 公共最小示例省略 |
| Brave Search | `@brave/brave-search-mcp-server` | `2.0.82` | `2.1.4` | 公共最小示例省略 |
| Playwright MCP | `@playwright/mcp` | `0.0.75` | `0.0.83` | Codex 示例禁用 |
| Chrome DevTools MCP | `chrome-devtools-mcp` | `1.1.1` | `1.10.1` | Codex 示例禁用 |
| Augment Context Engine | `ace-tool-rs` | `0.1.16` | `0.1.16` | 公共最小示例省略 |

2026-10-12 的 v2.0.0 发布预检重新查询了 Codex、Claude Code 和上述七个 MCP 包的 registry 条目，并核对本机 CLI。八个 registry 值与先前记录一致；Sequential Thinking 的 `latest` 标签通过 registry `/latest` 与显式指定官方 registry 的 `npm view ... dist-tags` 均返回 `1.0.0`，先前快照记录的 `2026.8.31` 保留为历史。这里报告当前标签，不推断版本变化原因或升级顺序；该 server 仍未加入公共最小示例，也没有新增 MCP 运行验收。

Context7 `4.0.2` 已对照 [npm 包元数据](https://www.npmjs.com/package/@upstash/context7-mcp/v/4.0.2)和 2026-08-11 发布的 [GitHub 官方 Release](https://github.com/upstash/context7/releases/tag/%40upstash%2Fcontext7-mcp%404.0.2)核实。该包要求 Node.js `>=20.18.1`。在 Windows 与 Node.js `24.18.0` 环境中，包能够返回预期 CLI 版本与参数，完成 MCP 协议 `2025-06-18` 的 stdio `initialize` 交换，并通过 `tools/list` 返回 `resolve-library-id` 和 `query-docs`。

上述结果只构成包、静态配置和 stdio 协议层证据，不证明已完成 Context7 鉴权查询、Codex/Cursor/Claude Code 宿主端到端集成或业务/生产验收。达到更高证据层级前，不得作相应成功声明。

Codex 的 Context7 示例统一使用不带版本后缀的 `@upstash/context7-mcp`；其它 npm MCP 调用也不固定版本。表中的 `4.0.2` 仅为历史已测试基线，不代表下一次安装实际解析出的版本已经通过验证。启用前检查实际解析版本及运行要求；需要可复现安装的使用者应在自己的配置中固定已核验版本。其它 server 仍可按 `docs/mcp-routing.md` 路由，但应在存在已验证需求时逐项添加，不应把完整候选目录一次复制进配置。上表版本仍作为兼容性证据，发布前必须重新核查。

## 可选 Jev 试验

2026-09-21 在 Windows 下，通过 PowerShell 完成一条虚构预检，再通过 Python `3.13.12` 标准库完成 22 次评估请求；请求均发送至 `https://api.typesafe.ai/v1/systemone`，并返回 `jev-1.13.0`，没有安装 SDK。[试验报告](jev-pilot.md)记录 78 条局部判断、一条高置信度误报、确定性检查和有边界的 Codex 复核。这仅证明该试验的鉴权 API 调用，不证明原生 Skill 路由接入、已校准准确率、中文等效、未来服务/模型兼容或生产验收。Jev 是可选工具，不进入默认配置和仓库门禁。

## 发布规则

创建 tag 前：

1. 对每个 npm MCP 包运行 `npm view <package> version`；
2. 如果版本变化，更新 `registry latest`（注册表最新版本）列；
3. 只有重新验证后，才更新已测试版本；
4. 所有当前 Codex Context7 示例统一使用不带版本后缀的包名；`scripts/validate.ps1` 检查该策略及中英文历史版本记录一致性；
5. npm MCP 示例不固定版本，也不显式添加 `@latest` 后缀；安装时核对实际解析版本，不把 registry 最新版本等同于已测试版本；
6. 运行 `pwsh ./scripts/validate-release.ps1`，检测 Codex 官方 Schema 漂移，并使用版本匹配的已安装 CLI 严格加载示例；
7. 工具名或 API surface 有变化时，在 release notes（发布说明）中说明。
