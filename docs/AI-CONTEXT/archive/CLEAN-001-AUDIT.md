# CLEAN-001：历史文档、日志与旧记忆机制清理审计

- 审计日期：2026-05-28
- 审计类型：只读审计
- 文件修改：无
- 文件删除：无
- 文件移动：无
- 测试运行：无
- 项目创建：无

本次审计只读取当前仓库中的上下文、记忆、日志、路线图、报告与状态相关文件，用于判断它们与 `docs/AI-CONTEXT/` 的边界。审计过程中未修改、未删除、未移动文件，未运行测试，未创建项目。

## 1. 扫描范围

实际查看了：

- `docs/AI-CONTEXT/`
- `docs/AI-CONTEXT/archive/`
- `docs/`
- `docs/reports/`
- `workflow/feedback/`
- `workflow/execution/`
- `workflow/theory/`
- `workflow/agents/feedback-observer.md`
- `workflow/agents/evolution-runner.md`
- `workflow/hooks/check-evolution.sh`
- `workflow/hooks/detect-feedback-signal.sh`
- `projects/`
- `projects/_template/`
- `projects/huanghe-minsu-horror-001/` 的状态、日志、记忆文件
- 根目录 `README.md`
- `AGENTS.md`

## 2. 当前上下文 / 记忆 / 日志相关文件清单

| 文件路径 | 当前用途 | 是否仍有效 | 是否与 AI-CONTEXT 重复 | 建议处理方式 |
|---|---|---:|---:|---|
| `docs/AI-CONTEXT/README.md` | 新会话上下文入口 | 是 | 否 | 保留，作为权威入口 |
| `docs/AI-CONTEXT/CURRENT-STATE.md` | 当前状态与下一步 | 是 | 否 | 保持短小，继续保留 |
| `docs/AI-CONTEXT/BACKLOG.md` | 长期任务清单 | 是 | 否 | 保留，但后续控制长度 |
| `docs/AI-CONTEXT/LAST-TASK.md` | 最近任务摘要 | 是 | 否 | 保留，默认读取 |
| `docs/AI-CONTEXT/archive/ARCH-001-AUDIT.md` | ARCH-001 长审计归档 | 是 | 否 | 保留，按 ARCH-002 读取 |
| `docs/CODEX-HANDOFF-SUMMARY.md` | 旧新会话接力摘要 | 部分有效 | 是 | 建议归档或标记 deprecated |
| `docs/SHELL-OPTIMIZATION-ROADMAP.md` | 旧壳子优化大纲 / 接力文件 | 部分有效 | 是 | 建议归档为 old-roadmap |
| `docs/SHELL-BUILD-PLAN.md` | 壳子维护路线图 | 部分有效 | 部分重复 | 保留但不作为默认上下文 |
| `docs/README.md` | docs 目录入口 | 是 | 部分重复 | 保留，但后续需同步 LAST-TASK/archive 规则 |
| `README.md` | 项目总览 | 是 | 轻微重复 | 保留，非默认深上下文 |
| `AGENTS.md` | Codex 启动与协作规则 | 是 | 部分重复 | 保留；后续需同步 LAST-TASK |
| `docs/reports/*` | 历史阶段报告、验证记录、运行日志 | 是，历史有效 | 否 | 保留为历史记录，不默认读取 |
| `docs/reports/HUANGHE-FORMAL-PROJECT-RUN-LOG.md` | 正式项目历史运行日志 | 历史有效 | 与项目 `RUN-LOG.md` 部分重复 | 作为历史报告保留，不默认读取 |
| `docs/reports/CURRENT-BACKUP-NOTE.md` | 旧备份建议 | 部分过时 | 是 | 建议归档或 deprecated |
| `workflow/execution/memory-update-protocol.md` | 项目记忆更新协议 | 是 | 否 | 不能删，workflow 依赖 |
| `workflow/theory/continuity-memory.md` | 连续性与项目记忆原则 | 是 | 否 | 不能删，方法论依赖 |
| `workflow/feedback/README.md` | 反馈目录说明 | 是 | 否 | 不能删，feedback 机制依赖 |
| `workflow/feedback/feedback-index.md` | 反馈索引 | 是 | 否 | 不能删，workflow 依赖 |
| `workflow/feedback/proposals/*` | 进化提案机制 | 是 | 否 | 不能删 |
| `projects/_template/PROJECT-STATE.json` | 项目机器状态模板 | 是 | 否 | 不能删，项目恢复依赖 |
| `projects/_template/RUN-LOG.md` | 单项目运行日志模板 | 是 | 否 | 不能删，项目恢复依赖 |
| `projects/_template/PROJECT-MEMORY.md` | 单项目长期记忆模板 | 是 | 否 | 不能删，项目连续性依赖 |
| `projects/_template/scripts/SCRIPT-STATUS.md` | 单项目正文状态模板 | 是 | 否 | 不能删，门禁/状态依赖 |
| `projects/*/PROJECT-STATE.json` | 项目实际状态 | 是 | 否 | 不能删 |
| `projects/*/RUN-LOG.md` | 项目实际运行日志 | 是 | 否 | 不能删 |
| `projects/*/PROJECT-MEMORY.md` | 项目实际长期记忆 | 是 | 否 | 不能删 |

