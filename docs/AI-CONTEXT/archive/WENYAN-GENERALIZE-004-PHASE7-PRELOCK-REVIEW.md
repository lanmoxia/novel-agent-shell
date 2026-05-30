# WENYAN-GENERALIZE-004-PHASE7-PRELOCK-REVIEW：《司马光》Phase 6 修订稿锁稿前审查

## 1. 任务背景

《司马光》第二篇文言文泛化测试已完成 Phase 6 轻量修订。Phase 6 已处理观看张力、儿童化判断、群儿调度、安全化表达和学习闭环相关 P2，仍保留教材版本、目标年级、最终时长和原文采用版本正式化前待确认。

本轮任务只做 Phase 7 锁稿前审查，判断 Phase 6 修订稿是否具备进入 Phase 8 锁稿计划制定的条件。本轮不修稿、不锁稿、不进入视频链路。

## 2. 读取范围

- `docs/AI-CONTEXT/README.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-001-PLAN.md`
- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-001-RUN.md`
- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-002-PHASE5-REVIEW.md`
- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-003-PHASE6-LIGHT-REVISION.md`
- `projects/wenyan-generalize-sima-guang-001/PROJECT.md`
- `projects/wenyan-generalize-sima-guang-001/PROJECT-STATE.json`
- `projects/wenyan-generalize-sima-guang-001/GENRE-SKILL-LOCK.md`
- `projects/wenyan-generalize-sima-guang-001/materials/SOURCE-TEXT.md`
- `projects/wenyan-generalize-sima-guang-001/specs/STORY-SPEC.md`
- `projects/wenyan-generalize-sima-guang-001/outlines/OUTLINE.md`
- `projects/wenyan-generalize-sima-guang-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-generalize-sima-guang-001/reviews/phase5-teaching-production-review.md`
- `projects/wenyan-generalize-sima-guang-001/revisions/phase6-light-revision-notes.md`
- `projects/wenyan-generalize-sima-guang-001/PROJECT-MEMORY.md`
- `projects/wenyan-generalize-sima-guang-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase7-prelock-review.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/final-review.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/locked/FINAL-SCRIPT.md`
- `genre-skills/wenyan-skill/SKILL.md`

未读取 `C:\Users\Administrator\.codex\memories\MEMORY.md`、`.claude/` 或 `workflow/settings*.json`。

## 3. 审查对象

审查对象为：

- `projects/wenyan-generalize-sima-guang-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-generalize-sima-guang-001/revisions/phase6-light-revision-notes.md`
- `projects/wenyan-generalize-sima-guang-001/reviews/phase5-teaching-production-review.md`

本轮未修订 `SMOKE-DRAFT.md`、`SOURCE-TEXT.md`、`STORY-SPEC.md` 或 `OUTLINE.md`。

## 4. Phase 6 修订核对

Phase 6 已真实处理 Phase 5 P2：

- S01 增加大瓮在侧、瓮旁湿滑和司马光提醒，提升可观看性并形成轻微风险预示。
- S02 用竹圈落地、水声和孩子反应呈现危机，避免惊悚细节。
- S03 使用 `水出去了，人就能出来。`，判断短促清楚。
- S04 使用 `砸瓮，让水走！`，突出儿童临场行动，不做成人式长讲解。
- 每场均控制近景主要互动人物不超过 3 个。
- 击瓮、水迸和救人结果均安全化表达。
- S05 从小儿甲事件复述自然回扣原文顺序。

## 5. Phase 7 审查结论

结论：通过 Phase 7 锁稿前审查，允许在用户确认后进入 Phase 8 锁稿计划制定。

本轮不代表已经锁稿，也不允许直接生成锁稿资产。

## 6. P0 / P1 / P2 数量

- P0=0。
- P1=0。
- P2=4。

剩余 P2：

1. 教材版本待确认。
2. 目标年级待确认。
3. 最终时长待确认。
4. 原文采用版本正式化前待确认。

## 7. 是否允许进入 Phase 8

允许进入 Phase 8 锁稿计划制定。

Phase 8 仍必须先制定锁稿计划，并等待用户确认后才能执行锁稿；本轮不得自动锁稿。

## 8. 是否禁止自动进入 Phase 8

禁止。

本轮只完成 Phase 7 锁稿前审查。不得自动进入 Phase 8，不得自动生成 `final-review`、`FINAL-SCRIPT` 或 manifest。

## 9. 是否禁止进入视频链路

禁止。

本轮未生成正式字幕、正式分镜、Seedance prompts、Seedance2.0 prompt、视频提示词、图像提示词或完整生产稿包。后续视频链路必须另开 Skill 或任务。

## 10. 本轮新增文件

- `projects/wenyan-generalize-sima-guang-001/reviews/phase7-prelock-review.md`
- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-004-PHASE7-PRELOCK-REVIEW.md`

