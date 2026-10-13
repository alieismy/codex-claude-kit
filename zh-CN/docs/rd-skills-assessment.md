# RD Skills 评估与演进说明

状态：已实施基线；2026-10-05 更新选择性吸收证据。此前注明日期的兼容性观察保留原有适用范围。

当前平台与源布局遵循[兼容性文档](compatibility.md)中的 2026-10-13 范围更新：维护 Codex 和 Claude，Cursor 已退役，Skills 只保留两棵语言权威源。下文早期试验保留当时的适用范围。

## 结论

原有 7 个 Skill 不多余。它们构成了完整的决策与文档生命周期：需求、可研、研究证据、解决方案架构、详细设计、标准规范和独立评审。

第一次角色任务覆盖分析确认了一项实质缺口：有来源支撑的专业写作此前被迫放入 `rd-solution`，或缺少稳定工作流，因此由 `rd-writing` 负责。进一步对照 Matt Pocock Skills 与 Trellis 后，又确认了性质不同的第二项缺口：没有 Skill 负责明确编排多阶段、多文档或跨会话任务。本次新增 `rd-delivery` 作为显式编排 Skill，其余 8 个专业 Skill 仍可独立使用。

2026-08-31 的后续审计发现了一个更窄的需求获取缺口，而不是第十个 Skill 领域：当可识别的外部责任人掌握当前用户无法提供的阻塞性事实、决策或批准时，`rd-requirement` 现在路由到按需问卷 reference。`rd-delivery` 只记录其权威指针、接收角色、阻塞项和返回判据。

## 角色任务覆盖

| 日常工作 | 主 Skill | 辅助 Skill | 边界 |
|---|---|---|---|
| 产品与系统需求 | `rd-requirement` | `rd-research`、`rd-review` | 建议技术不会自动成为需求 |
| 项目或技术可行性 | `rd-feasibility` | `rd-research`、`rd-review` | 负责决策分析，不负责设计或采用执行 |
| 开源、AI 工具、API 与技术研究 | `rd-research` | `rd-feasibility`、`rd-review` | 证据优先；热度和演示不是适用性证明 |
| VPN、VPS、代理、网络与系统配置研究 | `rd-research` | `rd-solution`、`rd-design` | 先建立环境、拓扑、威胁边界、验证和回退 |
| 系统与软件架构 | `rd-solution` | `rd-research`、`rd-review` | 负责方案选择和概要架构，不负责详细契约 |
| 可进入实现阶段的技术设计 | `rd-design` | `rd-research`、`rd-review` | 设计配置和回退契约，不编写运行命令 |
| 标准和规范性文档 | `rd-specification` | `rd-research`、`rd-review` | 明确效力、适用性和符合性 |
| 技术文章、白皮书、证据报告、决策简报 | `rd-writing` | `rd-research`、`rd-review` | 证据稳定后形成面向受众的成稿 |
| 技术或时政文章事实核查与论证审读 | `rd-research`、`rd-review` | `rd-writing` | 逐项主张核验，证据标准不随立场变化 |
| 多文档任务、阶段门禁、制品状态和跨会话交接 | `rd-delivery` | 仅调用任务所需的专业 Skill | 仅显式编排，不构成强制流水线 |
| 核心代码、测试、部署、安全扫描 | Codex 基础工作流和专业插件 | 相关 `rd-*` 设计输入 | 不重复建设通用文档 Skill |

## 为什么是 9 个，而不是更多

- `rd-delivery` 是受用户意图门控的编排器，不是新的文档编写领域。它负责制品地图、阻塞关系、阶段门禁、状态和交接，并把具体文档委派给最匹配的专业 Skill。
- `rd-writing` 负责叙事成稿，`rd-research` 负责证据，`rd-review` 负责独立结论。该边界避免同一 Skill 同时研究、主张并批准自己的产出。
- 开源与 AI 工具研究、基础设施/配置研究、事实核查共享同一证据契约，因此作为 `rd-research` 的按需模式，而不是新增 3 个互相竞争的顶层 Skill。
- 研究报告评审和文章评审共享问题定位、分级、整改和结论机制，因此作为 `rd-review` 模式。
- 外部责任人确认问卷是 `rd-requirement` 的条件性需求获取模式，不是独立可触发的生命周期或写作领域。
- 编码、部署执行、浏览器自动化、安全扫描和文件格式处理已有更强的基础或专业工作流。增加宽泛的 `rd-code` 或 `rd-operations` 会产生触发冲突并削弱职责归属。

