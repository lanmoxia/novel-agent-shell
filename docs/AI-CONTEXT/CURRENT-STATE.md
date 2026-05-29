# 当前项目状态

- 最近更新时间：2026-05-29

## 当前项目定位

本项目原本是小说 / 剧本 Agent 壳子，核心职责是维护可插拔题材 Skill、阶段门禁、审查闭环、项目记忆、运行日志和锁稿后置模块。

当前方向正在向**教辅类 AI 真人古风短剧生产系统**迁移。现阶段还不是重构 `workflow/`、重写阶段门禁或创建新模板，而是先沉淀可插拔 Skill，并建立项目内长期上下文机制，保证新会话可以自动理解目标、状态、待办和禁止事项。

## 迁移方向

- 从通用小说 / 剧本生产壳子，逐步转向教辅类短剧生产系统。
- 当前已存在 `genre-skills/wenyan-skill/`，其定位是文言文教辅真人古风短剧 Skill。
- 顶层 README、docs 和 workflow 仍主要描述旧的小说 / 剧本壳子流程。
- 新方向需要后续分任务审计旧 Phase 语义、Skill 合约、模板结构和验证机制，不能一次性大改。

## 最近完成事项

- 建立 `docs/AI-CONTEXT/` 长期上下文目录。
- 新增新会话入口说明、当前状态文件和长期优化清单。
- 在 `AGENTS.md`、`README.md`、`docs/README.md` 增加轻量入口说明。
- `ARCH-001` 小说流程与教辅短剧流程语义冲突审计已完成，并归档到 `docs/AI-CONTEXT/archive/ARCH-001-AUDIT.md`。
- `CTX-004` 已完成，`docs/AI-CONTEXT/` 已落地最小信息分层：默认入口 + 最近任务摘要 + archive 归档层。
- `CLEAN-001` 历史文档、日志与旧记忆机制清理审计已完成，并归档到 `docs/AI-CONTEXT/archive/CLEAN-001-AUDIT.md`。
- `CLEAN-002` 已完成，旧 handoff / old roadmap 已标记为历史参考，入口文档已同步到 `docs/AI-CONTEXT/` 默认四件套。
- `ARCH-002` 旧 Phase 与教辅短剧 Phase 映射表已完成，并归档到 `docs/AI-CONTEXT/archive/ARCH-002-PHASE-MAPPING.md`。
- `SKILL-001` `wenyan-skill` 与现有 Skill 合约差距审计已完成，并归档到 `docs/AI-CONTEXT/archive/SKILL-001-WENYAN-CONTRACT-AUDIT.md`。
- `TEMPLATE-001` `projects/_template` 教辅短剧适配审计已完成，并归档到 `docs/AI-CONTEXT/archive/TEMPLATE-001-PROJECT-TEMPLATE-AUDIT.md`。
- `TEMPLATE-002` 教辅短剧项目模板字段方案已完成，并归档到 `docs/AI-CONTEXT/archive/TEMPLATE-002-EDU-SHORTDRAMA-FIELD-SPEC.md`。
- `TEMPLATE-003` 教辅短剧项目模板草案已完成，并归档到 `docs/AI-CONTEXT/archive/TEMPLATE-003-EDU-SHORTDRAMA-TEMPLATE-DRAFT.md`。
- `TEMPLATE-004` 已完成，教辅短剧专用模板目录 `projects/_template-edu-shortdrama/` 已新增，未修改旧 `projects/_template/`。
- `CONTRACT-001` 已完成，Skill 合约已扩展教辅生产能力表达，并归档到 `docs/AI-CONTEXT/archive/CONTRACT-001-SKILL-CONTRACT-EXTENSION.md`。
- `WORKFLOW-DOC-001` 已完成，workflow 文档中的教辅 Phase 语义已同步，并归档到 `docs/AI-CONTEXT/archive/WORKFLOW-DOC-001-PHASE-SEMANTIC-SYNC.md`。
- `SKILL-002` 已完成，`wenyan-skill` 已按新合约补强 `version`、`capabilities`、`fallbackRules` 和 `shellBoundary` 元数据，并归档到 `docs/AI-CONTEXT/archive/SKILL-002-WENYAN-METADATA-UPDATE.md`。
- `VALIDATE-001` 已完成现有校验基线记录，并归档到 `docs/AI-CONTEXT/archive/VALIDATE-001-BASELINE.md`；当前验证未完全通过，本轮未修复脚本或模板。
- `VALIDATE-002-AUDIT` 已完成 validate 脚本项目 / 模板目录识别只读审计，并归档到 `docs/AI-CONTEXT/archive/VALIDATE-002-AUDIT.md`；本轮未修改脚本、未运行 validate。
- `VALIDATE-002-FIX` 已完成，旧项目校验已能跳过 `projects/_template-edu-shortdrama/`，并归档到 `docs/AI-CONTEXT/archive/VALIDATE-002-FIX.md`；本轮未修改教辅模板。
- `VALIDATE-003` 已完成，新增 `scripts/validate-edu-shortdrama-template.sh` 教辅模板专用校验脚本，并归档到 `docs/AI-CONTEXT/archive/VALIDATE-003-EDU-TEMPLATE-VALIDATION.md`；本轮未修改教辅模板。
- `VALIDATE-004` 已完成顶层 validate-shell 接入决策审计，并归档到 `docs/AI-CONTEXT/archive/VALIDATE-004-SHELL-INTEGRATION-DECISION.md`；本轮未修改任何脚本，未运行顶层 shell 校验。
- `VALIDATE-005` 已完成，Bash / PowerShell 顶层 `validate-shell` 均已接入教辅模板专用校验，并归档到 `docs/AI-CONTEXT/archive/VALIDATE-005-SHELL-INTEGRATION.md`；本轮未修改教辅模板，未新增 `.claude/` 探测逻辑。
- `WENYAN-SMOKE-001-PLAN` 已完成，文言文教辅短剧烟测方案已归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-001-PLAN.md`；本轮未创建项目，未生成剧本、分镜、字幕或视频提示词。
- `WENYAN-SMOKE-001-RUN-RECOVERY` 已补齐 `projects/wenyan-smoke-liangxiaor-bianri-001/` 的 Phase 0-4 烟测文件，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-001-RUN.md`；Bash / PowerShell 顶层校验失败，当前暂停。
- `VALIDATE-006-EDU-ACTIVE-PROJECT-COMPAT-AUDIT` 已完成 recovery 只读审计，并归档到 `docs/AI-CONTEXT/archive/VALIDATE-006-EDU-ACTIVE-PROJECT-COMPAT-AUDIT.md`；结论是旧 active project 校验尚未按 `projectType` 分流，真实教辅项目实例需要专用校验。
- `VALIDATE-007-EDU-ACTIVE-PROJECT-COMPAT-FIX` 已完成，旧 active project 校验已按 `projectType` 分流，并新增 Bash / PowerShell 教辅真实项目实例专用校验；Bash / PowerShell 顶层 `validate-shell` 均通过 0 error / 0 warning，归档到 `docs/AI-CONTEXT/archive/VALIDATE-007-EDU-ACTIVE-PROJECT-COMPAT-FIX.md`。
- `WENYAN-SMOKE-002-REVIEW` 已完成只读质量审查，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-002-REVIEW.md`；结论是烟测结构和边界合格，但存在 4 个 P1 和 3 个 P2，暂不建议直接进入 Phase 5。
- `WENYAN-SMOKE-003-REVISION-PLAN-RECOVERY` 已完成，已制定 Phase 4 烟测草案修订计划，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-003-REVISION-PLAN.md`；本轮未修改烟测项目，未生成正式产物，未进入 Phase 5。
- `WENYAN-SMOKE-003-REVISION-RUN` 已完成，已按用户确认范围修订 Phase 4 烟测草案，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-003-REVISION-RUN.md`；本轮未修改 `PROJECT-STATE.json`，未进入 Phase 5，未生成正式产物，Bash / PowerShell 顶层校验均通过 0 error / 0 warning。
- `WENYAN-SMOKE-004-REVIEW` 已完成，已复核修订后的 Phase 4 烟测草案质量，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-004-REVIEW.md`；复核结论为 P0=0、P1=0，仅剩不阻塞的 P2 确认项，建议下一步制定 Phase 5 计划。
- `WENYAN-SMOKE-005-PHASE5-PLAN` 已完成，已制定进入 Phase 5 教学与生产审查计划，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-005-PHASE5-PLAN.md`；本轮未进入 Phase 5，未生成 `reviews/final-review.md`，未修改 `PROJECT-STATE.json`，下一步需等待用户确认是否执行 Phase 5。
- `WENYAN-SMOKE-005-PHASE5-RUN` 已完成，已生成 Phase 5 教学与生产审查报告并完成状态同步；教学审查通过，生产边界审查通过，P0=0、P1=0、P2=3；Bash / PowerShell 校验均通过 0 error / 0 warning。
- `WENYAN-SMOKE-006-PHASE6-PLAN` 已完成，已制定进入 Phase 6 的轻量修订计划，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-006-PHASE6-PLAN.md`；本轮未修改烟测项目正文，未修改 `PROJECT-STATE.json`，未进入 Phase 6 执行，未生成正式产物。
- `WENYAN-SMOKE-006-PHASE6-RUN` 已完成，已按用户确认范围执行 Phase 6 轻量修订并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-006-PHASE6-RUN.md`；本轮只处理 3 个 P2，未进入 Phase 7 / 8，未生成正式产物，Bash / PowerShell 校验均通过 0 error / 0 warning。
- `WENYAN-SMOKE-007-REVIEW` 已完成，已复核 Phase 6 轻量修订结果并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-007-REVIEW.md`；复核结论为 P0=0、P1=0，仅剩不阻塞的 P2，建议下一步制定 Phase 7 锁稿前审查计划。
- `WENYAN-SMOKE-008-PHASE7-PLAN` 已完成，已制定 Phase 7 锁稿前审查计划并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-008-PHASE7-PLAN.md`；本轮未执行 Phase 7，未修改 `PROJECT-STATE.json`，未生成 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md`、正式字幕、正式分镜、视频提示词或生产稿包。
- `WENYAN-SMOKE-008-PHASE7-RUN` 已完成，已生成 Phase 7 锁稿前审查报告并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-008-PHASE7-RUN.md`；审查结论为 P0=0、P1=0、P2=1，具备进入 Phase 8 锁稿计划制定的条件；本轮未生成 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md`、正式字幕、正式分镜、视频提示词或生产稿包。

