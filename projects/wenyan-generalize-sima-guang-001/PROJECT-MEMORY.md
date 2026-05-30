# 项目记忆

本文件记录 `wenyan-generalize-sima-guang-001` 的烟测稳定事实。它不是正式生产项目记忆。

## 稳定事实

- 篇目为《司马光》。
- 当前任务为 `WENYAN-GENERALIZE-005-PHASE8-PLAN`。
- 当前阶段为 Phase 8 planned。
- 当前状态为 Phase 8 锁稿计划已完成，Phase 8 Run 未执行。
- 本项目用于第二篇文言文泛化测试。
- 本轮验证事件危机型 / 行动解困型结构。
- 当前未锁稿。
- 当前未进入视频链路。
- Phase 5 审查结论为 P0=0、P1=0、P2=6。
- Phase 6 已处理观看张力、儿童化判断、人物调度、安全表达和学习闭环相关 P2。
- Phase 7 锁稿前审查结论为 P0=0、P1=0、P2=4。
- 当前允许在用户确认后进入 Phase 8 Run。
- 当前仍未锁稿。
- 当前未进入视频链路。
- 后续应先执行 Phase 8 Run，生成剧本文本锁稿资产；不得跳过用户确认直接锁稿或进入视频链路。

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
- 当前未生成 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md` 或锁稿 manifest。
- 当前未锁稿。
- 当前未进入视频链路。
- Phase 8 Run 完成后也只能写成第二篇泛化样本完成剧本文本锁稿，不能写成 `wenyan-skill` 已完成全部泛化验证。

## 视频风险记忆

- 儿童角色多镜头稳定性风险。
- 坠瓮危机容易被写得过度惊悚。
- 击瓮动作容易被写成武打或超能力。
- 水流和破瓮画面在后置视频阶段有生成风险。
- 本轮不生成正式分镜、Seedance prompt 或视频提示词。

## 禁止事项

- 不把 `scripts/SMOKE-DRAFT.md` 当作最终剧本。
- 不跳过用户确认直接执行 Phase 8 Run。
- 不生成或覆盖 `locked/FINAL-SCRIPT.md`。
- 不生成 `reviews/final-review.md`。
- 不生成锁稿 manifest。
- 不生成正式字幕、正式分镜或视频提示词。
- 不进入分镜提示词、Seedance2.0 提示词或视频生产阶段。
- 不为通过校验补旧小说 / 剧本规划文件。

## 问题记录

- safe.directory：直接运行普通 Git 命令时触发 dubious ownership / safe.directory 阻断提示；已使用 `git -c safe.directory=C:/Users/Administrator/Desktop/novel-agent-shell-demo ...` 复跑并通过。
- LF/CRLF：Windows Git 可能提示 LF 将被替换为 CRLF；这是换行提示，不影响内容和校验。
- 状态文档矛盾：`PROJECT.md`、`STORY-SPEC.md`、`OUTLINE.md` 等早期阶段文件仍保留 Phase 4 / 尚未 Phase 5 等历史表述；本轮范围不允许修改，Phase 8 Run 计划建议做最小一致性修正，最新状态以 `PROJECT-STATE.json`、`PROJECT-MEMORY.md`、`RUN-LOG.md` 和 AI-CONTEXT 为准。
- 旧归档占位：`docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-004-PHASE7-PRELOCK-REVIEW.md` 的校验结果章节仍保留待最终输出占位；本轮不修改旧归档。
- 质量风险：儿童角色一致性、击瓮水流等视频化风险仍需后置视频 Skill 控制；本轮不生成视频方案。
