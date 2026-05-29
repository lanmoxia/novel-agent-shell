# WENYAN-SMOKE-008-PHASE7-PLAN：制定进入 Phase 7 锁稿前审查计划

- 任务编号：WENYAN-SMOKE-008-PHASE7-PLAN
- 任务名称：制定进入 Phase 7 锁稿前审查计划
- 完成日期：2026-05-29
- 状态：已完成计划制定，未进入 Phase 7 执行

## 1. 制定计划的依据

本计划依据以下文件和结论制定：

- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-007-REVIEW.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-006-PHASE6-RUN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-006-PHASE6-PLAN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-005-PHASE5-RUN.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-STATE.json`
- `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase5-teaching-production-review.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/specs/STORY-SPEC.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`

Phase 6 复核结论：

- P0=0。
- P1=0。
- 仅剩不阻塞 P2：教材版本、目标年级和最终时长仍需在正式化前由用户确认。
- 原文准确性、教学结构和生产边界均保持。
- 当前 `PROJECT-STATE.json` 仍为 `phase: 6`，`locked: false`，`productionPackageStatus: not_generated`。

## 2. Phase 7 定义

Phase 7 定义为锁稿前审查阶段。

它不是锁稿阶段，不是 `final-review` 生成阶段，不是 `FINAL-SCRIPT` 生成阶段，也不是正式字幕、正式分镜、视频提示词或生产稿包生成阶段。

本轮只制定 Phase 7 锁稿前审查计划，不执行 Phase 7，不修改烟测项目正文，不更新 `PROJECT-STATE.json`，不生成 `reviews/final-review.md`，不生成 `locked/FINAL-SCRIPT.md`，不进入 Phase 8。

Phase 7 正式执行前，必须由用户确认教材版本、目标年级和最终时长，或明确允许继续以“未确认但不阻塞”的方式审查。Phase 7 正式执行后，才能判断是否建议进入真正锁稿阶段。

## 3. Phase 7 审查对象建议

后续正式执行 Phase 7 时，建议审查以下对象：

- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/specs/STORY-SPEC.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase5-teaching-production-review.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-STATE.json`

这些对象只用于锁稿前审查判断，不表示允许改写正文、锁稿或生成正式生产产物。

## 4. Phase 7 审查维度建议

后续正式执行 Phase 7 时，建议至少覆盖以下维度：

- 原文准确性最终复查。
- 白话释义最终复查。
- 教学目标最终复查。
- Scene 与原文映射最终复查。
- 观点 / 证据结构最终复查。
- 对白自然度复查。
- S03 字幕负载复查。
- S05 主题收束复查。
- 古风真人短剧可拍性复查。
- 镜头人数和视频生成风险复查。
- 剩余 P2 是否已接受或是否仍需用户确认。
- 锁稿条件是否满足。
- 生产边界是否仍未越界。

重点边界：

- 不把 `SMOKE-DRAFT.md` 直接视为最终生产稿。
- 不把 Phase 7 审查报告视为 `final-review`。
- 不用 Phase 7 代替真正锁稿流程。

## 5. Phase 7 允许输出建议

后续正式执行 Phase 7 时，最多建议允许新增：

- `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase7-prelock-review.md`

该文件应是锁稿前审查报告，只判断是否具备锁稿条件，不生成锁稿稿件。

不要建议生成：

- `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/final-review.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/locked/FINAL-SCRIPT.md`

## 6. Phase 7 禁止输出

Phase 7 仍不得生成：

- `locked/FINAL-SCRIPT.md`
- `locked/LOCK-MANIFEST.sha256`
- `locked/SKILL-LOCK-MANIFEST.sha256`
- 正式字幕文件
- 正式分镜文件
- 视频提示词
- Seedance prompts
- 图像提示词
- 完整生产稿包
- `planning/REVERSE-OUTLINE.md`
- `planning/FORESHADOW-LEDGER.md`
- `planning/REVEAL-SCHEDULE.md`

Phase 7 也不得修改模板、Skill、workflow 或仓库级 scripts。

## 7. Phase 7 状态处理规则

- 本轮计划任务不得更新 `PROJECT-STATE.json`。
- Phase 7 正式执行前，需要用户确认。
- 如果后续执行 Phase 7，才允许考虑把 `PROJECT-STATE.json` 的 `phase` 更新为 `7`。
- 是否允许更新 `PROJECT-STATE.json` 的 `phase` / `reviewStatus` 必须由用户明确确认。
- Phase 7 执行后仍不得自动进入 Phase 8。
- Phase 7 只判断是否具备锁稿条件，不直接锁稿。
- Phase 7 审查报告如建议进入锁稿，也只能推荐后续 Phase 8 锁稿计划，不得直接生成锁稿产物。

## 8. 用户确认项

执行 `WENYAN-SMOKE-008-PHASE7-RUN` 前，需要用户确认：

1. 是否进入 Phase 7 锁稿前审查。
2. 是否允许新增 `reviews/phase7-prelock-review.md`。
3. 是否允许更新 `PROJECT-STATE.json` 的 `phase` / `reviewStatus`。
4. 教材版本是否确认。
5. 目标年级是否确认。
6. 最终时长是否确认，是否仍按约 60 秒结构审查。
7. 是否只做锁稿前审查，不做正文修订。
8. 是否仍禁止生成 `final-review` 和 `FINAL-SCRIPT`。

如用户不确认教材版本、目标年级或最终时长，也需要明确是否允许将这些项目作为“未确认但不阻塞”的 P2 继续审查。

## 9. 成功标准

后续正式执行 Phase 7 的成功标准建议为：

1. 审查报告明确是否具备锁稿条件。
2. 审查报告明确是否仍存在 P0 / P1 / P2。
3. 审查报告明确剩余 P2 是否可接受。
4. 审查报告明确是否建议进入 Phase 8 锁稿计划。
5. 不生成 `reviews/final-review.md`。
6. 不生成 `locked/FINAL-SCRIPT.md`。
7. 不生成正式字幕、正式分镜、视频提示词或生产稿包。
8. 不自动进入 Phase 8。
9. 不修改模板、Skill、workflow 或仓库级 scripts。

## 10. 后续任务建议

后续只推荐一个任务：

```text
WENYAN-SMOKE-008-PHASE7-RUN：按用户确认范围执行 Phase 7 锁稿前审查
```

该任务必须等待用户确认后执行。
