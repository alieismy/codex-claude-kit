# 仓库维护者发布检查清单

本清单只治理本仓库自身的发布，不属于 RD Skill 工作流，也不会把编码、测试执行、部署或发布操作扩展为 Skills 面向用户的交付职责。

Commit、push、Pull Request 变更、merge、创建 tag 和发布 GitHub Release 都是外部写入。只有获得本次具体发布的明确授权后才能执行。

## 1. 固定发布身份与授权

- [ ] 记录目标版本、发布标题、目标分支、目标 commit、发布类型，以及是否为 Draft 或 Prerelease。
- [ ] 确认谁授权 commit、push、merge、tag、发布资产和公开 Release。
- [ ] 明确本次包含的改动集合，并显式排除无关本地工作。
- [ ] 确认 `CHANGELOG.md`、兼容性结论、归属、许可证和安全说明覆盖本次发布。
- [ ] 不得把此前的编辑或验证请求推断为发布授权。

## 2. 固化精确仓库状态

运行并保留相关输出：

```powershell
git rev-parse --show-toplevel
git branch --show-current
git status --short --branch
git remote -v
git log -1 --oneline --decorate
git diff --name-status
git diff --cached --name-status
git status --short --ignored -- .tmp/local/
```

- [ ] 分别盘点已修改、已删除、未跟踪、已忽略和已暂存路径。
- [ ] 保留或分享 remote URL 与状态输出前，隐藏其中的凭据和非必要私有标识。
- [ ] 确认暂存内容与发布范围完全一致，不能只依赖概括性 clean 状态。
- [ ] 检查 `.tmp/local/` 和其它任务本地目录；它们不是发布资产，也不得保存所需证据或恢复数据的唯一副本。
- [ ] 保留无关用户改动，不得为简化发布而清理或 reset。

## 3. 重新核查易漂移事实与证据边界

- [ ] 兼容性主张变化时，重新查询当前包/CLI 版本并检查实际安装运行时。
- [ ] 每项新兼容性结论记录版本、日期、平台、配置、命令、预期、观察结果和限制。
- [ ] 区分文档声明、源码实现、静态配置、最终生成/实际生效配置、运行状态、业务/生产验收。
- [ ] 当前证据不支持版本或行为变更时，把“无需修改”作为有效结论。
- [ ] 确认全部 Codex Context7 示例使用相同的不带版本后缀包名，中英文兼容性记录中的历史已测试版本和当前 registry 版本一致。
- [ ] 确认仓库内 Codex Schema 元数据记录版本、tag 固定来源、实时来源、获取日期、字节数、SHA-256 摘要和许可证。
- [ ] 核对中英文语义以及 Codex/Claude 适配一致性，同时保留已记录的平台差异。

## 4. 检查内容与供应链卫生

- [ ] 扫描最终 diff 中的凭据、token、私有端点、cookie、连接字符串、个人路径、机器标识和非必要基础设施信息。
- [ ] 确认生成物、缓存、依赖目录、覆盖率输出、本地日志和下载包未被纳入，除非它们是明确发布资产。
- [ ] 确认每个新增依赖、外部来源、复制资产和归属都有明确理由与许可证依据。
- [ ] 检查链接、版本引用、文档状态、权威指针和发布资产名称。
- [ ] 核对共享项目核、`.template` 源文件及所有中文平台目录；安装目标必须使用原生文件名，不将模板目录作为活动项目配置。
- [ ] 确认 Skills 只维护 `skills/` 与 `zh-CN/skills/`，可选安装和 claude.ai 打包从这两源取文件；账号缓存仅用于只读比较，不编辑或重新作为源打包。
- [ ] 按[布局迁移说明](layout-migration.md)核对旧路径引用。保留历史证据路径；规则、settings/MCP、Skills 选择相互独立，公共使用不得依赖个人全局安装。

- [ ] 检查最终 diff 是否存在无关格式、断裂引用、重复权威记录、过期镜像和本机假设。

## 5. 运行仓库门禁

暂存前必须运行：

```powershell
python -m pip install -r requirements-validation.txt
pwsh ./scripts/validate.ps1
pwsh ./scripts/test-validator.ps1
git diff --check
```

必须执行的联网与运行时发布门禁：

```powershell
pwsh ./scripts/validate-release.ps1
```

