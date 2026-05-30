# 最近任务摘要

- 最近任务编号：WENYAN-GENERALIZE-005-PHASE8-PLAN
- 最近任务名称：《司马光》剧本文本锁稿计划
- 最近任务状态：已完成 Phase 8 锁稿计划，允许进入 Phase 8 Run，未锁稿
- 更新时间：2026-05-30

## 本轮修改摘要

- 新增 Phase 8 锁稿计划归档 `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-005-PHASE8-PLAN.md`。
- 更新 `projects/wenyan-generalize-sima-guang-001/PROJECT-STATE.json`。
- 更新 `projects/wenyan-generalize-sima-guang-001/PROJECT-MEMORY.md`。
- 更新 `projects/wenyan-generalize-sima-guang-001/RUN-LOG.md`。
- 更新 `docs/AI-CONTEXT/BACKLOG.md`。
- 更新 `docs/AI-CONTEXT/CURRENT-STATE.md`。
- 更新 `docs/AI-CONTEXT/LAST-TASK.md`。

## 执行结论

本轮已完成《司马光》Phase 8 剧本文本锁稿计划。

结论：

- 项目目录：`projects/wenyan-generalize-sima-guang-001/`。
- 当前阶段：Phase 8 planned。
- 当前状态：`phase8_planned`。
- Phase 8 Run：允许在用户确认后执行。
- Phase 8 Run 建议生成 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md`、`locked/LOCK-MANIFEST.sha256`、`locked/SKILL-LOCK-MANIFEST.sha256`。
- Phase 8 Run 建议对 `PROJECT.md`、`specs/STORY-SPEC.md`、`outlines/OUTLINE.md` 做最小一致性修正，仅限阶段标记、当前状态和边界说明。
- 本轮未生成 `reviews/final-review.md`。
- 本轮未生成 `locked/FINAL-SCRIPT.md`。
- 本轮未生成锁稿 manifest。
- 本轮未锁稿。
- 本轮未进入分镜、Seedance2.0、视频生产、正式字幕或生产稿包链路。
- 《两小儿辩日》锁稿资产保持不变。
- `wenyan-skill` 仍只能写成正在第二篇泛化验证中，不得写成已完成全部泛化验证。

## 下一步建议

```text
WENYAN-GENERALIZE-005-PHASE8-RUN：执行《司马光》剧本文本锁稿，生成 final-review、FINAL-SCRIPT 和 manifest
```

该方向必须等待用户明确确认后执行。不得自动执行 Phase 8 Run，不得直接锁稿或进入视频链路。

其他候选方向：

- `WENYAN-GENERALIZE-004B-PHASE6-FOLLOWUP-REVISION`：如后续仍需修订，可回到 Phase 6。
- `VIDEO-SKILL-001-PLAN`：规划分镜 / Seedance2.0 后置 Skill。
- `CLEANUP-001-AUDIT`：只读仓库清理审计。

## 需要按需读取的归档文件

- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-001-PLAN.md`
- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-001-RUN.md`
- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-002-PHASE5-REVIEW.md`
- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-003-PHASE6-LIGHT-REVISION.md`
- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-004-PHASE7-PRELOCK-REVIEW.md`
- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-005-PHASE8-PLAN.md`
- `projects/wenyan-generalize-sima-guang-001/PROJECT-STATE.json`
- `projects/wenyan-generalize-sima-guang-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-generalize-sima-guang-001/reviews/phase7-prelock-review.md`

## 问题记录摘要

- safe.directory：直接运行普通 Git 命令时触发 dubious ownership / safe.directory 阻断提示；已使用 `git -c safe.directory=...` 复跑并通过。
- LF/CRLF：预期可能出现 Windows Git 换行提示，不影响内容和校验。
- 状态文档矛盾：`PROJECT.md`、`STORY-SPEC.md`、`OUTLINE.md` 等早期阶段文件仍有 Phase 4 / 尚未 Phase 5 等历史表述；本轮范围不允许修改，Phase 8 Run 计划建议做最小一致性修正。
- 旧归档占位：`docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-004-PHASE7-PRELOCK-REVIEW.md` 的校验结果章节仍保留待最终输出占位；本轮不修改旧归档。
- 质量风险：儿童角色一致性、击瓮水流等视频化风险仍需后置视频 Skill 控制；本轮未生成视频方案。
