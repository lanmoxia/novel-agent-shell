# 长期优化清单

本文件是项目长期优化清单。每个任务必须有编号；每次默认只执行一个任务；完成后必须更新任务状态和必要备注。

状态约定：

- `[ ]`：未开始
- `[~]`：进行中
- `[x]`：已完成
- `[!]`：暂停 / 阻塞

优先级约定：

- `P0`：新会话接力或范围控制的基础任务
- `P1`：迁移分析、架构映射和合约审计任务
- `P2`：验证、模板或后续生产化任务

## P0：上下文机制

### [x] CTX-001：建立 AI-CONTEXT 长期上下文目录

- 目标：新增 `docs/AI-CONTEXT/`，作为 Codex / AI 新会话长期上下文入口。
- 修改范围：`docs/AI-CONTEXT/README.md`、`docs/AI-CONTEXT/CURRENT-STATE.md`、`docs/AI-CONTEXT/BACKLOG.md`。
- 禁止范围：不得修改 `workflow/`、`scripts/`、`genre-skills/`、`projects/`、`projects/_template/` 或测试项目。
- 验收标准：目录存在；三个文件职责清楚；新会话读取顺序明确；任务结束后的状态更新规则明确。
- 备注：2026-05-28 已完成第一版。

### [x] CTX-002：精简并强化 AGENTS.md 新会话启动规则

- 目标：在 `AGENTS.md` 增加短启动规则，让新会话先读取 `docs/AI-CONTEXT/`。
- 修改范围：`AGENTS.md`。
- 禁止范围：不得把长篇项目背景、迁移方案或业务规则塞进 `AGENTS.md`。
- 验收标准：包含 AI-CONTEXT 三文件读取顺序；包含架构 / workflow / Skill 任务的补充读取规则；包含任务结束后更新状态和 backlog 的要求；包含未经确认不得大范围修改关键目录的约束。
- 备注：2026-05-28 已完成第一版。

### [x] CTX-003：更新 README.md 当前迁移状态说明

- 目标：在 `README.md` 增加简短“当前迁移状态”小节。
- 修改范围：`README.md`。
- 禁止范围：不得删除原 README 内容；不得把迁移写成已经完成；不得重写项目定位全文。
- 验收标准：说明项目原本是小说 / 剧本 Agent 壳子；说明当前正在向教辅类 AI 真人古风短剧生产系统迁移；说明当前重点是可插拔 Skill 与上下文机制；指向 `docs/AI-CONTEXT/`。
- 备注：2026-05-28 已完成第一版。

### [x] CTX-004：落地 AI-CONTEXT 长期信息分层与读取策略

- 目标：建立 `AI-CONTEXT` 的最小信息分层，让新会话只读必要文件，长审计报告按任务按需读取。
- 修改范围：`docs/AI-CONTEXT/README.md`、`docs/AI-CONTEXT/CURRENT-STATE.md`、`docs/AI-CONTEXT/BACKLOG.md`、`docs/AI-CONTEXT/LAST-TASK.md`、`docs/AI-CONTEXT/archive/`。
- 禁止范围：不得修改 `AGENTS.md`、`README.md`、`docs/README.md`、`workflow/`、`scripts/`、`genre-skills/`、`projects/`、`projects/_template/`；不得执行 `ARCH-002` 或 `CLEAN-001`。
- 验收标准：`archive/` 存在；`ARCH-001-AUDIT.md` 已迁入 archive；默认读取顺序包含 `LAST-TASK.md`；archive 明确为按需读取；`LAST-TASK.md` 保持短摘要。
- 备注：2026-05-28 已完成。`ARCH-001-AUDIT.md` 已迁入 `docs/AI-CONTEXT/archive/`，新增 `LAST-TASK.md`。

## P1：清理审计

### [x] CLEAN-001：历史文档、日志与旧记忆机制清理审计

- 目标：只读审计旧日志、旧 handoff、旧 roadmap、历史报告和旧记忆机制，判断它们与 `AI-CONTEXT` 的边界和新会话入口关系。
- 修改范围：默认只输出分析；如需落文档、移动或改名，必须另开任务并由用户确认。
- 禁止范围：不得删除文件；不得修改 `workflow/`、`scripts/`、`genre-skills/`、`projects/`、`projects/_template/`；不得运行测试或创建项目。
- 验收标准：列出应继续作为入口的文件、应按需读取的文件、应归档的文件、疑似重复或过时的文件，以及推荐处理顺序。
- 备注：2026-05-28 已完成只读审计，并归档到 `docs/AI-CONTEXT/archive/CLEAN-001-AUDIT.md`。

### [x] CLEAN-002：归档旧 handoff / old roadmap，并同步入口文档的新会话读取规则

- 目标：处理 `docs/CODEX-HANDOFF-SUMMARY.md`、`docs/SHELL-OPTIMIZATION-ROADMAP.md` 与当前 `AI-CONTEXT` 入口的冲突，并同步入口文档的新会话读取规则。
- 修改范围：仅限用户确认后的文档入口同步、旧 handoff / old roadmap 归档或 deprecated 标记；候选范围包括 `AGENTS.md`、`README.md`、`docs/README.md`、`docs/CODEX-HANDOFF-SUMMARY.md`、`docs/SHELL-OPTIMIZATION-ROADMAP.md`、`docs/AI-CONTEXT/*`。
- 禁止范围：不得修改 `workflow/`、`scripts/`、`genre-skills/`、`projects/`、`projects/_template/`；不得运行测试；不得创建项目；不得删除历史报告。
- 验收标准：新会话入口只指向 `docs/AI-CONTEXT/` 默认四件套；旧 handoff / old roadmap 不再自称默认接力入口；所有归档或 deprecated 标记路径清晰；禁止范围未被触碰。
- 备注：2026-05-28 已完成入口同步；旧 handoff / old roadmap 已标记为历史参考；未删除历史文档。

## P1：迁移架构分析

### [x] ARCH-001：审计小说流程与教辅短剧流程的语义冲突

- 目标：只读审计现有 Phase 0-8、workflow 文档、Skill 合约和文言文教辅短剧方向之间的语义冲突。
- 修改范围：默认只输出分析；如需落文档，必须先由用户确认目标文件。
- 禁止范围：不得修改 `workflow/`、`scripts/`、`genre-skills/`、`projects/` 或 `projects/_template/`。
- 验收标准：列出冲突点、影响范围、风险等级和建议处理顺序；明确哪些冲突只需文档改名，哪些可能影响流程或模板。
- 备注：2026-05-28 已完成只读审计，并归档到 `docs/AI-CONTEXT/archive/ARCH-001-AUDIT.md`。

### [x] ARCH-002：设计旧 Phase 与教辅短剧 Phase 的映射表