- [ ] 记录每条命令、退出码、重要输出和环境。
- [ ] 诊断命令自身失败时先修复再重跑；解析、引用、网络或工具失败不等于检查通过。
- [ ] 修改 Skills 且官方 Skill Validator 可用时，在 UTF-8 环境下检查 9 个英文和 9 个中文主 Skills，并记录 Validator 的准确来源/版本。
- [ ] 使用 Python 3.9+ 和固定的验证依赖；用适当的真实解析器解析发生变化的 JSON、YAML 和 TOML，不能把目视检查当作解析通过。
- [ ] 确认发布门禁已将当前官方 Codex Schema 与仓库快照匹配、使用实时 Schema 验证所有维护的用户/项目示例、使已安装 Codex CLI 版本与 Schema 版本一致，并完成所维护示例清单的隔离 strict-load 检查。
- [ ] 对每项跳过、不可用、不稳定或受环境限制的检查说明原因，并相应收窄发布结论。

## 6. Commit 与 Pull Request

- [ ] 只显式暂存已批准的路径白名单；混合工作区不得使用宽泛的 `git add .`。
- [ ] 暂存后运行 `git diff --cached --name-status`、`git diff --cached --stat`、`git diff --cached --check`，并完整审读 `git diff --cached`。暂存前的 cached 检查不能证明新暂存或此前未跟踪文件。
- [ ] 每个 commit 只包含一个逻辑变更，并使用祈使语气的 Conventional Commit；只有项目真实使用 Jira 且已提供真实 ID 时才加入 Jira key。
- [ ] 默认 push 到评审分支，不直接 push 默认分支；用户明确授权其它流程时除外。
- [ ] 核对 Pull Request 的 base/head、commit 列表、文件数、生成 diff 和发布说明。
- [ ] 等待必需 checks 结束并记录实际输出。
- [ ] 区分绿色状态和实质评审覆盖；记录跳过评审、文件数上限、排除项，或仅证明工作流执行成功的 check。
- [ ] 记录所选 merge 策略和最终 merge commit。

## 7. Tag 与发布

创建 tag 前：

```powershell
git fetch --tags origin
git tag --list "v*"
git show --no-patch --format=fuller <merge-commit>
```

- [ ] 确认版本不与现有本地或远端 tag/Release 冲突。
- [ ] 在已评审的准确 merge commit 上创建 annotated tag，并解引用：

```powershell
git tag -a vX.Y.Z <merge-commit> -m "vX.Y.Z"
git cat-file -t vX.Y.Z
git rev-parse vX.Y.Z
git rev-parse "vX.Y.Z^{}"
```

- [ ] 确认 `git cat-file -t` 返回 `tag`，记录 tag 对象 ID，再在 push 前比较解引用 tag 目标与已批准 merge commit。
- [ ] 只有取得明确发布授权后，才能 push tag 并创建 GitHub Release。
- [ ] 使用 GitHub CLI 时优先采用 `gh release create ... --verify-tag`，使 remote tag 缺失时直接失败，而不是由 Release 命令静默创建。
- [ ] 有意设置并复核 Draft/Prerelease 状态，不默认接受工具缺省值。
- [ ] 只附加已评审资产；有资产时记录文件名、大小、来源和 SHA-256 校验值。
- [ ] GitHub 自动生成的源码归档只有实际下载并检查后，才能称为单独验证过的资产。

## 8. 验证远端结果

```powershell
gh release view vX.Y.Z --json tagName,name,isDraft,isPrerelease,targetCommitish,url,assets
git ls-remote origin "refs/tags/vX.Y.Z" "refs/tags/vX.Y.Z^{}"
```

- [ ] 核对 Release 名称、URL、目标分支/commit、Draft/Prerelease 状态、资产和校验值。
- [ ] 确认远端 annotated tag 解引用到准确的已评审 merge commit。
- [ ] 确认 Pull Request 已合并，必需 checks 达到最终状态。
- [ ] 记录剩余风险和未取得证据，包括仓库检查未覆盖的真实客户端/运行验收。

## 9. 纠错与不可变规则

- [ ] 公开发布前，只有在明确授权范围内才能修正错误 Draft 或尚未发布的本地 tag，并记录变更。
- [ ] Tag/Release 公开后不得移动或静默替换；应发布新的 patch 版本，或用清晰纠错记录标记旧版本已被替代。
- [ ] 不得把 force-push 或改写共享历史作为发布捷径。
- [ ] 如果疑似已经发布密钥，停止常规发布，撤销/轮换密钥，安全保留事件证据，并进入仓库安全流程。

## 发布证据记录

最终维护者报告必须说明：

- 发布版本、目标分支、已评审 commit、tag 对象和解引用 tag 目标；
- 精确改动/暂存范围以及排除的本地工作；
- 本地门禁、远端 checks、评审覆盖、跳过项及原因；
- 兼容性证据和实际达到的最高证据状态；
- Release URL、Draft/Prerelease 状态、资产和校验值；
- 未解决风险、回退/纠错策略、批准人和发布时间。

只有远端 tag 与 Release 已对照评审 commit 完成核验，且报告区分已验证事实与未验证运行或生产行为，才算发布完成。
