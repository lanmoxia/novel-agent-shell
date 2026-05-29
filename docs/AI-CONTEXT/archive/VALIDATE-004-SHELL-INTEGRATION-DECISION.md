# VALIDATE-004：顶层 validate-shell 接入决策审计

- 任务编号：VALIDATE-004
- 任务名称：决定是否把教辅模板专用校验接入顶层 validate-shell
- 审计日期：2026-05-29
- 当前状态：已完成

## 1. 审计范围

本轮只做接入决策审计，不修改顶层 shell 校验脚本，不运行顶层 shell 校验。

审计范围：

- 分析 `validate-shell.sh` 当前调用链。
- 分析 `validate-shell.ps1` 当前调用链。
- 判断 `scripts/validate-edu-shortdrama-template.sh` 是否适合接入顶层校验。
- 判断 Bash / PowerShell 顶层校验的接入策略。
- 判断接入是否会重新引入 `.claude/` 噪声。
- 判断接入是否会影响旧项目校验和 `_template-edu-shortdrama` 的模板边界。

## 2. 读取文件列表

本轮只读取以下文件：

- `docs/AI-CONTEXT/README.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/archive/VALIDATE-002-FIX.md`
- `docs/AI-CONTEXT/archive/VALIDATE-003-EDU-TEMPLATE-VALIDATION.md`
- `scripts/validate-shell.sh`
- `scripts/validate-shell.ps1`
- `scripts/validate-edu-shortdrama-template.sh`
- `scripts/validate-projects.sh`
- `scripts/validate-project-state.sh`
- `scripts/validate-project-state.ps1`

未读取：

- Codex 全局 memory。
- `.claude/`。
- `workflow/settings*.json`。

## 3. 当前 `validate-shell.sh` 调用链

`validate-shell.sh` 当前是 Bash 顶层仓库校验入口，主要流程如下：

1. 检查仓库结构：`workflow/`、`docs/`、`genre-skills/`、`projects/_template/` 等。
2. 检查 workflow hook 脚本存在，并对 hook 和部分脚本执行 `bash -n` 语法检查。
3. 探测 `.claude/` 是否存在；如果存在，输出 warning。
4. 调用 `bash "$ROOT_DIR/scripts/validate-workflow-assets.sh"`。
5. 内联检查旧项目模板 `projects/_template/` 的文件和目录结构。
6. 调用 `bash "$ROOT_DIR/scripts/validate-projects.sh"`。
7. 调用 `bash "$ROOT_DIR/scripts/validate-project-state.sh"`。
8. 检查文档入口文件。
9. 调用 `bash "$ROOT_DIR/scripts/validate-genre-skills.sh"`。

当前没有调用：

- `scripts/validate-edu-shortdrama-template.sh`

## 4. 当前 `validate-shell.ps1` 调用链

`validate-shell.ps1` 当前是 PowerShell 顶层仓库校验入口，主要流程如下：

1. 检查仓库结构和关键文件。
2. 探测 `.claude/` 是否存在；如果存在，输出 warning。
3. 内联检查 workflow skills / agents / hooks / scripts。
4. 如果可用，使用 `bash -n` 检查 hook 语法。
5. 内联检查旧项目模板 `projects/_template/` 的文件和目录结构。
6. 内联遍历 active projects，并跳过 `_template`、`_template-edu-shortdrama`、`test-*`、`*-smoke-test`。
7. 调用 `powershell -NoProfile -ExecutionPolicy Bypass -File scripts\validate-project-state.ps1`。
8. 检查文档入口文件。
9. 内联检查 `genre-skills/` frontmatter。

当前没有调用：

- `scripts/validate-edu-shortdrama-template.sh`

也没有 PowerShell 等价的教辅模板专用校验入口。

## 5. 教辅模板专用校验脚本现状

现有脚本：

```bash
scripts/validate-edu-shortdrama-template.sh
```

当前能力：

- 固定校验 `projects/_template-edu-shortdrama/`。
- 校验模板目录结构。
- 校验必需文件存在。
- 校验 `PROJECT-STATE.json` 是合法 JSON。
- 校验教辅模板字段和关键 `confirmedArtifacts` 键。
- 校验核心模板文件包含原文、白话、教学目标、Scene、字幕、分镜、capabilities、最终剧本 / 生产稿包边界等语义。
- 明确不检查真实项目状态，例如 `locked`、`reviews/final-review.md`、真实 RUN-LOG 运行记录、Phase 7、LOCK-MANIFEST。

本轮非顶层验证结果：