- 目标：基于 ARCH-001 的审计结果，设计旧小说 / 剧本 Phase 与教辅短剧生产 Phase 的映射关系。
- 修改范围：默认只输出方案；如需落文档，必须先由用户确认目标文件。
- 禁止范围：不得直接改 `workflow/ORCHESTRATION.md`、Hook、脚本或项目模板。
- 验收标准：给出旧 Phase、现语义、新语义、保留 / 改名 / 拆分 / 新增建议，以及迁移优先级。
- 备注：2026-05-28 已完成 Phase 映射设计，并归档到 `docs/AI-CONTEXT/archive/ARCH-002-PHASE-MAPPING.md`。

### [x] SKILL-001：检查 wenyan-skill 是否符合题材 Skill 合约

- 目标：只读检查 `genre-skills/wenyan-skill/` 与 `docs/GENRE-SKILL-CONTRACT.md` 的差距。
- 修改范围：默认只输出检查报告；如需修改 Skill，必须另开任务并由用户确认。
- 禁止范围：不得改 `genre-skills/`；不得运行 Skill；不得生成剧本、分镜或提示词。
- 验收标准：列出已有文件、缺失文件、capabilities 缺口、旧格式兼容性和建议补齐顺序。
- 备注：2026-05-28 已完成 `wenyan-skill` 与现有 Skill 合约差距审计，并归档到 `docs/AI-CONTEXT/archive/SKILL-001-WENYAN-CONTRACT-AUDIT.md`。结论是不需要先修 `wenyan-skill`，下一步可进入 `TEMPLATE-001`。

## P2：验证与模板评估

### [x] VALIDATE-001：运行现有 validate 脚本并记录结果

- 目标：在用户授权后运行现有验证脚本，记录当前仓库验证基线。
- 修改范围：可新增或更新用户确认的报告文件。
- 禁止范围：不得为了通过验证而修改业务逻辑、Hook、脚本、Skill 或项目模板。
- 验收标准：记录执行命令、退出码、关键输出、错误 / 警告摘要和后续建议。
- 备注：2026-05-28 已完成基线记录，归档到 `docs/AI-CONTEXT/archive/VALIDATE-001-BASELINE.md`。当前验证未完全通过，主要失败原因是旧项目校验脚本把 `projects/_template-edu-shortdrama/` 当成真实项目检查；本任务未修复脚本、未修改模板。

### [x] VALIDATE-002-AUDIT：只读分析现有 validate 脚本如何识别项目目录和模板目录

- 目标：只读审计 `validate-projects.sh`、`validate-project-state.sh`、`validate-project-state.ps1`、`validate-shell.sh` 和 `validate-shell.ps1` 如何遍历 `projects/` 并区分模板、样例和真实项目。
- 修改范围：仅限新增审计归档和必要的 AI-CONTEXT 状态文件更新。
- 禁止范围：不得修改 `scripts/`、`workflow/`、`genre-skills/`、`projects/`、`projects/_template/` 或 `projects/_template-edu-shortdrama/`；不得运行 validate；不得创建项目；不得生成剧本、分镜或视频提示词。
- 验收标准：明确现有跳过规则、`PROJECT-STATE.json` 字段要求、`_template-edu-shortdrama` 被误检原因、A/B/C/D 方案对比和推荐修复方向。
- 备注：2026-05-29 已完成只读审计，并归档到 `docs/AI-CONTEXT/archive/VALIDATE-002-AUDIT.md`。结论是推荐 `VALIDATE-002-FIX` 采用 C 方向：旧项目校验跳过教辅模板目录，并为教辅模板校验留出专用规则；不建议修改教辅模板迎合旧项目校验。

### [x] VALIDATE-002-FIX：调整验证脚本识别模板目录，并为教辅模板校验留出专用规则

- 目标：让旧项目校验不再把 `projects/_template-edu-shortdrama/` 当成真实项目，同时为教辅模板的专用结构 / 字段校验保留明确入口或规则。
- 修改范围：待用户确认后再限定；候选范围包括 `scripts/` 中相关 validate 脚本、必要的校验规则说明和 AI-CONTEXT 状态文件。
- 禁止范围：不得修改 `workflow/`、`genre-skills/`、`projects/_template/` 或 `projects/_template-edu-shortdrama/` 来迎合旧校验；不得创建项目；不得生成剧本、分镜或视频提示词。
- 验收标准：Bash / PowerShell 项目校验入口统一识别模板目录；`_template-edu-shortdrama` 不再进入真实项目校验；教辅模板专用校验边界被明确记录；验证结果和影响范围有归档记录。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/VALIDATE-002-FIX.md`。旧项目校验已跳过 `_template-edu-shortdrama`，未修改教辅模板；三条允许的项目校验命令均通过。

### [x] VALIDATE-003：新增教辅模板专用校验规则

- 目标：为 `projects/_template-edu-shortdrama/` 新增专用模板校验规则，检查模板结构、教辅字段和生产稿包边界，而不是套用真实项目 locked / final-review / RUN-LOG 状态。
- 修改范围：待用户确认后再限定；候选范围包括新增或更新专用 validate 脚本、必要的校验规则说明和 AI-CONTEXT 状态文件。
- 禁止范围：不得修改 `projects/_template-edu-shortdrama/` 来迎合旧项目校验；不得创建项目；不得生成剧本、分镜或视频提示词；不得执行创作测试。
- 验收标准：教辅模板有独立、可解释的结构 / 字段 / 产物边界校验；旧项目校验与教辅模板校验职责分离；验证结果和影响范围有归档记录。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/VALIDATE-003-EDU-TEMPLATE-VALIDATION.md`。新增 `scripts/validate-edu-shortdrama-template.sh`，教辅模板专用校验、旧项目校验均通过；未修改教辅模板。

### [x] VALIDATE-004：决定是否把教辅模板专用校验接入顶层 validate-shell

- 目标：评估并决定是否把 `scripts/validate-edu-shortdrama-template.sh` 接入 `validate-shell.sh` / `validate-shell.ps1`，让顶层校验覆盖教辅模板专用规则。
- 修改范围：待用户确认后再限定；候选范围包括顶层 validate-shell 脚本、必要的校验说明和 AI-CONTEXT 状态文件。
- 禁止范围：不得修改 `projects/_template-edu-shortdrama/`；不得创建项目；不得生成剧本、分镜或视频提示词；不得执行创作测试。
- 验收标准：明确是否接入顶层 shell 校验；如接入，顶层校验职责清晰且不把教辅模板当真实项目；验证结果和影响范围有归档记录。
- 备注：2026-05-29 已完成接入决策审计，并归档到 `docs/AI-CONTEXT/archive/VALIDATE-004-SHELL-INTEGRATION-DECISION.md`。推荐方案 C：Bash 和 PowerShell 顶层都接入教辅模板专用校验，但 PowerShell 需要等价校验入口或明确 Bash 调用前提。

