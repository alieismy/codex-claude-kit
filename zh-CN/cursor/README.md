# Cursor 简体中文适配包

本目录提供 Cursor 用户规则模板、项目原生 MDC 规则、选配 MCP 示例和提示词；Skills 从 `zh-CN/skills/` 单源维护。英文权威适配位于 `cursor/`，所有中文载体统一在 `zh-CN/cursor/`。

```text
zh-CN/cursor/
  README.md
  global/RULES.md.template
  project/rules/*.mdc.template
  project/mcp.example.json
  project/PROMPTS.md
```

源目录不作为活动客户端配置。安装项目规则时去掉 `.template`，目标 `.cursor/rules/*.mdc`；`00-global-principles` 是项目常驻规则，其他九条根据触发描述按需加载。全局模板的选定内容在 Customize → Rules 中加入用户偏好，作用于所有项目；官方还区分本机 `~/.cursor/rules` 文件与账号同步 User Rules。[官方 rules](https://cursor.com/docs/rules)、[规则 FAQ](https://cursor.com/help/customization/rules)

安装前分别选语言、规则范围、settings/MCP 和 Skill 来源。项目规则复制配方不会复制 Skills。完整 Bash/PowerShell 命令及目标已存在时的备份/合并边界见[安装说明](../docs/installation.md#cursor-适配包)，旧路径对应关系见[布局迁移](../docs/layout-migration.md)。

## Skills 与多客户端共装

Cursor 官方支持项目/用户 `.agents/skills/`、`.cursor/skills/`，并兼容 `.claude/skills/` 和 `.codex/skills/` 对应根。同名来源优先级与去重未明确定义。已有 Codex 用户级 RD Skills 时默认复用明确的 shared 来源，不再安装 `.cursor/skills` 同名树；项目/团队可从中文共享源单独安装。不要把“源内容相同”当作“运行已去重”。[官方 Skills](https://cursor.com/docs/skills)

Cursor 会读取 `CLAUDE.md` 并常驻应用，合装 Claude 适配时应核对其影响。嵌套 `AGENTS.md` 适用所在目录及后代，较具体规则优先。原生载体与同名 Skill 的实际选择仍须在目标 Cursor 新会话核验；本轮没有真实 Cursor 客户端验证。[官方规则 FAQ](https://cursor.com/help/customization/rules)

用户 `.agents/skills` 在本机可被发现，不自动进入 Cloud Agents、远程 SSH 或 self-hosted workers。本轮未扩展完整 CLI/cloud 支持；Cursor CLI 使用自身 `~/.cursor/cli-config.json`、项目 `.cursor/cli.json`（仅 permissions），不能把项目规则或 MCP 示例当作全部客户端 settings。[CLI configuration](https://cursor.com/docs/cli/reference/configuration)

## 选配 MCP

`project/mcp.example.json` 只含 Context7。审查用途、数据流和凭据后，手动合并到项目 `.cursor/mcp.json` 或用户 `~/.cursor/mcp.json`；不要覆盖既有 MCP 文件。在宿主环境中设置 `CONTEXT7_API_KEY`。示例通过该凭据型 server 自己的 `env` 对象，只向它映射一个 API key；不得改用共享 `envFile`，也不得把 key 放入命令参数。修改宿主环境变量后应重启 Cursor，再在 UI 中重新检查 MCP 状态。实际解析的 npm 版本与连接仍需单独验收。[官方 MCP](https://cursor.com/docs/mcp)

不要把 `disabled`、`alwaysAllow` 等未确认字段加入公开示例，也不要把 MCP 路由候选目录一次复制成配置。IDE 设置、用户规则、MCP、CLI permissions 的载体与作用域各不相同。