## 3. 建议保留文件

建议继续保留：

- `docs/AI-CONTEXT/*`：当前新会话上下文权威入口。
- `AGENTS.md`：Codex 启动硬规则入口。
- `README.md`：项目总览，不应承载长上下文。
- `docs/README.md`：文档目录入口。
- `docs/SHELL-SPEC.md`、`docs/SHELL-BOUNDARY.md`、`docs/GENRE-SKILL-CONTRACT.md`、`docs/KNOWLEDGE-LAYERING.md`：架构与合约仍是权威文档。
- `workflow/execution/*`、`workflow/theory/*`、`workflow/feedback/*`：属于运行机制，不是旧记忆垃圾。
- `projects/_template/PROJECT-STATE.json`、`RUN-LOG.md`、`PROJECT-MEMORY.md`、`SCRIPT-STATUS.md`：项目级恢复机制核心文件。
- `projects/<project>/PROJECT-STATE.json`、`RUN-LOG.md`、`PROJECT-MEMORY.md`：具体项目事实与断点恢复依据。

## 4. 建议归档文件

本次审计不移动文件，只提出建议：

- `docs/CODEX-HANDOFF-SUMMARY.md` → `docs/archive/old-handoff/`
  - 原因：已被 `docs/AI-CONTEXT/` 替代，且下一步建议已经不是当前权威状态。

- `docs/SHELL-OPTIMIZATION-ROADMAP.md` → `docs/archive/old-roadmap/`
  - 原因：内容很长，兼有历史总结、旧接力、路线图，容易污染默认上下文。

- `docs/reports/CURRENT-BACKUP-NOTE.md` → 保留在 `docs/reports/` 或后续归入 `docs/archive/old-backup/`
  - 原因：备份建议与旧 smoke test 状态相关，当前只作历史记录。

- `docs/reports/HUANGHE-FORMAL-PROJECT-RUN-LOG.md` → 保留在 `docs/reports/`
  - 原因：它是历史项目报告，不应和项目内 `RUN-LOG.md` 合并。

## 5. 建议标记 deprecated 的文件

建议后续标记 deprecated，而不是删除：

- `docs/CODEX-HANDOFF-SUMMARY.md`
  - 原因：文件自称“新会话可先读取”，与 `AI-CONTEXT` 新入口冲突。

- `docs/SHELL-OPTIMIZATION-ROADMAP.md`
  - 原因：文件也自称“后续会话接力文件”，与当前入口冲突；但内容有历史价值。

- `docs/reports/CURRENT-BACKUP-NOTE.md`
  - 原因：描述的是旧黄河 Skill v2 验收后的备份状态，不适合作为当前状态来源。

## 6. 建议合并的文件

- `docs/CODEX-HANDOFF-SUMMARY.md` 的仍有效信息，合并到：
  - 当前状态：`docs/AI-CONTEXT/CURRENT-STATE.md`
  - 历史说明：`docs/AI-CONTEXT/archive/` 或 `docs/archive/old-handoff/`

