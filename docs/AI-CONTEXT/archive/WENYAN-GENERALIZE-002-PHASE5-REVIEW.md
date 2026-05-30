# WENYAN-GENERALIZE-002-PHASE5-REVIEW：《司马光》Phase 4 烟测草案教学与生产审查

## 1. 任务背景

《两小儿辩日》文言文教辅短剧剧本创作链路已完成 Phase 8 锁稿，并通过 `WENYAN-SMOKE-010-SCRIPT-CREATION-BOUNDARY-FREEZE` 明确冻结在剧本创作链路，不自动进入分镜、Seedance2.0 或视频生产。

`WENYAN-GENERALIZE-001-PLAN` 已规划《司马光》作为第二篇文言文泛化测试；`WENYAN-GENERALIZE-001-RUN` 已创建 `projects/wenyan-generalize-sima-guang-001/` 并推进到 Phase 4 smoke draft。

本轮任务只做 Phase 5 教学与生产审查，判断《司马光》Phase 4 烟测草案是否具备进入 Phase 6 轻量修订的条件。

## 2. 读取范围

- `docs/AI-CONTEXT/README.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-001-PLAN.md`
- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-001-RUN.md`
- `projects/wenyan-generalize-sima-guang-001/PROJECT.md`
- `projects/wenyan-generalize-sima-guang-001/PROJECT-STATE.json`
- `projects/wenyan-generalize-sima-guang-001/GENRE-SKILL-LOCK.md`
- `projects/wenyan-generalize-sima-guang-001/materials/SOURCE-TEXT.md`
- `projects/wenyan-generalize-sima-guang-001/specs/STORY-SPEC.md`
- `projects/wenyan-generalize-sima-guang-001/outlines/OUTLINE.md`
- `projects/wenyan-generalize-sima-guang-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-generalize-sima-guang-001/PROJECT-MEMORY.md`
- `projects/wenyan-generalize-sima-guang-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase5-teaching-production-review.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase7-prelock-review.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/final-review.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/locked/FINAL-SCRIPT.md`
- `genre-skills/wenyan-skill/SKILL.md`

未读取 `C:\Users\Administrator\.codex\memories\MEMORY.md`、`.claude/` 或 `workflow/settings*.json`。

## 3. 审查对象

审查对象为 `projects/wenyan-generalize-sima-guang-001/scripts/SMOKE-DRAFT.md` 及其配套原文材料、故事规格和大纲。

本轮未修订 `SMOKE-DRAFT.md`、`OUTLINE.md`、`SOURCE-TEXT.md` 或 `STORY-SPEC.md`。

## 4. Phase 5 审查结论

《司马光》Phase 4 烟测草案通过 Phase 5 教学与生产审查。

结论：

- 原文理解准确。
- 事件链完整。
- 事件危机型 / 行动解困型结构成立。
- 未机械套用《两小儿辩日》的争辩型 / 观点证据型结构。
- 文言句、白话释义、教学点和学习闭环均已保留。
- 生产边界清楚，未进入视频链路。
- 允许在用户确认后进入 Phase 6 轻量修订。

## 5. P0 / P1 / P2 数量

- P0=0。
- P1=0。
- P2=6。

P2 主要包括：

1. 教材版本、目标年级、最终时长和原文采用版本仍需正式化前确认。
2. 草案局部偏教学流程卡，观看张力偏弱。
3. 司马光判断瞬间可更自然、更儿童化。
4. 群儿调度需压缩，避免单镜头互动人物超过 3 个。
5. 坠瓮、水面、击瓮和水迸动作需安全化表达。
6. S05 学习闭环略直白，需在 Phase 6 柔化。

## 6. 是否允许进入 Phase 6

允许。

进入 Phase 6 的前提是用户另行确认。Phase 6 应只做轻量修订，不得重写为新项目，不得直接锁稿，不得生成视频链路内容。

## 7. 是否禁止进入 Phase 7/8

禁止自动进入 Phase 7 / Phase 8。

当前只是 Phase 5 审查完成，不代表已经完成修订、锁稿前审查或锁稿。

## 8. 是否禁止进入视频链路

禁止。

本轮未生成正式字幕、正式分镜、short-drama-shotlists 正式内容、Seedance prompts、Seedance2.0 prompt、视频提示词、图像提示词或生产稿包。后续视频链路必须另开任务或 Skill。

## 9. 本轮新增文件

- `projects/wenyan-generalize-sima-guang-001/reviews/phase5-teaching-production-review.md`
- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-002-PHASE5-REVIEW.md`

## 10. 本轮修改文件

- `projects/wenyan-generalize-sima-guang-001/PROJECT-STATE.json`
- `projects/wenyan-generalize-sima-guang-001/PROJECT-MEMORY.md`
- `projects/wenyan-generalize-sima-guang-001/RUN-LOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`

## 11. 校验结果

- `git diff --check`：通过。直接运行时因 safe.directory 限制失败，已使用 `git -c safe.directory=C:/Users/Administrator/Desktop/novel-agent-shell-demo diff --check` 复跑通过；仅有 LF/CRLF 提示，无 whitespace error。
- `git status --short`：仅包含本轮允许新增 / 修改文件。
- `bash scripts/validate-edu-shortdrama-project.sh projects/wenyan-generalize-sima-guang-001`：通过，0 error / 0 warning。
- `bash scripts/validate-shell.sh`：通过，0 error / 0 warning。

## 12. 下一步建议

下一步候选：

```text
WENYAN-GENERALIZE-003-PHASE6-LIGHT-REVISION：根据 Phase 5 审查结果进行轻量修订
```

其他候选：

- `WENYAN-GENERALIZE-003-REVISION-PLAN`：如用户希望先拆解 P2 修订项，可先制定修订计划。
- `VIDEO-SKILL-001-PLAN`：规划分镜 / Seedance2.0 后置 Skill。
- `CLEANUP-001-AUDIT`：只读仓库清理审计。

## 13. 必须等待用户确认的事项

- 是否进入 `WENYAN-GENERALIZE-003-PHASE6-LIGHT-REVISION`。
- 是否需要先制定 `WENYAN-GENERALIZE-003-REVISION-PLAN`。
- 教材版本。
- 目标年级。
- 最终时长。
- 原文采用版本。
- 是否使用统编版常见文本。
- 真人古风短剧风格强度。
- 输出侧重点：课堂导入、故事演绎，或记忆辅助。

未经用户确认，不得自动进入 Phase 6、Phase 7、Phase 8、锁稿或视频链路。