## 当前暂停事项

- 暂停重构 `workflow/`。
- 暂停修改 `scripts/`。
- 暂停修改 `genre-skills/`。
- 暂停修改 `projects/` 和 `projects/_template/`。
- 暂停运行现有生成流程、Skill 测试或创建测试项目。

## 当前主要问题

- 核心文档、Skill、模板、workflow 语义已初步对齐：`wenyan-skill`、`projects/_template-edu-shortdrama/`、`docs/GENRE-SKILL-CONTRACT.md` 和 workflow 文档都已能承载教辅短剧方向。
- `wenyan-skill` 已按新合约补强 `version`、`capabilities`、`fallbackRules` 和 `shellBoundary` 元数据。
- 旧项目校验已能跳过 `projects/_template-edu-shortdrama/`，不会再把教辅模板当成真实项目目录检查。
- 教辅模板已有专用校验脚本，并已接入 Bash / PowerShell 顶层 `validate-shell`。
- 当前校验链路已覆盖教辅模板结构、教辅字段、真实教辅项目实例和生产稿包边界；真实教辅烟测项目已创建并补齐 Phase 0-4 文件，且已通过匹配其语义的校验。Phase 5 教学与生产审查已经完成，Phase 6 轻量修订及复核已经完成，Phase 7 锁稿前审查已经完成；当前主要问题是等待用户确认是否制定 Phase 8 锁稿计划。
- 顶层 `validate-shell.*` 仍保留既有 `.claude/` 探测 warning 逻辑；`VALIDATE-005` 未扩大该探测边界。
- `projects/_template` 仍作为旧小说 / 剧本模板保留，未被本轮改动。
- 长期优化任务需要按编号推进，每次只执行一个任务，避免上下文漂移和范围扩大。

## 下一步建议

建议下一步执行 `BACKLOG.md` 中的 `WENYAN-SMOKE-009-PHASE8-PLAN`：制定进入 Phase 8 锁稿计划。

当前不得自动进入 Phase 8；后续必须等待用户确认后，才可制定或执行 Phase 8 锁稿相关任务。Phase 7 只完成锁稿前审查，不代表已经锁稿。

## 禁止事项

- 不得把当前迁移写成已经完成的教辅短剧系统重构。
- 不得未经用户确认重构 `workflow/`、`scripts/`、`genre-skills/`、`projects/` 或 `projects/_template/`。
- 不得自动运行 Skill、创建测试项目或生成剧本 / 分镜 / 视频提示词。
- 不得把教辅短剧规则硬编码进壳子主流程。
- 不得把所有长期背景塞进 `AGENTS.md`；长期上下文应维护在 `docs/AI-CONTEXT/`。
- 不得一次执行多个 backlog 任务，除非用户明确授权。