### [x] VALIDATE-005：将教辅模板专用校验接入顶层 validate-shell

- 目标：将 `scripts/validate-edu-shortdrama-template.sh` 接入顶层 validate-shell 调用链，并为 PowerShell 顶层校验提供等价接入策略。
- 修改范围：待用户确认后再限定；候选范围包括 `scripts/validate-shell.sh`、`scripts/validate-shell.ps1`、必要的 PowerShell 等价校验入口和 AI-CONTEXT 状态文件。
- 禁止范围：不得修改 `projects/_template-edu-shortdrama/`；不得把教辅模板重新纳入真实项目校验；不得创建项目；不得生成剧本、分镜或视频提示词。
- 验收标准：顶层校验能覆盖教辅模板专用规则；旧项目校验与教辅模板校验职责分离；不新增 `.claude/` 探测逻辑；验证结果和影响范围有归档记录。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/VALIDATE-005-SHELL-INTEGRATION.md`。Bash / PowerShell 顶层校验均已接入教辅模板专用校验并通过 0 error / 0 warning；本轮未修改教辅模板，未新增 `.claude/` 探测逻辑。

### [x] WENYAN-SMOKE-001：进行实际文言文教辅短剧烟测

- 目标：基于已接入校验链路的 `wenyan-skill` 与 `projects/_template-edu-shortdrama/`，进行一次受控的文言文教辅短剧烟测，验证真实项目建档、状态推进和模板链路是否可用。
- 修改范围：待用户确认后再限定；候选范围包括新建烟测项目目录、必要的烟测记录和 AI-CONTEXT 状态文件。
- 禁止范围：不得复用旧 smoke test 内容冒充正式烟测；不得修改 `projects/_template-edu-shortdrama/` 来迎合烟测；不得自动扩展到完整生产项目；不得在未确认前生成长篇剧本、分镜或视频提示词。
- 验收标准：烟测输入、执行范围、命令 / 步骤、输出文件、失败点和后续处理建议均有记录；如创建烟测项目，需明确保留或清理策略；不得影响现有正式项目和模板。
- 备注：2026-05-29 已先完成 `WENYAN-SMOKE-001-PLAN`，只制定烟测边界并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-001-PLAN.md`；本任务尚未执行，未创建项目，未生成剧本。
- 备注：2026-05-29 `WENYAN-SMOKE-001-RUN-RECOVERY` 已补齐 Phase 0-4 烟测文件；最初因旧 active project 校验误检而暂停，后续 `VALIDATE-007` 已完成 `projectType` 分流和教辅真实项目实例专用校验，Bash / PowerShell 顶层校验均通过。烟测项目保留待质量审查。

### [x] WENYAN-SMOKE-001-PLAN：制定文言文教辅短剧烟测方案

- 目标：在执行实际烟测前，明确烟测输入、项目目录、推进阶段、允许 / 禁止生成文件、成功标准、风险和用户确认项。
- 修改范围：仅限 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-001-PLAN.md` 以及 AI-CONTEXT 状态文件。
- 禁止范围：不得创建 `projects/` 下的新目录；不得生成剧本、分镜、字幕、视频提示词或生产稿包；不得修改 `wenyan-skill`、教辅模板、workflow 或 scripts；不得运行 smoke test 或创作流程。
- 验收标准：方案明确回答是否创建真实项目目录、推荐项目名、推荐文本、推进到哪个 Phase、生成 / 禁止生成文件、保留 / 清理策略、成功标准、失败记录和用户确认项。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-001-PLAN.md`。

### [x] WENYAN-SMOKE-001-RUN：按用户确认范围创建文言文教辅短剧烟测项目

- 目标：在用户明确确认后，按 `WENYAN-SMOKE-001-PLAN` 的边界创建文言文教辅短剧烟测项目并推进到确认范围。
- 修改范围：待用户确认后再限定；候选范围包括 `projects/wenyan-smoke-liangxiaor-bianri-001/`、烟测运行记录和必要的 AI-CONTEXT 状态文件。
- 禁止范围：未确认前不得执行；不得超出用户确认的 Phase；不得生成正式锁稿、完整生产稿包、视频提示词、Seedance prompts 或图像提示词；不得顺手修改模板、Skill、workflow 或 scripts。
- 验收标准：只生成用户确认范围内的文件；烟测输入、输出、状态、失败点和未生成产物均有记录；如遇校验兼容问题，只记录并暂停，不在同一任务中扩大修复范围。
- 备注：2026-05-29 recovery 已创建 `projects/wenyan-smoke-liangxiaor-bianri-001/` 并补齐允许文件；`VALIDATE-007` 后，烟测项目通过匹配其语义的教辅真实项目实例校验。未补旧小说规划文件，未生成正式字幕、分镜、视频提示词或生产稿包。

### [x] VALIDATE-006-EDU-ACTIVE-PROJECT-COMPAT-AUDIT：审计真实教辅项目实例与 active project 校验兼容问题

- 目标：只读审计真实 `projectType: edu-shortdrama` 项目进入 active project 校验后为何触发旧小说 / 剧本字段要求，并提出兼容方案。
- 修改范围：仅限新增审计归档和必要的 AI-CONTEXT 状态文件更新。
- 禁止范围：不得修改 `scripts/`、`workflow/`、`genre-skills/`、`projects/_template/`、`projects/_template-edu-shortdrama/` 或烟测项目内容；不得为通过旧校验生成占位文件；不得创建新项目。
- 验收标准：明确 Bash / PowerShell active project 校验失败点、是否应识别 `projectType: edu-shortdrama`、是否需要教辅项目实例专用校验、推荐修复顺序和禁止生成占位文件的边界。
- 备注：2026-05-29 已完成 recovery 只读审计，并归档到 `docs/AI-CONTEXT/archive/VALIDATE-006-EDU-ACTIVE-PROJECT-COMPAT-AUDIT.md`。结论是优先采用 `projectType` 分流 + 新增教辅真实项目实例专用校验；未修改 `scripts/`，未修改烟测项目，未补旧小说规划文件。

### [x] VALIDATE-007-EDU-ACTIVE-PROJECT-COMPAT-FIX：为真实教辅项目实例增加 active project 校验分流与专用校验