## 外部设计依据

- 2026-09-20 的 [Astra 指南吸收与比较](astra-guidance-adoption.md)记录对当前 OpenAI 指南和 PrompTessor 任务模板示例的有边界吸收：说明导致阻塞的指令依据，以及可选的任务授权与完成条件块。改动保留 Skill 正文、description、权限和调用策略；显式提供文本的比较不证明原生加载或跨客户端行为。
- 2026-09-20 的[双模型评估](dual-model-compatibility.md)以 high 推理/high 输出详细程度检查 Sol 与 Astra 在该日期的共享组合，保留失败与原生阻塞，并为 `rd-writing` eval 4 增加简短决策简报 fixture。该基线下每个 canonical 语言目录有 44 个输出用例；当次变更未修改九个 Skill 正文和路由。
- 2026-10-05 的[前瞻 RD 改进](forward-looking-rd.md)在共享行为、可研、方案、研究和相关评审参考中加入结合场景寻找机会、匹配阶段的推荐强度。新增三个合成用例后，每个 canonical 语言目录有 47 个输出用例。记录区分有界的给定文本比较与原生加载、委派和生产证据。
- 2026-10-05 随后的[七项上游复查与有边界试点](upstream-learning-pilot.md)区分原生 `rd-review` 加载与输出质量，并将可选的证据复用及设计方法与既有文本进行比较。四个合成交付/设计案例使每个 canonical 语言目录达到 51 个输出用例定义。报告记录采用决策、实测用量字段、继承上下文限制及仍缺少的真实工作流证据。
- 后续的[真实制品交接](upstream-learning-pilot.md#真实制品交接跟进2026-10-05)使用该仓库的实际交付包恢复报告证据，并离线准备全部14份 prompt。修复了 manifest 精确序列化说明的缺口，原实验和 Skill 指令保持不变；长期工作流及应用接口收益仍未测量。
- [面向专业场景的采用跟进](rd-method-adoption.md)为九项职责分别映射已有覆盖、可选方法候选及排除项。当前真实采用简报及一名代理读者完成七项阅读任务，未发现实质解释缺陷，因此保留首稿和全部 Skill 指令。记录允许在没有先证明基线失败的情况下开展有边界的能力试验，并保留真人和外部业务成果未验证的状态。
- 后续[真实需求跟进](rd-method-adoption.md#真实需求跟进2026-10-05)记录一条外部项目需求、两项经来源核验的 Minor 修订，以及获授权的本地 HTTP 和浏览器检查。预定的两次方法对照均超时且未产出完整需求，因此增量收益仍未知。保留工作样例及按实质歧义选用的实例方法；Skill 指令和每个 canonical 语言目录的 51 个输出用例定义保持不变。
- [Agent Skills 规范](https://agentskills.io/specification) 将 `name` 和 `description` 定义为发现层，并建议渐进披露、聚焦参考文件、执行验证，以及主文件不超过 500 行。
- 当前 [OpenAI Codex Skill 指南](https://learn.chatgpt.com/docs/build-skills) 要求描述前置核心用途，因为 Skill 较多时初始列表可能缩短描述或省略部分 Skill；该指南还说明了面向 ChatGPT/Codex 桌面的可选 `agents/openai.yaml` 元数据。
- 原 [openai/skills 仓库](https://github.com/openai/skills) 已标记为不再用于当前分发示例；[openai/plugins](https://github.com/openai/plugins) 是当前打包参考。本项目为跨客户端编写和适配保留直接 Skill 目录，插件化属于独立的分发决策。
- Anthropic 的 [Agent Skills 工程指南](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills) 建议从观察到的能力缺口出发，使用代表性任务评测，并把互斥上下文拆为按需资源。
- Matt Pocock 的 [research Skill](https://github.com/mattpocock/skills/blob/v1.2.3/skills/engineering/research/SKILL.md) 强调一手来源研究和单一带引用制品；更名后的 [writing-for-agents 指南](https://github.com/mattpocock/skills/blob/v1.2.3/skills/productivity/writing-for-agents/SKILL.md) 把 Agent 指令视为信息架构问题：前置触发上下文，只加载影响决策的细节，规定完备的完成检查，维持单一权威来源，并清理重复或陈旧说明。2026-08-07 审计把正式版 `v1.2.3` 固定到 Commit [`6acc160e4e0cd062dbbbd7a1b26ae92855edf07e`](https://github.com/mattpocock/skills/commit/6acc160e4e0cd062dbbbd7a1b26ae92855edf07e)；2026-08-31 后续审计另将未发布 `main` 固定到 [`6654f6b60cd9d5be8b54c6fafe44346dabeb3b76`](https://github.com/mattpocock/skills/commit/6654f6b60cd9d5be8b54c6fafe44346dabeb3b76)，并检查其 [to-questionnaire Skill](https://github.com/mattpocock/skills/blob/6654f6b60cd9d5be8b54c6fafe44346dabeb3b76/skills/productivity/to-questionnaire/SKILL.md)。本项目只独立吸收适合文档交付的机制。
- [Trellis](https://github.com/mindfold-ai/Trellis) 将范围化规范、任务制品、验证上下文和会话交接持久化，并采用 Plan / Implement / Verify / Finish 阶段边界。本项目只适配文档交付机制：权威制品、决策闭环工作包、阶段门禁、状态纪律和持久化交接；不复制 `.trellis/` 目录模型、任务脚本、编码流程或强制批准状态机。

## Matt Pocock Skills 1.2.0—1.2.3 与 2026-08-31 Main 审计

正式版审计先检查引入可移植 `agents/openai.yaml` 元数据和 Codex 仅显式调用策略的 [`v1.2.0`](https://github.com/mattpocock/skills/releases/tag/v1.2.0)，再核实 [`v1.2.3`](https://github.com/mattpocock/skills/releases/tag/v1.2.3) 及 Commit `6acc160` 源码。`v1.2.2` 恢复 `writing-for-agents` 的模型调用；`v1.2.3` 加强密钥脱敏并移除子代理说明中的 Claude 专用表述。检查时 GitHub 不存在 `v1.2.1` Release。2026-08-31 后续审计把该正式版基线与未发布 `main@6654f6b` 分开；后者比 `v1.2.3` 多 39 个 Commit，而 `package.json` 仍声明 `1.2.3`。

| 机制 | 决定 | 本项目适配 |
|---|---|---|
| 用户显式调用的编排与模型自动调用的复用纪律分离 | 采纳，2026-10-01 修订 | 只有请求明确要求编排时才使用 `rd-delivery`；请求不必点名该 Skill。原先限制为点名调用的开关（`policy.allow_implicit_invocation: false` 与 `disable-model-invocation: true`）已移除，因为它们会阻断此类请求，而一次有界冒烟运行显示模型会绕过开关直接读取 Skill 文件。标准/Codex Skill 根目录继续只使用可移植的 `name` 和 `description` Frontmatter。 |
| 每个步骤具备可检查且要求充分的完成标准 | 采纳 | 9 个主 Skill 的每个编号步骤都具备一个英文或中文完成标准，仓库验证在所有适配器中强制每一步恰好包含一个完成标准。 |
| 单一权威来源；关系图和交接作为索引而非内容仓库 | 采纳 | 交付记录指向权威制品和决策记录，不重复维护完整内容。 |
| Agent 文档作为上下文与认知负载路由器 | 采纳 | 项目 `AGENTS.md` 只维护稳定的效力、路由和完成规则；RD 详细流程由 9 个 Skills 单一维护。环境可发现事实在使用时检查，不缓存为长期说明。 |
| 诊断和交接中的密钥与敏感标识脱敏 | 采纳并扩展 | 研究、写作、评审和交付均隐藏密钥及非必要的个人或基础设施标识，同时保留受控证据指针和复现边界。 |
| 在不确定性下规划下一批可执行工作 | 按文档语义采纳 | `rd-delivery` 区分可定义工作、尚不足以精确定义的范围内工作和范围外工作；只有精确且可独立评审的产出才进入工作包。 |
| 事实由环境与来源核实，干系人决策仍归人类所有 | 保留并加强 | 需求只标记证据并路由可行性决策，不再提前作出结论；可研记录决策权限；其他流程继续区分可查事实和授权决策。 |
| 把外部知识或权限缺口转换为问卷 | 按需求语义采纳 | 只有可识别的外部责任人掌握阻塞性答案时，`rd-requirement` 才加载按需 reference。问题区分事实、决策和批准；当前用户只确认接收人和需要带回的结果，不代替责任人回答。 |
| 用真实消费端兼容形状解析 Skill YAML 并验证 reference 指针 | 作为维护门禁采纳 | 固定版本的 PyYAML Validator 会拒绝畸形或重复键的 Frontmatter、`agents/openai.yaml`、缺失或越界的本地链接、未被引用的 reference、嵌套 reference 和 reference 之间的链式跳转；PowerShell 继续负责仓库特有的语义检查。 |
| 一手来源研究并形成单一带引用制品 | 已采纳 | `rd-research` 已包含来源层级、反证、日期/版本背景、单一权威证据包和下游交接。 |
| 双轴评审 | 已覆盖更广范围 | `rd-review` 把对齐/证据轴与内在质量/论证轴用于需求、可研、研究、方案、设计、标准和文章，而非只评审代码差异。 |
| 为大量手动命令增加 Router Skill | 暂不采纳 | 只有 `rd-delivery` 要求请求明确提出编排；8 个专业 Skill 可由模型独立触发，增加第二个路由器没有独立交付物，只会增加认知与维护成本。 |
| 强制使用后台研究代理 | 不采纳 | 并行研究可能有价值，但 Skill 在子代理不可用、不适用或未获授权时仍必须正确运行。 |
| Issue Tracker 状态机、编码流程、TDD、实现和代码评审 | 不采纳 | 与仓库明确限定的文档交付和系统设计范围冲突。 |
| Tracker 专用关系图、标签、任务认领和自动外部写入 | 不采纳 | 持久化仓库制品和明确授权边界可移植；外部 Tracker 变更仍取决于具体任务与授权。 |
| 把 “Call the Skill tool” 写入主 Skills | 不作跨平台采纳 | Claude Code 记录了 Skill tool，而当前 OpenAI 指南记录的是显式 `$skill` 和基于 description 的隐式选择。没有运行证据时，平台专有调用措辞不得进入 canonical 共享 Skills。 |

本项目不复制上游的编码、工单、TDD、向导或强制子代理工作流，只吸收可移植的指令机制，并保持本仓库的文档交付和系统设计范围为最高约束。

## VibeCoding 9.9.6 参考审计

本次将本地 VibeCoding Codex 9.9.6 目录作为设计参考进行评审，不把它作为本项目的上游依赖。其最有价值的部分是以下文档治理机制：

- 将长期需求与意图、当前架构、任务特定变更设计、决策理由、证据和评审发现置于不同效力层级。
- 区分可复验的机器门禁与人工决策。豁免必须记录授权责任人、理由、有限范围、剩余风险和重新评审触发条件。
- 门禁失败时返回最近的受影响工作包，不重启无关阶段；重复失败且无法解决时转为明确阻塞。
- 上游发生实质变更后，使受影响的下游评审和批准失效。
- 验证权威指针，并报告缺失、过期或越出仓库边界的路径。
- 只有规则可追溯到明确需求、重复出现的已观察失败或重大项目风险，并具有验证路径时，才将其沉淀为持久项目规则。

以下机制明确不采纳：

| 候选机制 | 决定 | 理由 |
|---|---|---|
| 将 PACE 生命周期和 `.ai_state` 状态机设为项目级默认流程 | 不采纳 | 面向编码且对本项目的文档交付范围侵入过大 |
| Athena/Quantum Skill 族和具名子代理 | 不采纳 | 与现有专业 Skill 职责重复，并依赖来源项目特定的路由假设 |
| 整套默认 hook 体系 | 不采纳 | 运行表面积过大，且未证明原命令和输出契约可移植到原生 Windows |
| `approval_policy = "never"` 与 `danger-full-access` 组合 | 不采纳 | 同时移除批准和沙箱边界，不适合作为公开或项目默认值 |
| 固定模型上下文和压缩阈值 | 不采纳 | 当前官方配置证据不足以支持这些模型特定假设 |
| 直接复制参考目录的文本或脚本 | 不采纳 | 未发现许可证、`COPYING` 或 `NOTICE` 声明；本项目仅独立表述所吸收的机制 |

来源 `config.toml` 在 2026-08-31 评审所用的 Schema 中校验失败，因为 `windows_wsl_setup_acknowledged` 不是已识别的顶层属性。2026-09-07 复核的 Codex `0.153.4` tag 固定 Schema 和实时 Schema 与此前 `0.153.2` 快照逐字节一致，仍未包含该属性，但当前配置参考已将其列为 Windows 专用布尔值。配置参考同样把 `agents.max_threads` 描述为旧别名，而 `0.153.4` Schema 只暴露 `agents.max_concurrent_threads_per_session`；因此公开示例继续使用规范键。应把这些差异视为文档与 Schema 契约不一致，并分别报告 Schema 接受性与运行时支持。`[desktop]` 表允许附加属性，因此通过 Schema 不代表任意键具有实际运行效果。以上结论已对照当前 [Codex 配置参考](https://learn.chatgpt.com/docs/config-file/config-reference)、[配置 Schema](https://developers.openai.com/codex/config-schema.json) 和 [hooks 文档](https://learn.chatgpt.com/docs/hooks) 核查。

2026-08-31 的治理评审在不新增 Skill 领域的前提下加入价值优先执行契约：明确当前阶段、首要结果和最短证据路径；复用适用门禁；只有已批准范围、已复现缺陷、权威要求或重大风险能够证明必要性时，才新增通用验证、宽泛矩阵或安全加固。该契约属于维护规则和显式 `rd-delivery` 编排器，不应作为常驻正文复制到每个专业 Skill。

## Addy Osmani Agent Skills 选择性吸收

2026-09-17 源码评审固定 [`addyosmani/agent-skills` 的 `be4e44a`](https://github.com/addyosmani/agent-skills/tree/be4e44a9fbc5e8df0beaefadbb28bd22ee61cc39)，并检查其 [MIT 许可证](https://github.com/addyosmani/agent-skills/blob/be4e44a9fbc5e8df0beaefadbb28bd22ee61cc39/LICENSE)。其 25 个 Skill 构成的编码生命周期可用于比较，不是本项目文档交付分类的替代目标。兼容机制均独立表述，没有复制上游 Skill 正文或可执行代码。

| 候选机制与来源 | 决策 | 本项目结果或重新纳入条件 |
|---|---|---|
| [压力用例](https://github.com/addyosmani/agent-skills/blob/be4e44a9fbc5e8df0beaefadbb28bd22ee61cc39/evals/README.md)与抵抗跳过检查的合理化借口 | 吸收为评估材料 | 为静态证据过度声明、先前评审者锚定增加正常／压力配对。未发现实际缺口时，不给每个 Skill 增加反合理化表格。 |
| [独立评审纪律](https://github.com/addyosmani/agent-skills/blob/be4e44a9fbc5e8df0beaefadbb28bd22ee61cc39/skills/code-review-and-quality/SKILL.md)与[约束纪律](https://github.com/addyosmani/agent-skills/blob/be4e44a9fbc5e8df0beaefadbb28bd22ee61cc39/skills/constraint-driven-development/SKILL.md) | 改造为文档证据和权限检查 | 逐项复核继承的 findings；配对测试未批准验收降标与有效的有限试点批准、例外。保留历史失败，不虚构绝对禁止调整需求的规则。 |
| [新项目与既有项目采用路径](https://github.com/addyosmani/agent-skills/blob/be4e44a9fbc5e8df0beaefadbb28bd22ee61cc39/README.md) | 缩小范围后吸收 | 两类项目均从实际交付物开始，保留既有权威与批准。即使安装器管理全部九个 Skills，也可逐步使用。 |
| 整套编码生命周期、元路由、常驻 hooks、强制 reviewer／跨模型步骤、95% 数值信心目标 | 不采纳 | 没有独立文档交付缺口能证明新增范围、加载成本或未经支撑的确定性有必要；保留专业分工与基于证据的完成标准。 |
| 上游路由评分器和行为运行器 | 不导入 | 已检查的路由 tokenizer 过滤中文，description 正则将折叠 YAML 读成 `>-`；行为运行器向 Claude 显式提供 Skill 文本，其分数不能证明本项目多语言路由或净收益。出现可复现路由缺陷并明确适用比较后再考虑。 |
| Plugin 打包、能力地图、变更否决账本 | 延期 | 实际分发需求出现时再评估打包；反复发生责任归属或发现失败时再评估地图；既有决策记录无法覆盖、且反复重审重要替代方案时再评估账本。不默认增加竞争性权威。 |

[有边界的 Codex 试验](agent-skills-pilot.md)对现有 `rd-research`、`rd-review` 文本执行六个中文用例，由任务代理进行语义评分，24/24 条断言通过。未发现可归因的指令缺口，因此正文、description、路由与权限不变。完整输出与评分依据作为持久证据保存在仓库中。这是每例一次的观察，不是独立基准、原生发现测试、跨客户端结果或因果改善证明，也没有无 Skill 对照。其他评审者报告的运行数量未被重新执行，也未作为本项目执行证据。

## 已实施质量控制

- 每个 Skill 至少包含 8 个正向/近邻负向触发用例，正负各不少于 3 个；2026-08-31 英文和中文 canonical 根目录各有 76 个用例
- 每个 Skill 至少有 3 个输出质量评测；合入已发布的 v1.7.4 设计评估用例后，2026-09-17 英文和中文 canonical 根目录各有 42 个用例：v1.7.4 的 36 个加上六个配有 fixture 的吸收用例。此前试验基线包含这六个在内共 41 个。
- `rd-requirement`、`rd-research`、`rd-review`、`rd-writing` 和 `rd-delivery` 使用聚焦的 `references/`
- `agents/openai.yaml` 提供 UI 元数据且不声明 MCP 依赖；专业 Skill 保持默认调用策略
- 只有 `rd-delivery` 要求请求内容明确提出编排；不再使用将其限制为点名调用的平台专用开关
- 全局 `AGENTS.md` v7.8 常驻真实性纪律、响应模式、价值优先执行、上下文健康、执行效率与上下文卫生、输出前审核、输出规则、证据状态边界、“无需修改”合法性、有边界的实现纪律、既有行为与指令面保护、验证失败归因、任务路由和按领域划分的精简基线，不复制完整 Skill 工作流；Skill 未被选择或不可用时会显式降级，而不是丢失控制面
- Codex 和 Claude 控制面区分文档、源码、静态/生效配置、运行和生产验收，并接受有证据支撑的“无需修改”结论
- 英文和中文两棵 Skill 权威源保留按请求内容判断的 `rd-delivery` 调用契约；安装与打包直接读取这些源，不维护平台 Skill 镜像
- PowerShell 安装脚本把替换范围限制在声明的 9 个 Skills，校验备份和暂存树，在替换失败时恢复原安装，并支持只读的安装树精确检查
- 仓库验证使用真实 YAML、TOML、JSON 和 JSON Schema Parser，再检查 Skill 结构与 reference、LF 换行、规定的双语一致性、价值优先与证据契约、Codex 示例的 Schema/运行基线语义、跨平台推理治理、Context7 版本一致性、平台提示词前缀、Claude Bash/PowerShell 权限与 attribution、Unix 安装前置条件、维护者/上下文/提示词契约、当前 GSD 归属以及 `.tmp/local/` 边界
- 独立的[负向回归脚本](../../scripts/test-validator.ps1)验证当前 Skill、规则、配置、提示词、安装与归属契约，并检查已退役的 Cursor 源目录不得恢复

JSON eval 文件只定义路由与输出期望，本身不会执行模型。2026-09-17 试验仅为六个中文用例提供有边界的执行证据。运行评测应先做环境和认证 smoke test，再做变更面用例与相关回归；只有共享路由、公共契约、发布决策、已观察到跨表面风险或用户明确要求时，才运行 Codex/Claude 的完整带 Skill 与对照矩阵。按实际达到的证据层级记录选择、断言、Token 和耗时。因此，下一次 description 修改应来自真实误触发、漏触发、步骤过早结束、交接断裂、权威记录重复或低质量输出。没有独立可触发的交付物或工作流证据就继续增加顶层 Skill，属于推测性扩展。