- `docs/SHELL-OPTIMIZATION-ROADMAP.md` 的仍有效设计原则，合并到：
  - 架构边界：`docs/SHELL-BOUNDARY.md`
  - 当前任务：`docs/AI-CONTEXT/BACKLOG.md`
  - 历史归档：`docs/archive/old-roadmap/`

- `README.md`、`docs/README.md`、`AGENTS.md` 的新会话入口规则需要同步：
  - 当前 `AI-CONTEXT/README.md` 已要求读 `LAST-TASK.md`
  - 但 `AGENTS.md` 与 `README.md` 仍只提前三个 AI-CONTEXT 文件

## 7. 绝对不能删除的文件

- `projects/_template/PROJECT-STATE.json`
- `projects/_template/RUN-LOG.md`
- `projects/_template/PROJECT-MEMORY.md`
- `projects/_template/scripts/SCRIPT-STATUS.md`

原因：这些是项目级恢复、状态校验、连续性记忆和门禁状态的基础。

- `workflow/execution/memory-update-protocol.md`
- `workflow/theory/continuity-memory.md`

原因：它们定义项目记忆机制，不与 AI-CONTEXT 冲突；AI-CONTEXT 是仓库级上下文，PROJECT-MEMORY 是项目级记忆。

- `workflow/feedback/README.md`
- `workflow/feedback/feedback-index.md`
- `workflow/feedback/proposals/README.md`
- `workflow/feedback/proposals/TEMPLATE.md`
- `workflow/agents/feedback-observer.md`
- `workflow/agents/evolution-runner.md`
- `workflow/hooks/check-evolution.sh`
- `workflow/hooks/detect-feedback-signal.sh`

原因：这些是反馈进化机制资产，不是普通历史日志。

- `docs/reports/*`

原因：它们是历史验证证据。可以保持非默认读取，但不应删除。

## 8. 清理优先级

### P0

- 解决新会话入口冲突：`AGENTS.md`、`README.md`、`docs/README.md` 是否都应同步 `LAST-TASK.md`。
- 标记或归档 `docs/CODEX-HANDOFF-SUMMARY.md`，避免继续自称新会话入口。
- 标记或归档 `docs/SHELL-OPTIMIZATION-ROADMAP.md`，避免继续自称接力文件。

### P1

- 整理 `docs/reports/` 的入口说明，明确全部为历史报告，不进入默认上下文。
- 判断 `docs/SHELL-BUILD-PLAN.md` 与 `AI-CONTEXT/BACKLOG.md` 的边界：前者做壳子维护路线，后者做当前任务清单。
- 更新 `docs/README.md` 的核心文档列表，避免把旧 handoff 和新 AI-CONTEXT 并列为同级入口。

### P2

- 后续再评估旧项目日志与项目内 `RUN-LOG.md` 的重复，不建议现在动。
- 后续再评估是否建立 `docs/archive/old-handoff/`、`docs/archive/old-roadmap/`。
- 后续再评估 docs/reports 是否需要索引化。

## 9. 下一步建议

- CLEAN-001 应归档到 `docs/AI-CONTEXT/archive/`，本文件即为该归档。
- 需要新增 `CLEAN-002` 执行清理，范围应限于文档入口与归档标记，不碰 `workflow/`、`scripts/`、`genre-skills/`、`projects/` 或 `projects/_template/`。
- 建议先清理再做 ARCH-002。原因是当前仍存在多个“新会话入口 / 接力文件”互相竞争，继续做 ARCH-002 会让上下文来源更乱。
- 推荐下一步执行：`CLEAN-002：归档旧 handoff / old roadmap，并同步入口文档的新会话读取规则`。

## 10. 明确结论

- `CLEAN-001` 已完成。
- 下一步不是 `ARCH-002`。
- 下一步建议是 `CLEAN-002`。
- `CLEAN-002` 的范围应限于文档入口同步、旧 handoff / old roadmap 的归档或 deprecated 标记。
- `CLEAN-002` 不应触碰 `workflow/`、`scripts/`、`genre-skills/`、`projects/` 或 `projects/_template/`。