- 目标：修复真实 `projectType: edu-shortdrama` 项目进入 active project 校验后被旧小说 / 剧本规则误检的问题，同时为教辅真实项目实例增加专用校验。
- 修改范围：待用户确认后再限定；候选范围包括 `scripts/validate-projects.sh`、`scripts/validate-project-state.sh`、`scripts/validate-project-state.ps1`、`scripts/validate-shell.sh`、`scripts/validate-shell.ps1`，以及新增 `scripts/validate-edu-shortdrama-project.sh` / `.ps1` 和必要的 AI-CONTEXT 状态文件。
- 禁止范围：不得修改 `genre-skills/`、`projects/_template/`、`projects/_template-edu-shortdrama/` 或烟测项目内容来迎合旧校验；不得补 `REVERSE-OUTLINE.md`、`FORESHADOW-LEDGER.md`、`REVEAL-SCHEDULE.md`、`final-review.md` 或锁稿 manifest 占位文件；不得运行创作流程。
- 验收标准：旧小说 / 剧本项目继续走旧校验；`projectType: edu-shortdrama` 项目走教辅真实项目实例专用校验；顶层 Bash / PowerShell `validate-shell` 调用链清晰；烟测项目不需补旧规划文件即可通过与其语义匹配的校验；校验结果和影响范围有归档记录。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/VALIDATE-007-EDU-ACTIVE-PROJECT-COMPAT-FIX.md`。新增 Bash / PowerShell 教辅真实项目实例校验，旧校验已按 `projectType` 分流；Bash / PowerShell 顶层校验均通过 0 error / 0 warning。

### [x] WENYAN-SMOKE-002-REVIEW：审查烟测项目输出质量与是否符合 wenyan-skill

- 目标：审查 `projects/wenyan-smoke-liangxiaor-bianri-001/` 的 Phase 0-4 烟测输出质量，判断是否符合文言文教辅短剧语义、`wenyan-skill` 方向和烟测边界。
- 修改范围：默认只读审查；如需归档，可新增审查报告和必要的 AI-CONTEXT 状态文件。
- 禁止范围：不得自动进入 Phase 5 / 6 / 7 / 8；不得生成 `reviews/final-review.md`、正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词、锁稿或生产稿包；不得修改模板、Skill、workflow 或 scripts。
- 验收标准：列出烟测输出的质量问题、与原文 / 教学目标 / Scene 映射 / 草案边界的一致性、是否需要修订、是否可以进入下一阶段，以及后续建议。
- 备注：2026-05-29 已完成只读质量审查，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-002-REVIEW.md`。结论：无 P0，存在 4 个 P1 和 3 个 P2；不建议直接进入 Phase 5，建议先制定修订计划。

### [x] WENYAN-SMOKE-003-REVISION-PLAN：制定烟测项目修订计划

- 目标：基于 `WENYAN-SMOKE-002-REVIEW` 的 P1 / P2 问题，制定烟测项目 Phase 4 草案的修订范围、优先级和执行边界。
- 修改范围：默认只新增修订计划归档和必要的 AI-CONTEXT 状态文件；是否修改烟测项目内容需由用户另行确认。
- 禁止范围：不得直接修改 `projects/wenyan-smoke-liangxiaor-bianri-001/`；不得进入 Phase 5 / 6 / 7 / 8；不得生成 `reviews/final-review.md`、正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词、锁稿或生产稿包；不得修改模板、Skill、workflow 或 scripts。
- 验收标准：明确观点 / 证据层次修订目标、原文回扣和白话释义补强目标、降低说教感方案、是否同步 RUN-LOG 的建议、是否继续停留 Phase 4，以及用户执行前确认项。
- 备注：2026-05-29 已通过 recovery 完成修订计划制定，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-003-REVISION-PLAN.md`。本轮未修改烟测项目，未生成正式产物，未进入 Phase 5；下一步需等待用户确认是否执行修订。

### [x] WENYAN-SMOKE-003-REVISION-RUN：按用户确认范围修订 Phase 4 烟测草案

- 目标：在用户确认后，按 `WENYAN-SMOKE-003-REVISION-PLAN` 限定范围修订 Phase 4 烟测草案，优先处理 4 个 P1 问题。
- 修改范围：候选范围为 `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`、`projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`、`projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`、`projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`、`projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`；具体范围必须由用户确认。
- 禁止范围：不得进入 Phase 5 / 6 / 7 / 8；不得生成 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md`、正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词或完整生产稿包；不得修改模板、Skill、workflow 或 scripts。
- 验收标准：观点层与证据层分离更清楚；S05 补足“孰为汝多知乎？”白话释义且不形成嘲讽；结尾降低口号化 / PPT 味；RUN-LOG 状态同步真实历史；项目仍停留在 Phase 4。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-003-REVISION-RUN.md`。本轮未修改 `PROJECT-STATE.json`，未进入 Phase 5，未生成正式产物，Bash / PowerShell 顶层校验均通过 0 error / 0 warning。

### [x] WENYAN-SMOKE-004-REVIEW：复核修订后的 Phase 4 烟测草案质量

- 目标：复核 `WENYAN-SMOKE-003-REVISION-RUN` 后的 Phase 4 烟测草案质量，判断 4 个 P1 是否已解决、P2 是否仍可接受，以及是否仍保持烟测边界。
- 修改范围：默认只读复核；如需归档，可新增复核报告和必要的 AI-CONTEXT 状态文件。
- 禁止范围：不得自动进入 Phase 5 / 6 / 7 / 8；不得生成 `reviews/final-review.md`、正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词、锁稿或生产稿包；不得修改模板、Skill、workflow 或 scripts。
- 验收标准：明确修订后草案是否通过 Phase 4 质量复核；列出残留 P0 / P1 / P2；给出唯一后续建议。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-004-REVIEW.md`。复核结论：P0=0，P1=0，仅剩不阻塞的 P2 确认项；修订后 Phase 4 质量复核通过，建议下一步制定 Phase 5 计划。

### [x] WENYAN-SMOKE-005-PHASE5-PLAN：制定进入 Phase 5 教学与生产审查计划

