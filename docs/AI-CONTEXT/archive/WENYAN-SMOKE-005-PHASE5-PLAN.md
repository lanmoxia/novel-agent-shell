# WENYAN-SMOKE-005-PHASE5-PLAN：进入 Phase 5 教学与生产审查计划

- 任务编号：WENYAN-SMOKE-005-PHASE5-PLAN
- 任务名称：制定进入 Phase 5 教学与生产审查计划
- 完成日期：2026-05-29
- 当前状态：已完成计划制定，未进入 Phase 5

## 1. 制定计划的依据

本计划依据以下文件和结论制定：

- `docs/AI-CONTEXT/README.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-004-REVIEW.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-003-REVISION-RUN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-003-REVISION-PLAN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-002-REVIEW.md`
- `docs/AI-CONTEXT/archive/VALIDATE-007-EDU-ACTIVE-PROJECT-COMPAT-FIX.md`
- `genre-skills/wenyan-skill/SKILL.md`
- `genre-skills/wenyan-skill/templates/T-WY001-qingjing-fuyan.md`
- `genre-skills/wenyan-skill/examples/liangxiaor-bianri-example.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-STATE.json`
- `projects/wenyan-smoke-liangxiaor-bianri-001/specs/STORY-SPEC.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`

复核结论是：

- P0 = 0
- P1 = 0
- P2 仅剩不阻塞项
- 修订后 Phase 4 质量复核已通过

## 2. Phase 5 定义

Phase 5 定义为：

```text
教学与生产审查
```

它不是修订，不是锁稿，不是生成字幕 / 分镜 / 视频提示词，也不是完整生产稿包。

## 3. Phase 5 审查对象

计划中的 Phase 5 正式审查对象建议为：

- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/specs/STORY-SPEC.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`

如用户后续确认，也可把 `PROJECT-STATE.json` 作为状态参考，但本计划本身不更新它。

## 4. Phase 5 审查维度

计划中的 Phase 5 审查维度建议包括：

1. 原文准确性审查
2. 白话释义审查
3. 教学目标审查
4. 观点 / 证据结构审查
5. Scene 与原文映射审查
6. 草案对白自然度审查
7. 古风真人短剧可拍性审查
8. 字幕负载风险审查
9. 镜头人数与视频生成风险审查
10. 生产边界审查

## 5. Phase 5 允许输出

Phase 5 正式执行时，建议最多允许生成：

```text
projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase5-teaching-production-review.md
```

本计划不建议直接生成 `reviews/final-review.md`。

## 6. Phase 5 禁止输出

Phase 5 仍不得生成：

- `locked/FINAL-SCRIPT.md`
- `locked/LOCK-MANIFEST.sha256`
- `locked/SKILL-LOCK-MANIFEST.sha256`
- 正式字幕文件
- 正式分镜文件
- 视频提示词
- Seedance prompts
- 图像提示词
- 完整生产稿包

也不得补旧小说 / 剧本规划文件：

- `planning/REVERSE-OUTLINE.md`
- `planning/FORESHADOW-LEDGER.md`
- `planning/REVEAL-SCHEDULE.md`

## 7. Phase 5 状态处理规则

- Phase 5 正式执行前，必须先获得用户确认。
- 如果后续执行 Phase 5，才允许考虑更新 `PROJECT-STATE.json` 的 `phase`。
- 本轮计划任务不得更新烟测项目 `PROJECT-STATE.json`。
- Phase 5 执行后仍不得自动进入 Phase 6。

## 8. Phase 5 成功标准

Phase 5 正式执行后的成功标准建议包括：

1. 审查报告明确是否通过教学审查。
2. 审查报告明确是否通过生产边界审查。
3. 审查报告列出残留问题，按 P0 / P1 / P2 分级。
4. 审查报告明确是否建议进入 Phase 6 修订计划。
5. 审查报告不得输出正式字幕、正式分镜或视频提示词。

## 9. 用户确认项

用户后续执行 Phase 5 前，需要确认：

1. 是否进入 Phase 5。
2. 是否允许新增 `reviews/phase5-teaching-production-review.md`。
3. 是否允许更新 `PROJECT-STATE.json` 的 `phase` / `reviewStatus`。
4. 是否仍以 60 秒烟测结构作为审查对象。
5. 是否确认教材版本和目标年级。
6. 是否只做审查，不做修订。

## 10. 后续任务建议

后续只推荐一个任务：

```text
WENYAN-SMOKE-005-PHASE5-RUN：按用户确认范围执行 Phase 5 教学与生产审查
```

该任务必须等待用户确认后执行。