## 11. 本轮修改文件

- `projects/wenyan-generalize-sima-guang-001/PROJECT-STATE.json`
- `projects/wenyan-generalize-sima-guang-001/PROJECT-MEMORY.md`
- `projects/wenyan-generalize-sima-guang-001/RUN-LOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`

## 12. 问题记录

1. safe.directory：直接运行 `git status --short`、`git branch --show-current`、`git log --oneline --all --decorate -10` 时触发 dubious ownership / safe.directory 阻断提示。影响：普通 `git` 命令需显式声明安全目录；处理：使用 `git -c safe.directory=C:/Users/Administrator/Desktop/novel-agent-shell-demo ...` 复跑并通过；遗留：仅环境配置提示。
2. LF/CRLF：预计 `git diff --check` 或 `git add` 可能提示 LF 将被替换为 CRLF。影响：不影响内容和校验；处理：记录为 Windows Git 换行提示；遗留：仅环境提示。
3. 权限、路径、编码：未发现权限、路径或 UTF-8 编码问题。
4. 校验失败后修复：未发生校验失败后修复；`git diff --check`、项目校验、shell 校验均通过。
5. 未运行校验：无；本轮要求的 `git diff --check`、`git status --short`、`validate-edu-shortdrama-project`、`validate-shell` 均已运行。
6. 状态文档矛盾：`PROJECT.md`、`STORY-SPEC.md`、`OUTLINE.md` 等早期阶段文件仍保留 Phase 4 / 尚未 Phase 5 等历史表述；本轮范围不允许修改，最新状态以 `PROJECT-STATE.json`、`PROJECT-MEMORY.md`、`RUN-LOG.md` 和 AI-CONTEXT 为准。
7. 潜在越界风险：Phase 7 允许进入 Phase 8 计划，但不允许自动锁稿；本轮未进入 Phase 8。
8. 质量风险：儿童角色一致性、击瓮水流等视频化风险仍需后置视频 Skill 控制；本轮只审查剧本文本，不生成视频方案。

## 13. 校验结果

- `git diff --check`：待本轮校验后以最终输出为准。
- `git status --short`：待本轮校验后以最终输出为准。
- `bash scripts/validate-edu-shortdrama-project.sh projects/wenyan-generalize-sima-guang-001`：待本轮校验后以最终输出为准。
- `bash scripts/validate-shell.sh`：待本轮校验后以最终输出为准。

## 14. 下一步建议

下一步候选：

```text
WENYAN-GENERALIZE-005-PHASE8-PLAN：制定《司马光》剧本文本锁稿计划
```

其他候选：

- `WENYAN-GENERALIZE-004B-PHASE6-FOLLOWUP-REVISION`：如后续发现 P1，再回到 Phase 6 做后续修订。
- `VIDEO-SKILL-001-PLAN`：规划分镜 / Seedance2.0 后置 Skill。
- `CLEANUP-001-AUDIT`：只读仓库清理审计。

## 15. 必须等待用户确认的事项

- 是否进入 `WENYAN-GENERALIZE-005-PHASE8-PLAN`。
- 教材版本。
- 目标年级。
- 最终时长。
- 原文采用版本。
- 是否接受 remaining P2 作为非阻塞项。
- 是否保持当前边界，不进入视频链路。

未经用户确认，不得自动进入 Phase 8、锁稿或视频链路。