- 目标：在不直接进入 Phase 5 的前提下，制定教学与生产审查计划，明确审查对象、审查边界、允许 / 禁止产物、用户确认项和成功标准。
- 修改范围：默认只新增 Phase 5 计划归档和必要的 AI-CONTEXT 状态文件。
- 禁止范围：不得直接生成 `reviews/final-review.md`；不得进入 Phase 6 / 7 / 8；不得生成正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词、锁稿或生产稿包；不得修改模板、Skill、workflow 或 scripts。
- 验收标准：明确是否以 `SMOKE-DRAFT.md` 作为 Phase 5 审查对象；明确审查维度、输入文件、输出文件、是否需要用户确认，以及不自动锁稿 / 不生成后置产物的边界。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-005-PHASE5-PLAN.md`。本轮未进入 Phase 5，未生成 `reviews/final-review.md`，未修改 `PROJECT-STATE.json`，下一步需等待用户确认是否执行 Phase 5。

### [x] WENYAN-SMOKE-005-PHASE5-RUN：按用户确认范围执行 Phase 5 教学与生产审查

- 目标：在用户确认后，按 `WENYAN-SMOKE-005-PHASE5-PLAN` 执行 Phase 5 教学与生产审查。
- 修改范围：候选范围应由用户确认，通常以 `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase5-teaching-production-review.md` 为主要输出，并在需要时同步必要状态文件。
- 禁止范围：不得直接生成 `reviews/final-review.md`；不得进入 Phase 6 / 7 / 8；不得生成正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词、锁稿或生产稿包；不得修改模板、Skill、workflow 或 scripts。
- 验收标准：完成教学与生产审查，列出残留问题和后续建议；是否建议进入 Phase 6 必须明确；不得越过 Phase 5 自动锁稿。
- 备注：2026-05-29 已完成，已生成 `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase5-teaching-production-review.md`；P0=0，P1=0，P2=3；Bash / PowerShell 校验均通过 0 error / 0 warning；建议下一步执行 `WENYAN-SMOKE-006-PHASE6-PLAN`。

### [x] WENYAN-SMOKE-006-PHASE6-PLAN：制定进入 Phase 6 的修订计划

- 目标：在 Phase 5 审查通过后，制定进入 Phase 6 的修订计划。
- 修改范围：仅限计划文档和必要 AI-CONTEXT 状态文件；不修改项目正文。
- 禁止范围：不得自动进入 Phase 6 执行；不得生成锁稿、正式字幕、正式分镜、视频提示词或生产稿包。
- 验收标准：明确 Phase 6 是否需要处理 P2 项、允许修改文件、禁止产物和下一步确认项。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-006-PHASE6-PLAN.md`。本轮只制定 Phase 6 轻量修订计划，未修改烟测项目正文，未修改 `PROJECT-STATE.json`，未进入 Phase 6 执行；后续需等待用户确认是否执行 `WENYAN-SMOKE-006-PHASE6-RUN`。

### [x] WENYAN-SMOKE-006-PHASE6-RUN：按用户确认范围执行 Phase 6 轻量修订

- 目标：在用户确认后，按 `WENYAN-SMOKE-006-PHASE6-PLAN` 执行 Phase 6 轻量修订，只处理 Phase 5 残留的 3 个 P2。
- 修改范围：待用户确认后再限定；候选范围包括 `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`、`projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`、`projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`、`projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`、`projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md` 和必要的 AI-CONTEXT 状态文件；是否修改 `PROJECT-STATE.json` 必须由用户明确确认。
- 禁止范围：不得生成 `reviews/final-review.md`、锁稿、正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词或完整生产稿包；不得进入 Phase 7 / 8；不得修改模板、Skill、workflow 或仓库级 scripts；不得补旧小说规划文件。
- 验收标准：教材版本 / 目标年级 / 时长确认状态清楚；S03 字幕负载有所收敛；S05 主题收束更自然；不生成禁止产物；如更新 `PROJECT-STATE.json`，必须有用户明确确认。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-006-PHASE6-RUN.md`。本轮只处理 3 个 P2，已进入 Phase 6，未进入 Phase 7 / 8，未生成正式产物；Bash / PowerShell 校验均通过 0 error / 0 warning。

### [x] WENYAN-SMOKE-007-REVIEW：复核 Phase 6 轻量修订结果

- 目标：复核 `WENYAN-SMOKE-006-PHASE6-RUN` 后的轻量修订结果，判断 3 个 P2 是否已按边界处理，以及是否仍保持教学准确性和生产边界。
- 修改范围：默认只读复核；如需归档，可新增复核报告和必要的 AI-CONTEXT 状态文件。
- 禁止范围：不得进入 Phase 7 / 8；不得生成 `reviews/final-review.md`、锁稿、正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词或完整生产稿包；不得修改模板、Skill、workflow 或仓库级 scripts；不得补旧小说规划文件。
- 验收标准：明确 Phase 6 轻量修订是否通过复核；列出残留 P0 / P1 / P2；确认是否仍未生成正式产物；给出唯一后续建议。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-007-REVIEW.md`。复核结论：Phase 6 轻量修订通过，P0=0，P1=0，仅剩不阻塞的 P2；建议下一步执行 `WENYAN-SMOKE-008-PHASE7-PLAN`。

### [x] WENYAN-SMOKE-008-PHASE7-PLAN：制定进入 Phase 7 锁稿前审查计划

- 目标：在 Phase 6 轻量修订复核通过后，制定进入 Phase 7 锁稿前审查的计划和边界。
- 修改范围：仅限计划归档和必要 AI-CONTEXT 状态文件；不修改烟测项目正文。
- 禁止范围：不得直接进入 Phase 7 执行；不得生成 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md`、锁稿 manifest、正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词或完整生产稿包；不得修改模板、Skill、workflow 或仓库级 scripts。
- 验收标准：明确 Phase 7 锁稿前审查对象、允许 / 禁止产物、是否需要用户确认、是否处理残留 P2，以及不得自动锁稿的边界。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-008-PHASE7-PLAN.md`。本轮只制定 Phase 7 锁稿前审查计划，未执行 Phase 7，未生成 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md`、正式字幕、正式分镜、视频提示词或生产稿包；下一步需等待用户确认是否执行 `WENYAN-SMOKE-008-PHASE7-RUN`。

### [x] WENYAN-SMOKE-008-PHASE7-RUN：按用户确认范围执行 Phase 7 锁稿前审查

- 目标：在用户确认后，按 `WENYAN-SMOKE-008-PHASE7-PLAN` 执行 Phase 7 锁稿前审查，判断当前烟测稿是否具备进入锁稿计划的条件。
- 修改范围：待用户确认后再限定；候选范围最多包括新增 `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase7-prelock-review.md`、必要的 `PROJECT-STATE.json` 状态更新，以及 AI-CONTEXT 状态文件。
- 禁止范围：不得生成 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md`、锁稿 manifest、正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词或完整生产稿包；不得进入 Phase 8；不得修改模板、Skill、workflow 或仓库级 scripts；不得自动做正文修订。
- 验收标准：审查报告明确是否具备锁稿条件，列出 P0 / P1 / P2，判断剩余 P2 是否可接受，并明确是否建议进入 Phase 8 锁稿计划；不生成任何锁稿或正式生产产物。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-008-PHASE7-RUN.md`。本轮新增 `reviews/phase7-prelock-review.md`，审查结论为 P0=0、P1=0、P2=1，具备进入 Phase 8 锁稿计划制定的条件；未生成 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md`、正式字幕、正式分镜、视频提示词或生产稿包。

### [x] WENYAN-SMOKE-009-PHASE8-PLAN：制定进入 Phase 8 锁稿计划

