# 项目记忆

本文件记录 `wenyan-generalize-sima-guang-001` 的烟测稳定事实。它不是正式生产项目记忆。

## 稳定事实

- 篇目为《司马光》。
- 当前任务为 `WENYAN-GENERALIZE-006-SCRIPT-CREATION-BOUNDARY-FREEZE`。
- 当前阶段为 Phase 8 locked。
- 当前状态为 Phase 8 剧本文本锁稿已完成，剧本创作链路完成状态已冻结。
- 本项目用于第二篇文言文泛化测试。
- 本轮验证事件危机型 / 行动解困型结构。
- 当前已完成剧本文本锁稿。
- 当前未进入视频链路。
- Phase 5 审查结论为 P0=0、P1=0、P2=6。
- Phase 6 已处理观看张力、儿童化判断、人物调度、安全表达和学习闭环相关 P2。
- Phase 7 锁稿前审查结论为 P0=0、P1=0、P2=4。
- 原 `WENYAN-GENERALIZE-005-PHASE8-RUN` 因 remote compact 504 Gateway Timeout 中断。
- 本轮 `WENYAN-GENERALIZE-005-PHASE8-RUN-RECOVER` 已接续恢复并完成锁稿。
- 当前未进入视频链路。
- 后续不得自动进入视频链路；如进入视频方向，必须另开 `VIDEO-SKILL-001-PLAN`。

## 原文事实

- 群儿在庭院里玩耍。
- 一个孩子爬上大瓮。
- 孩子失足跌入瓮中水里。
- 众人惊慌离开。
- 司马光拿起石头击破大瓮。
- 水流出来，孩子得救。

## 教学点

- 能按事件顺序复述原文。
- 理解“于”“登”“没”“皆”“弃”“持”“击”“之”“迸”“得活”等词。
- 理解“众皆弃去”与“光持石击瓮破之”的对比。
- 理解司马光的冷静、判断和行动力。
- 理解解决问题时可以先改变条件：让水流出。

## Scene 映射记忆

- S01：群儿戏于庭，建立古风庭院和孩童游戏。
- S02：一儿登瓮，足跌没水中，触发危机。
- S03：众皆弃去，表现群体惊慌并形成对比。
- S04：光持石击瓮破之，呈现判断和行动解困。
- S05：水迸，儿得活，完成原文回扣和学习闭环。

## Phase 6 已处理 P2

- 强化 S01 的可观看性和轻微风险预示。
- 优化 S03-S04 的司马光判断瞬间，使表达更短促、更儿童化。
- 压缩群儿调度，明确单镜头主要互动人物不超过 3 个。
- 安全化坠瓮、击瓮和水流表现。
- 柔化 S05 学习闭环，让原文顺序复述从剧情结果自然收束。

## 剩余 P2

- 教材版本、目标年级、最终时长和原文采用版本仍需正式化前由用户确认。

## Phase 7 审查结论

- P0=0。
- P1=0。
- P2=4。
- 允许进入 Phase 8 锁稿计划制定。
- 不允许自动进入 Phase 8。
- 不允许自动锁稿。
- 当前仍未生成 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md` 或锁稿 manifest。
- 当前仍未进入正式字幕、正式分镜、Seedance prompt、视频提示词或生产稿包链路。

## Phase 8 锁稿计划结论

- 本轮已完成 Phase 8 锁稿计划。
- Phase 8 Run 允许在用户确认后执行。
- Phase 8 Run 建议生成：
  - `reviews/final-review.md`
  - `locked/FINAL-SCRIPT.md`
  - `locked/LOCK-MANIFEST.sha256`
  - `locked/SKILL-LOCK-MANIFEST.sha256`
  - `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-005-PHASE8-RUN.md`
- Phase 8 Run 可更新 `PROJECT-STATE.json`、`PROJECT-MEMORY.md`、`RUN-LOG.md` 和 AI-CONTEXT 状态文件。
- 建议 Phase 8 Run 对 `PROJECT.md`、`specs/STORY-SPEC.md`、`outlines/OUTLINE.md` 做最小一致性修正，仅限阶段标记、当前状态和边界说明，不改原文、剧情结构或 Scene 映射。
- 计划任务完成时尚未生成 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md` 或锁稿 manifest。
- 计划任务完成时尚未锁稿；恢复任务已完成锁稿，最新状态见下一节。
- 当前未进入视频链路。
- Phase 8 Run 完成后也只能写成第二篇泛化样本完成剧本文本锁稿，不能写成 `wenyan-skill` 已完成全部泛化验证。

