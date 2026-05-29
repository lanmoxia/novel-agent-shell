# WENYAN-SMOKE-009-PHASE8-PLAN：制定进入 Phase 8 锁稿计划

- 任务编号：WENYAN-SMOKE-009-PHASE8-PLAN
- 任务名称：制定进入 Phase 8 锁稿计划
- 完成日期：2026-05-29
- 状态：已完成计划制定，未进入 Phase 8 执行

## 1. 制定计划的依据

本计划依据以下文件和结论制定：

- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-008-PHASE7-RUN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-008-PHASE7-PLAN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-007-REVIEW.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-006-PHASE6-RUN.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-STATE.json`
- `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase7-prelock-review.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase5-teaching-production-review.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/specs/STORY-SPEC.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`

Phase 7 锁稿前审查结论：

- P0=0。
- P1=0。
- P2=1：教材版本、目标年级和最终时长仍需正式化前由用户确认。
- 当前具备进入 Phase 8 锁稿计划制定的条件。
- Phase 7 不是锁稿，未生成 `reviews/final-review.md` 或 `locked/FINAL-SCRIPT.md`。

## 2. Phase 8 定义

Phase 8 定义为锁稿阶段的计划与后续执行边界。

本轮 `WENYAN-SMOKE-009-PHASE8-PLAN` 只是制定 Phase 8 锁稿计划，不执行 Phase 8，不锁稿，不生成 `FINAL-SCRIPT`，不生成 `final-review`，不生成 `LOCK-MANIFEST`，也不生成正式字幕、正式分镜、视频提示词或生产稿包。

Phase 8 正式执行前，必须由用户再次确认是否允许生成锁稿相关文件。只有在后续 `WENYAN-SMOKE-009-PHASE8-RUN` 中，且用户明确确认范围后，才允许考虑生成锁稿产物。

当前主线目标是完成文言文教辅短剧的剧本创作链路验证。分镜提示词、Seedance2.0 提示词、图像提示词和视频生产链路将来应另开 Skill 或独立任务处理，不属于当前 `wenyan-skill` 剧本创作链路。

## 3. Phase 8 执行前提

后续正式执行 Phase 8 前，建议满足以下前提：

1. 用户明确确认进入 `WENYAN-SMOKE-009-PHASE8-RUN`。
2. 用户明确确认是否允许生成锁稿文件。
3. 用户明确确认教材版本、目标年级和最终时长，或明确接受该 P2 以“未确认但不阻塞”的形式保留。
4. 用户明确确认锁稿对象是当前烟测项目的 `scripts/SMOKE-DRAFT.md` 及其关联 `OUTLINE.md`、`STORY-SPEC.md`、审查报告和状态记录。
5. 用户明确确认 Phase 8 只锁定剧本创作链路，不进入正式字幕、正式分镜、视频提示词或生产稿包。
6. 执行前需确认禁止产物仍不存在，且项目未被其他任务改动。

## 4. Phase 8 候选锁稿对象

后续正式执行 Phase 8 时，候选锁稿对象建议包括：

- 剧本文本来源：`projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- 原文与教学依据：`projects/wenyan-smoke-liangxiaor-bianri-001/specs/STORY-SPEC.md`
- Scene 映射依据：`projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`
- 锁稿前审查依据：`projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase7-prelock-review.md`
- 生产边界依据：`projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- 状态依据：`projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-STATE.json`

上述对象用于判断和生成锁稿产物，不表示本轮允许修改这些文件。

## 5. Phase 8 允许输出建议

后续正式执行 `WENYAN-SMOKE-009-PHASE8-RUN` 时，最多建议在用户确认后允许生成或修改：

- `projects/wenyan-smoke-liangxiaor-bianri-001/locked/FINAL-SCRIPT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/locked/LOCK-MANIFEST.sha256`
- `projects/wenyan-smoke-liangxiaor-bianri-001/locked/SKILL-LOCK-MANIFEST.sha256`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-STATE.json`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`
- 必要的 AI-CONTEXT 状态文件和 Phase 8 执行归档

是否生成这些文件必须以用户后续确认的执行范围为准。本轮不生成上述任何锁稿文件。

## 6. Phase 8 仍禁止输出

即使后续进入 Phase 8 锁稿执行，也仍不得把锁稿任务扩大为后置生产任务。

Phase 8 仍禁止生成：

- `reviews/final-review.md`，除非用户后续另开明确任务并改变边界。
- 正式字幕文件。
- 正式分镜文件。
- 视频提示词。
- Seedance prompts。
- Seedance2.0 提示词。
- 图像提示词。
- 完整生产稿包。
- `planning/REVERSE-OUTLINE.md`
- `planning/FORESHADOW-LEDGER.md`
- `planning/REVEAL-SCHEDULE.md`

Phase 8 也不得修改模板、Skill、workflow 或仓库级 scripts。

## 7. Phase 8 锁稿标准建议

后续正式执行 Phase 8 时，建议锁稿标准为：

1. Phase 7 锁稿前审查已通过。
2. P0=0。
3. P1=0。
4. 剩余 P2 已被用户接受，或已在锁稿记录中清楚标注为不阻塞的确认项。
5. `SMOKE-DRAFT.md` 的原文事实、白话释义、教学目标、Scene 映射和生产边界未被破坏。
6. `FINAL-SCRIPT.md` 如生成，必须明确是烟测剧本链路锁稿产物，不是完整生产稿包。
7. `PROJECT-STATE.json` 只有在锁稿产物生成并校验通过后，才允许更新 `locked: true`、`phase: 8` 和相关 `lockedArtifacts`。
8. 未生成正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词或生产稿包。

## 8. Phase 8 状态处理规则

本轮计划任务不得更新 `PROJECT-STATE.json`。

后续执行 Phase 8 时，状态处理建议如下：

- 只有用户确认执行 `WENYAN-SMOKE-009-PHASE8-RUN` 后，才允许考虑将 `PROJECT-STATE.json` 的 `phase` 更新为 `8`。
- 只有锁稿产物真实生成且校验通过后，才允许将 `locked` 更新为 `true`。
- `productionPackageStatus` 不得更新为 `generated`，因为 Phase 8 不生成生产稿包。
- `lockedArtifacts` 只能记录实际生成的锁稿文件，不得记录不存在的文件。
- Phase 8 执行完成后不得自动进入正式字幕、分镜、视频提示词或生产包阶段。

## 9. 用户确认项

执行 `WENYAN-SMOKE-009-PHASE8-RUN` 前，需要用户确认：

1. 是否进入 Phase 8 锁稿执行。
2. 是否允许生成 `locked/FINAL-SCRIPT.md`。
3. 是否允许生成 `locked/LOCK-MANIFEST.sha256`。
4. 是否允许生成 `locked/SKILL-LOCK-MANIFEST.sha256`。
5. 是否允许更新 `PROJECT-STATE.json` 的 `phase`、`locked`、`status`、`lockedArtifacts` 和相关状态字段。
6. 教材版本是否确认。
7. 目标年级是否确认。
8. 最终时长是否确认，是否仍按约 60 秒结构锁稿。
9. 是否接受剩余 P2 以不阻塞方式保留。
10. 是否确认 Phase 8 只验证剧本创作链路，不测试分镜提示词、Seedance2.0 提示词或视频生产链路。
11. 是否仍禁止生成 `reviews/final-review.md`、正式字幕、正式分镜、视频提示词和生产稿包。

## 10. 成功标准

本轮计划任务成功标准：

- Phase 8 锁稿计划归档存在。
- `BACKLOG.md`、`CURRENT-STATE.md` 和 `LAST-TASK.md` 已同步当前状态。
- 未修改烟测项目正文。
- 未修改 `PROJECT-STATE.json`。
- 未执行 Phase 8。
- 未生成 `FINAL-SCRIPT`、`final-review`、锁稿 manifest、正式字幕、正式分镜、视频提示词或生产稿包。

后续正式执行 Phase 8 的成功标准建议为：

- 锁稿文件是否生成、生成哪些文件、校验结果和状态更新均可追溯。
- `PROJECT-STATE.json` 只记录真实生成的锁稿产物。
- 剩余 P2 处理方式被明确记录。
- 不进入分镜提示词、Seedance2.0 提示词或视频生产链路。
- 不生成完整生产稿包。

## 11. 后续任务建议

后续只推荐一个任务：

```text
WENYAN-SMOKE-009-PHASE8-RUN：按用户确认范围执行 Phase 8 锁稿
```

该任务必须等待用户确认后执行。