- 目标：在 Phase 7 锁稿前审查通过后，制定进入 Phase 8 的锁稿计划，明确锁稿对象、锁稿产物、状态更新、用户确认项和禁止自动生成后置生产产物的边界。
- 修改范围：待用户确认后再限定；候选范围应优先限于计划归档和必要 AI-CONTEXT 状态文件，不直接生成锁稿产物。
- 禁止范围：不得直接生成 `locked/FINAL-SCRIPT.md`、`reviews/final-review.md`、锁稿 manifest、正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词或完整生产稿包；不得修改模板、Skill、workflow 或仓库级 scripts；不得自动执行 Phase 8 锁稿。
- 验收标准：明确是否允许进入真正锁稿、锁稿前必须确认的教材版本 / 目标年级 / 最终时长、允许和禁止生成内容、成功标准、回滚或暂停规则，以及后续执行任务建议。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-009-PHASE8-PLAN.md`。本轮只制定 Phase 8 锁稿计划，未执行 Phase 8，未生成 `locked/FINAL-SCRIPT.md`、`reviews/final-review.md`、锁稿 manifest、正式字幕、正式分镜、视频提示词或生产稿包；下一步需等待用户确认是否执行 `WENYAN-SMOKE-009-PHASE8-RUN`。

### [x] WENYAN-SMOKE-009-PHASE8-RUN：按用户确认范围执行 Phase 8 锁稿

- 目标：在用户确认后，按 `WENYAN-SMOKE-009-PHASE8-PLAN` 执行 Phase 8 锁稿，验证文言文教辅短剧剧本创作链路的锁稿能力。
- 修改范围：待用户确认后再限定；候选范围最多包括 `locked/FINAL-SCRIPT.md`、锁稿 manifest、必要的项目状态文件和 AI-CONTEXT 状态文件。
- 禁止范围：不得生成正式字幕、正式分镜、视频提示词、Seedance prompts、Seedance2.0 提示词、图像提示词或完整生产稿包；不得修改模板、Skill、workflow 或仓库级 scripts；不得进入视频生产链路。
- 验收标准：锁稿对象、锁稿产物、状态更新、剩余 P2 处理、校验结果和 Git 提交推送结果均可追溯；不得生成未获确认的后置生产产物。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-009-PHASE8-RUN.md`。本轮新增 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md`、`locked/LOCK-MANIFEST.sha256` 和 `locked/SKILL-LOCK-MANIFEST.sha256`；剧本文本创作链路已完成锁稿，未生成正式字幕、正式分镜、视频提示词、Seedance prompts、Seedance2.0 提示词、图像提示词或生产稿包。

### [x] WENYAN-SMOKE-010-SCRIPT-CREATION-BOUNDARY-FREEZE：冻结剧本创作链路完成状态，明确不进入分镜 / Seedance / 视频生产

- 目标：在 Phase 8 剧本文本锁稿完成后，冻结当前主线完成状态，明确本轮只完成文言文教辅短剧剧本创作链路验证，不自动进入分镜提示词、Seedance2.0 提示词或视频生产链路。
- 修改范围：待用户确认后再限定；候选范围应优先限于项目状态说明、AI-CONTEXT 状态文件和必要归档，不生成新创作内容。
- 禁止范围：不得生成正式字幕、正式分镜、视频提示词、Seedance prompts、Seedance2.0 提示词、图像提示词或完整生产稿包；不得修改模板、Skill、workflow 或仓库级 scripts。
- 验收标准：当前剧本链路完成状态被清楚冻结；后续如需分镜 / Seedance / 视频生产，必须另开任务或 Skill；不产生新的生产资产。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/WENYAN-SMOKE-010-SCRIPT-CREATION-BOUNDARY-FREEZE.md`。当前主线文言文教辅短剧剧本创作链路已完成锁稿并收束；未修改烟测项目文件，未生成字幕、分镜、视频提示词、Seedance prompts、Seedance2.0 提示词、图像提示词或生产稿包。

### [x] WENYAN-GENERALIZE-001-PLAN：规划《司马光》作为第二篇文言文泛化测试

- 目标：在不进入正式创作执行的前提下，规划《司马光》作为第二篇文言文泛化测试，验证 `wenyan-skill` 是否能从《两小儿辩日》的争辩型 / 观点证据型结构泛化到事件危机型 / 行动解困型结构。
- 修改范围：仅限 `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-001-PLAN.md` 以及必要 AI-CONTEXT 状态文件。
- 禁止范围：不得创建《司马光》项目目录；不得生成剧本、完整分场、完整台词、正式字幕、正式分镜、视频提示词、Seedance prompts、Seedance2.0 提示词、图像提示词、锁稿 manifest 或完整生产稿包；不得修改《两小儿辩日》锁稿资产。
- 验收标准：计划文件明确第二篇泛化测试的必要性、选择《司马光》的理由、两篇文本结构差异、验证能力、不验证能力、下一轮 RUN 项目目录、阶段边界、待确认项和禁止事项；本轮不创建项目、不生成剧本、不进入视频链路。
- 备注：2026-05-29 已完成，并归档到 `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-001-PLAN.md`。本轮只完成计划，未创建 `projects/wenyan-generalize-sima-guang-001/`，未生成《司马光》剧本，未进入分镜、Seedance2.0、视频生产、正式字幕或生产稿包链路。

### [x] WENYAN-GENERALIZE-001-RUN：正式执行《司马光》第二篇文言文泛化测试

- 目标：在用户明确确认后，按 `WENYAN-GENERALIZE-001-PLAN` 的边界执行《司马光》第二篇文言文泛化测试，验证事件危机型 / 行动解困型文言文的剧本创作链路。
- 修改范围：待用户确认后再限定；候选范围包括 `projects/wenyan-generalize-sima-guang-001/`、必要运行记录和 AI-CONTEXT 状态文件。
- 禁止范围：未确认前不得执行；不得复用或覆盖《两小儿辩日》锁稿资产；不得直接锁稿；不得生成正式字幕、正式分镜、视频提示词、Seedance prompts、Seedance2.0 提示词、图像提示词或完整生产稿包；不得修改模板、Skill、workflow 或仓库级 scripts。
- 验收标准：只生成用户确认范围内的项目建档、原文拆解、Scene 映射、烟测草案或阶段性审查产物；明确是否停在 Phase 4 或 Phase 5；记录待确认项、失败点、未生成产物和后续建议。
- 备注：2026-05-29 已完成阶段执行，并归档到 `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-001-RUN.md`。本轮创建 `projects/wenyan-generalize-sima-guang-001/` 并推进到 Phase 4 烟测草案；未进入 Phase 5/6/7/8，未锁稿，未生成正式字幕、正式分镜、视频提示词、Seedance prompts、Seedance2.0 prompt、图像提示词或生产稿包。

### [x] WENYAN-GENERALIZE-002-PHASE5-REVIEW：对《司马光》Phase 4 烟测草案进行教学与生产审查