## Phase 8 锁稿恢复结论

- `WENYAN-GENERALIZE-005-PHASE8-RUN` 在生成锁稿资产过程中因 remote compact 504 Gateway Timeout 中断。
- 该问题不是业务校验失败，而是远程 compact / 网络超时。
- 本轮 `WENYAN-GENERALIZE-005-PHASE8-RUN-RECOVER` 接续恢复，没有从零重写剧本。
- 已生成并保留 `reviews/final-review.md`。
- 已生成并保留 `locked/FINAL-SCRIPT.md`。
- 已生成 `locked/LOCK-MANIFEST.sha256`。
- 已生成 `locked/SKILL-LOCK-MANIFEST.sha256`。
- `PROJECT.md`、`STORY-SPEC.md`、`OUTLINE.md` 已完成最小一致性修正。
- `PROJECT-STATE.json` 已更新为 `phase8_locked`、`locked: true`。
- P0=0，P1=0，P2=4。
- 剩余 P2 为教材版本待确认、目标年级待确认、最终时长待确认、原文采用版本正式化前待确认。
- 未生成正式字幕、正式分镜、Seedance prompt、视频提示词、图像提示词或生产稿包。

## 剧本创作链路完成状态冻结

- `WENYAN-GENERALIZE-006-SCRIPT-CREATION-BOUNDARY-FREEZE` 已完成。
- 《司马光》Phase 8 剧本文本已锁稿。
- 剧本创作链路完成状态已冻结。
- 冻结报告：`reviews/script-creation-boundary-freeze.md`。
- 冻结归档：`docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-006-SCRIPT-CREATION-BOUNDARY-FREEZE.md`。
- 当前锁稿资产：
  - `reviews/final-review.md`
  - `locked/FINAL-SCRIPT.md`
  - `locked/LOCK-MANIFEST.sha256`
  - `locked/SKILL-LOCK-MANIFEST.sha256`
- 本轮未修改锁稿文本、final-review 或 manifest。
- 本轮未进入视频链路。
- 本轮未生成正式分镜、正式字幕、Seedance prompt、Seedance2.0 prompt、视频提示词、图像提示词或生产稿包。
- 剩余 P2 继续保留：教材版本待确认、目标年级待确认、最终时长待确认、原文采用版本正式化前待确认。
- 后续如进入视频方向，必须另开 `VIDEO-SKILL-001-PLAN` 并等待用户确认。
- 下一步候选包括 `VIDEO-SKILL-001-PLAN`、`CLEANUP-001-AUDIT`、`WENYAN-GENERALIZE-007-THIRD-TEXT-PLAN`、`HANDOFF-UPDATE-001`，均不得自动执行。

## 视频风险记忆

- 儿童角色多镜头稳定性风险。
- 坠瓮危机容易被写得过度惊悚。
- 击瓮动作容易被写成武打或超能力。
- 水流和破瓮画面在后置视频阶段有生成风险。
- 本轮不生成正式分镜、Seedance prompt 或视频提示词。

## 禁止事项

- 不修改 `scripts/SMOKE-DRAFT.md`。
- 不重新从零生成整套剧本。
- 不覆盖本轮锁定资产，除非后续任务明确授权修订。
- 不生成正式字幕、正式分镜或视频提示词。
- 不进入分镜提示词、Seedance2.0 提示词或视频生产阶段。
- 不为通过校验补旧小说 / 剧本规划文件。

## 问题记录

- safe.directory：直接运行普通 Git 命令时触发 dubious ownership / safe.directory 阻断提示；已使用 `git -c safe.directory=C:/Users/Administrator/Desktop/novel-agent-shell-demo ...` 复跑并通过。
- LF/CRLF：Windows Git 可能提示 LF 将被替换为 CRLF；这是换行提示，不影响内容和校验。
- remote compact 504 Gateway Timeout：上一轮 Phase 8 Run 中断，留下半成品；本轮已检查工作区、补齐缺失文件、完成校验和提交；无业务遗留。
- 剧本创作链路冻结：本轮只冻结完成状态，未修改 locked 资产、manifest、final-review 或视频链路内容。
- 状态文档矛盾：`PROJECT.md`、`STORY-SPEC.md`、`OUTLINE.md` 旧阶段表述已做最小一致性修正。
- 旧归档占位：`docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-004-PHASE7-PRELOCK-REVIEW.md` 的校验结果章节仍保留待最终输出占位；本轮不修改旧归档。
- 质量风险：儿童角色一致性、击瓮水流等视频化风险仍需后置视频 Skill 控制；本轮不生成视频方案。