| 命令 | 结果 |
| ---- | ---- |
| `bash scripts/validate-edu-shortdrama-template.sh` | 通过，0 error，0 warning |
| `bash scripts/validate-projects.sh` | 通过，0 error，0 warning |
| `bash scripts/validate-project-state.sh` | 通过，0 error，0 warning |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-project-state.ps1` | 通过，0 error，0 warning |

## 6. 接入方案 A / B / C / D 对比

| 方案 | 内容 | 优点 | 风险 / 缺点 | 判断 |
| ---- | ---- | ---- | ---- | ---- |
| A | 暂不接入顶层，只保持独立脚本 | 无顶层变动风险；继续避免 `.claude/` 顶层噪声 | 顶层校验无法覆盖教辅模板专用规则，容易被漏跑 | 不推荐作为长期方案 |
| B | 只接入 `validate-shell.sh`，PowerShell 暂不接 | Bash 顶层能覆盖教辅模板；实现成本较低 | Bash / PowerShell 顶层能力不一致 | 可接受但不优先 |
| C | Bash 和 PowerShell 顶层都接入，但 PowerShell 需要等价校验入口 | 顶层校验覆盖一致；职责清晰；旧项目校验与教辅模板校验分离 | 需要设计 PowerShell 等价入口，或明确 PowerShell 调用 Bash 脚本的前提 | 推荐 |
| D | 暂不接入，先重构顶层 shell 校验的 `.claude/` 探测边界 | 能先处理顶层校验噪声 | 会继续让教辅模板专用校验停留在独立脚本，接入价值延后 | 不作为本轮主推荐 |

## 7. 推荐方案

推荐方案 C：Bash 和 PowerShell 顶层都接入教辅模板专用校验，但 PowerShell 需要等价校验入口或明确调用 Bash 脚本的前提。

推荐后续主任务：

`VALIDATE-005`：将教辅模板专用校验接入顶层 validate-shell。

建议 `VALIDATE-005` 的实施原则：

- 不在本轮直接接入。
- 不修改教辅模板。
- 不改变旧项目校验对 `_template-edu-shortdrama` 的跳过行为。
- 不新增 `.claude/` 读取或探测逻辑。
- Bash 顶层可调用 `scripts/validate-edu-shortdrama-template.sh`。
- PowerShell 顶层应优先使用等价 PowerShell 校验入口；如果选择调用 Bash 脚本，应明确 Bash 依赖和 fallback 行为。

## 8. 建议接入的条件

建议接入，但需要满足以下条件：

- 教辅模板校验作为独立步骤接入，而不是并入真实项目校验。
- 接入点应位于旧 `projects/_template/` 检查之后、active projects 检查之前或之后均可，但必须保持职责独立。
- 接入失败只表示教辅模板结构 / 字段 / 边界校验失败，不应被解释为真实项目状态失败。
- PowerShell 顶层不能只靠 Bash 入口假定所有环境都有 Bash，除非脚本显式检测 Bash 并给出清晰 warning / fallback。
- 不应为接入而触碰 `.claude/` 探测逻辑。

## 9. 对 `.claude/` 探测风险的判断

接入教辅模板专用校验本身不会重新引入 `.claude/` 噪声。

原因：

- `scripts/validate-edu-shortdrama-template.sh` 不读取 `.claude/`。
- `validate-projects.sh` 和 `validate-project-state.*` 已经把 `_template-edu-shortdrama` 与真实项目校验分离。
- `.claude/` warning 目前来自 `validate-shell.sh` / `validate-shell.ps1` 现有顶层探测逻辑，而不是教辅模板校验。

风险判断：

- 如果运行顶层 `validate-shell.*`，仍可能看到既有 `.claude/` warning。
- `VALIDATE-005` 不应修改或扩大 `.claude/` 探测。
- `.claude/` 探测边界如需调整，应另开任务，而不是混入教辅模板校验接入。

## 10. 对旧项目校验的影响判断

推荐接入不会破坏旧小说 / 剧本模板校验，前提是保持职责分离：

- `projects/_template/` 继续由现有顶层模板检查覆盖。
- `projects/_template-edu-shortdrama/` 继续不进入真实项目校验。
- `validate-projects.sh` 和 `validate-project-state.*` 继续只负责真实项目 / active project 状态。
- 教辅模板专用脚本只负责教辅模板结构、字段和生产稿包边界。

## 11. 对 `_template-edu-shortdrama` 的影响判断

推荐接入不会让 `_template-edu-shortdrama` 再次被当成真实项目。

原因：

- `VALIDATE-002-FIX` 已让旧项目校验跳过 `_template-edu-shortdrama`。
- `VALIDATE-003` 新增的是独立模板校验脚本，不要求真实项目的 `locked`、`final-review`、RUN-LOG 运行记录或 Phase 7。
- 接入顶层时只应调用专用模板校验，不应把目录重新加入 active projects 遍历。

## 12. 后续任务建议

只推荐一个主任务：

`VALIDATE-005`：将教辅模板专用校验接入顶层 validate-shell。

建议任务范围：

- 修改 `validate-shell.sh`，调用 `scripts/validate-edu-shortdrama-template.sh`。
- 为 `validate-shell.ps1` 增加等价接入策略：优先新增 PowerShell 等价校验入口，或明确检测并调用 Bash 脚本。
- 不运行或修改 `.claude/` 相关逻辑。
- 不修改 `projects/_template-edu-shortdrama/`。
- 接入后验证顶层调用链是否仍保持旧项目校验与教辅模板校验职责分离。