- 目标：在用户明确确认后，对 `projects/wenyan-generalize-sima-guang-001/scripts/SMOKE-DRAFT.md` 进行 Phase 5 教学与生产审查，判断《司马光》事件危机型 / 行动解困型结构是否合格。
- 修改范围：待用户确认后再限定；候选范围最多包括 `projects/wenyan-generalize-sima-guang-001/reviews/phase5-teaching-production-review.md`、必要的 `PROJECT-STATE.json` 状态更新、项目运行记录和 AI-CONTEXT 状态文件。
- 禁止范围：未确认前不得执行；不得生成 `reviews/final-review.md`；不得进入 Phase 6/7/8；不得锁稿；不得生成正式字幕、正式分镜、视频提示词、Seedance prompts、Seedance2.0 prompt、图像提示词或完整生产稿包；不得修改《两小儿辩日》锁稿资产。
- 验收标准：审查报告明确 P0 / P1 / P2，判断草案是否保持事件危机型结构、原文准确性、白话释义、教学闭环和生产边界；明确是否建议轻量修订或进入下一阶段；不得自动修订或锁稿。
- 备注：2026-05-30 已完成，并归档到 `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-002-PHASE5-REVIEW.md`。本轮新增 `reviews/phase5-teaching-production-review.md`，审查结论为 P0=0、P1=0、P2=6，允许在用户确认后进入 Phase 6 轻量修订；未修订 `SMOKE-DRAFT.md`，未进入 Phase 6/7/8，未锁稿，未生成正式字幕、正式分镜、视频提示词、Seedance prompts、Seedance2.0 prompt、图像提示词或生产稿包。

### [ ] WENYAN-GENERALIZE-003-PHASE6-LIGHT-REVISION：根据 Phase 5 审查结果进行轻量修订

- 目标：在用户明确确认后，根据 Phase 5 审查报告处理《司马光》草案中的 P2 问题，强化事件危机型 / 行动解困型表达。
- 修改范围：待用户确认后再限定；候选范围包括 `projects/wenyan-generalize-sima-guang-001/scripts/SMOKE-DRAFT.md`、必要的项目状态文件、项目记忆、运行日志和 AI-CONTEXT 状态文件。
- 禁止范围：未确认前不得执行；不得进入 Phase 7/8；不得锁稿；不得生成 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md`、锁稿 manifest、正式字幕、正式分镜、视频提示词、Seedance prompts、Seedance2.0 prompt、图像提示词或完整生产稿包；不得修改《两小儿辩日》锁稿资产。
- 验收标准：只处理 Phase 5 审查提出的轻量修订项；保留原文事实链、文言句绑定、白话释义和学习闭环；修订后仍不进入锁稿或视频链路。
- 备注：后续候选任务，当前未启动。

### [ ] WENYAN-GENERALIZE-003-REVISION-PLAN：制定《司马光》Phase 6 修订计划

- 目标：如用户希望先拆解 P2 修订项，在执行正文修订前制定 Phase 6 轻量修订计划。
- 修改范围：待用户确认后再限定；候选范围优先限于计划归档和必要 AI-CONTEXT 状态文件。
- 禁止范围：未确认前不得执行；不得修改 `SMOKE-DRAFT.md`；不得进入 Phase 6 正文修订、Phase 7、Phase 8、锁稿或视频链路。
- 验收标准：明确修订对象、修订项、允许 / 禁止范围、成功标准和后续 RUN 任务编号。
- 备注：后续候选任务，当前未启动。

### [ ] WENYAN-GENERALIZE-001-REVISION：按审查或用户反馈轻量修订《司马光》Phase 4 烟测草案

- 目标：如 Phase 4 草案存在明显问题，或后续 Phase 5 审查提出 P1 / P2 修订项，在用户明确确认后进行轻量修订。
- 修改范围：待用户确认后再限定；候选范围包括 `projects/wenyan-generalize-sima-guang-001/scripts/SMOKE-DRAFT.md`、`outlines/OUTLINE.md`、`PROJECT-MEMORY.md`、`RUN-LOG.md` 和必要状态文件。
- 禁止范围：未确认前不得执行；不得扩大到锁稿、正式字幕、正式分镜、Seedance prompt、视频提示词或生产稿包；不得修改 `wenyan-skill`、workflow、scripts 或《两小儿辩日》锁稿资产。
- 验收标准：只处理明确问题，不重写为新任务；修订后仍停留在用户确认的阶段边界内，并记录未生成产物。
- 备注：后续候选任务，当前未启动。

### [ ] VIDEO-SKILL-001-PLAN：规划分镜 / Seedance2.0 提示词 Skill

- 目标：在用户另行明确确认后，规划独立的分镜 / Seedance2.0 提示词 Skill，不把视频生产链路并入当前 `wenyan-skill` 剧本创作验证链路。
- 修改范围：待用户确认后再限定；候选范围应优先限于计划归档和必要 AI-CONTEXT 状态文件。
- 禁止范围：未确认前不得执行；不得自动生成正式分镜、视频提示词、Seedance prompts、Seedance2.0 提示词、图像提示词或完整生产稿包；不得修改当前已锁稿剧本资产。
- 验收标准：明确新 Skill 的职责、输入、输出、禁止产物、验证方式和与 `wenyan-skill` 剧本链路的边界。
- 备注：待用户另行确认后才可启动；当前未启动。

### [ ] CLEANUP-001-AUDIT：只读仓库清理审计

- 目标：在用户明确确认后，对仓库进行只读清理审计，识别历史报告、临时产物、已冻结项目资产和可归档对象的边界。
- 修改范围：默认只输出审计结论；如需落文档、移动、删除或改名，必须另开任务并由用户确认。
- 禁止范围：不得删除文件；不得修改 `workflow/`、`scripts/`、`genre-skills/`、`projects/`、`projects/_template/`、`projects/_template-edu-shortdrama/` 或已锁稿资产；不得运行生成流程；不得创建项目。
- 验收标准：列出可保留、可归档、疑似重复、禁止清理和需要用户确认的对象；不产生实际清理动作。
- 备注：后续候选任务，当前未启动。

### [x] TEMPLATE-001：评估 projects/_template 是否需要教辅短剧版本

- 目标：只读评估当前 `projects/_template/` 是否适合教辅短剧生产，判断是否需要新增独立模板或扩展现有模板。
- 修改范围：默认只输出分析；如需修改模板，必须另开任务并由用户确认。
- 禁止范围：不得直接修改 `projects/_template/`；不得复制测试项目内容；不得创建新项目。
- 验收标准：给出现模板适配项、不适配项、建议新增字段 / 目录、是否需要独立模板的判断。
- 备注：2026-05-28 已完成 `projects/_template` 教辅短剧适配审计，并归档到 `docs/AI-CONTEXT/archive/TEMPLATE-001-PROJECT-TEMPLATE-AUDIT.md`。结论是现有模板可作为 shell 基础复用，但必须先设计教辅字段方案。

### [x] TEMPLATE-002：设计教辅短剧项目模板字段方案

- 目标：基于 `TEMPLATE-001` 审计结果，设计教辅短剧项目模板字段、文件语义、生产稿包边界和状态字段方案。
- 修改范围：默认只输出或归档文档方案；如需修改 `projects/_template/` 或新增模板目录，必须另开任务并由用户确认。
- 禁止范围：不得直接修改 `projects/_template/`、`workflow/`、`scripts/`、`genre-skills/` 或 `projects/`；不得创建项目；不得运行验证脚本。
- 验收标准：给出 `PROJECT.md`、`PROJECT-STATE.json`、`STORY-SPEC.md`、`OUTLINE.md`、`PROJECT-MEMORY.md`、`reviews/`、`locked/` 等文件的字段方案；明确是扩展现有 `_template` 还是建议新增专用模板变体；列出迁移风险和验收标准。
- 备注：2026-05-28 已完成教辅短剧项目模板字段方案，并归档到 `docs/AI-CONTEXT/archive/TEMPLATE-002-EDU-SHORTDRAMA-FIELD-SPEC.md`。结论是当前先保留方案文档，不落地修改，下一步建议生成模板草案。

### [x] TEMPLATE-003：按字段方案生成教辅短剧模板草案

- 目标：基于 `TEMPLATE-002` 字段方案，生成教辅短剧模板草案，供用户判断是否落地为专用模板目录或扩展现有模板。
- 修改范围：默认只新增或更新用户确认的文档草案；如需修改 `projects/_template/`、新增 `projects/_template-edu-shortdrama/` 或创建项目，必须另开任务并由用户确认。
- 禁止范围：不得直接修改 `projects/_template/`、`workflow/`、`scripts/`、`genre-skills/` 或 `projects/`；不得运行验证脚本；不得创建项目。
- 验收标准：给出可审阅的教辅短剧模板草案，覆盖项目建档、状态字段、原文拆解、Scene 映射、正片剧本、字幕、分镜、审查、修订和生产稿包边界；明确下一步落地选项和风险。
- 备注：2026-05-28 已完成教辅短剧模板草案，并归档到 `docs/AI-CONTEXT/archive/TEMPLATE-003-EDU-SHORTDRAMA-TEMPLATE-DRAFT.md`。

### [x] TEMPLATE-004：由用户确认后落地教辅短剧模板目录

- 目标：在用户确认 `TEMPLATE-003` 草案后，新增教辅短剧专用模板目录，承载文言文教辅真人古风短剧项目的项目建档、状态、原文拆解、Scene 映射、审查、修订和生产稿包边界。
- 修改范围：仅限用户确认后的 `projects/_template-edu-shortdrama/` 候选模板目录，以及必要的上下文状态文件更新。
- 禁止范围：不得修改 `projects/_template/`；不得修改 `workflow/`、`scripts/`、`genre-skills/` 或现有 `projects/`；不得创建测试项目；不得运行验证脚本，除非用户另行授权。
- 验收标准：专用模板目录结构与 `TEMPLATE-003` 草案一致；旧 `_template` 未被改动；未创建项目；模板文件包含教辅短剧必要字段、门禁说明和生产稿包边界；完成后更新 `CURRENT-STATE.md`、`BACKLOG.md` 和 `LAST-TASK.md`。
- 备注：2026-05-28 已新增 `projects/_template-edu-shortdrama/` 教辅短剧专用模板目录，未修改旧 `projects/_template/`。

### [x] CONTRACT-001：扩展 Skill 合约以表达教辅生产能力

- 目标：扩展 `docs/GENRE-SKILL-CONTRACT.md`，让 Skill capabilities 能明确表达文言文教辅短剧生产所需能力。
- 修改范围：仅限用户确认后的 Skill 合约文档及必要的 AI-CONTEXT 状态文件。
- 禁止范围：不得修改 `genre-skills/`、`workflow/`、`scripts/`、`projects/`、`projects/_template/` 或 `projects/_template-edu-shortdrama/`；不得运行 Skill；不得生成剧本、分镜或视频提示词。
- 验收标准：合约能表达原文拆解、白话释义、教学目标、Scene 映射、字幕方案、分镜 / 镜头表、视频风险、教学准确性审查和生产稿包输出等能力；明确 Skill 与 shell 的边界；不把教辅规则硬编码进 shell。
- 备注：2026-05-28 已扩展 `docs/GENRE-SKILL-CONTRACT.md`，使 capabilities 能表达教辅生产能力，并归档到 `docs/AI-CONTEXT/archive/CONTRACT-001-SKILL-CONTRACT-EXTENSION.md`。

### [x] WORKFLOW-DOC-001：同步 workflow 文档中的教辅 Phase 语义

- 目标：在用户确认后更新 workflow 相关文档的 Phase 语义说明，让旧 Phase 0-8 与教辅短剧 Phase 映射一致。
- 修改范围：仅限用户确认后的 workflow 文档和必要的 AI-CONTEXT 状态文件。
- 禁止范围：不得修改 Hook、脚本、`genre-skills/`、`projects/` 或项目模板；不得运行测试；不得创建项目。
- 验收标准：workflow 文档清楚说明教辅短剧语义映射、用户确认门禁、Skill 边界和后置输出边界；不改变实际 workflow 逻辑。
- 备注：2026-05-28 已同步 workflow 文档中的教辅 Phase 语义，并归档到 `docs/AI-CONTEXT/archive/WORKFLOW-DOC-001-PHASE-SEMANTIC-SYNC.md`。

### [x] SKILL-002：按新合约补强 wenyan-skill 元数据

- 目标：基于 `CONTRACT-001` 扩展后的 Skill 合约，为 `genre-skills/wenyan-skill/SKILL.md` 补充 version、capabilities、fallbackRules 和 shellBoundary 元数据。
- 修改范围：仅限用户确认后的 `genre-skills/wenyan-skill/SKILL.md` 及必要的 AI-CONTEXT 状态文件。
- 禁止范围：不得修改 `workflow/`、`scripts/`、`projects/`、`projects/_template/` 或 `projects/_template-edu-shortdrama/`；不得运行测试；不得创建项目；不得生成剧本、分镜、视频提示词或创作内容。
- 验收标准：`wenyan-skill` 能按新合约声明教辅生产 capabilities；明确 fallbackRules 和 shellBoundary；不复制模板全文；不改变 Skill 现有规则文件主体内容。
- 备注：2026-05-28 已补强 `genre-skills/wenyan-skill/SKILL.md` 元数据，并归档到 `docs/AI-CONTEXT/archive/SKILL-002-WENYAN-METADATA-UPDATE.md`；未修改 Skill 规则主体、模板、workflow、scripts 或 projects。后续已进入 `VALIDATE-001` 基线记录。
