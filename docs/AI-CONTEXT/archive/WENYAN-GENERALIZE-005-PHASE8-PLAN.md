# WENYAN-GENERALIZE-005-PHASE8-PLAN：《司马光》剧本文本锁稿计划

- 任务编号：WENYAN-GENERALIZE-005-PHASE8-PLAN
- 任务名称：《司马光》剧本文本锁稿计划
- 完成日期：2026-05-30
- 状态：已完成 Phase 8 锁稿计划，未执行锁稿

## 1. 任务背景

《司马光》第二篇文言文泛化测试已完成 Phase 4 烟测草案、Phase 5 教学与生产审查、Phase 6 轻量修订和 Phase 7 锁稿前审查。

Phase 7 审查结论为 P0=0、P1=0、P2=4，允许在用户确认后进入 Phase 8 锁稿计划制定。本轮只制定 Phase 8 Run 的执行方案，不生成 `FINAL-SCRIPT.md`，不生成 `final-review.md`，不生成 manifest，不锁稿，不进入视频链路。

## 2. 当前项目状态

- 项目目录：`projects/wenyan-generalize-sima-guang-001/`
- 当前阶段：Phase 8 planned
- 当前状态：`phase8_planned`
- 锁稿状态：未锁稿
- 剧本文本来源：`projects/wenyan-generalize-sima-guang-001/scripts/SMOKE-DRAFT.md`
- 当前草案状态：Phase 6 轻量修订稿
- Phase 7 审查报告：`projects/wenyan-generalize-sima-guang-001/reviews/phase7-prelock-review.md`
- 视频链路状态：未启动
- 生产稿包状态：未生成

## 3. Phase 7 审查结论

Phase 7 锁稿前审查已通过：

- P0=0。
- P1=0。
- P2=4。
- 原文理解准确。
- 事件链完整。
- 事件危机型 / 行动解困型结构成立。
- Phase 6 已真实处理观看张力、儿童化判断、群儿调度、安全表达和学习闭环相关 P2。
- 允许在用户确认后进入 Phase 8 锁稿计划制定。
- 不允许自动进入 Phase 8 Run。
- 不允许自动锁稿。
- 不允许进入视频链路。

## 4. Phase 8 Run 是否允许

允许进入 Phase 8 Run，但必须等待用户明确确认。

Phase 8 Run 的目标是将 Phase 6 修订后的 `SMOKE-DRAFT.md` 整理为剧本文本锁稿资产，并同步 final review、manifest、状态文件和 AI-CONTEXT。

本轮只完成计划，不执行 Phase 8 Run。

## 5. Phase 8 Run 目标

下一轮 `WENYAN-GENERALIZE-005-PHASE8-RUN` 应完成：

1. 对 Phase 6 修订稿做最终文本锁稿审查。
2. 生成 `reviews/final-review.md`。
3. 生成 `locked/FINAL-SCRIPT.md`。
4. 生成 `locked/LOCK-MANIFEST.sha256`。
5. 生成 `locked/SKILL-LOCK-MANIFEST.sha256`。
6. 更新项目状态、项目记忆和运行日志。
7. 更新 AI-CONTEXT 状态和归档。
8. 保留 remaining P2，不把待确认项写成已确认。
9. 明确锁稿只针对剧本文本创作链路，不等同于正式教材最终版本定稿，也不启动视频链路。

## 6. Phase 8 Run 允许生成的文件

下一轮 Phase 8 Run 允许生成：

- `projects/wenyan-generalize-sima-guang-001/reviews/final-review.md`
- `projects/wenyan-generalize-sima-guang-001/locked/FINAL-SCRIPT.md`
- `projects/wenyan-generalize-sima-guang-001/locked/LOCK-MANIFEST.sha256`
- `projects/wenyan-generalize-sima-guang-001/locked/SKILL-LOCK-MANIFEST.sha256`
- `docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-005-PHASE8-RUN.md`

这些文件只服务剧本文本锁稿，不得扩展为正式字幕、正式分镜、视频提示词或生产稿包。

## 7. Phase 8 Run 允许修改的文件

下一轮 Phase 8 Run 允许更新：

- `projects/wenyan-generalize-sima-guang-001/PROJECT-STATE.json`
- `projects/wenyan-generalize-sima-guang-001/PROJECT-MEMORY.md`
- `projects/wenyan-generalize-sima-guang-001/RUN-LOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`

建议下一轮 Phase 8 Run 允许对以下文件做最小一致性修正：

- `projects/wenyan-generalize-sima-guang-001/PROJECT.md`
- `projects/wenyan-generalize-sima-guang-001/specs/STORY-SPEC.md`
- `projects/wenyan-generalize-sima-guang-001/outlines/OUTLINE.md`

最小一致性修正边界：

- 只修正当前阶段、当前状态、边界说明和“尚未进入 Phase 5”等早期阶段表述。
- 不重写原文拆解。
- 不重写故事规格。
- 不重写 Scene 结构。
- 不新增场次、新支线、新角色或新剧情。
- 不修改 `SMOKE-DRAFT.md`。
- 不生成视频链路内容。

判断：建议在 Phase 8 Run 中执行上述最小一致性修正。原因是这些文件属于项目核心说明 / 规格 / 大纲，若锁稿后仍显示“Phase 4”或“尚未进入 Phase 5”，会影响新窗口接力和锁稿状态判断。修正应仅限状态表述，不改变创作内容。

## 8. Phase 8 Run 禁止事项

下一轮 Phase 8 Run 仍禁止：

- 不得重新创作一个全新剧本。
- 不得修改 `scripts/SMOKE-DRAFT.md`。
- 不得引入新场次、新支线、新角色或新剧情结构。
- 不得把教材版本、目标年级、最终时长、原文采用版本写成已确认。
- 不得生成正式字幕。
- 不得生成正式分镜。
- 不得生成 Seedance prompts 或 Seedance2.0 prompt。
- 不得生成视频提示词。
- 不得生成图像提示词。
- 不得生成生产稿包。
- 不得修改 short-drama-shotlists 正式内容。
- 不得修改 seedance-prompts 正式内容。
- 不得修改《两小儿辩日》锁稿资产。
- 不得修改 `wenyan-skill` 核心规则。
- 不得把 `wenyan-skill` 写成已完成全部泛化验证。
- 不得把视频链路写成已启动。

## 9. FINAL-SCRIPT 内容来源

`locked/FINAL-SCRIPT.md` 应以以下文件为主要来源：

- `projects/wenyan-generalize-sima-guang-001/scripts/SMOKE-DRAFT.md`

参考文件：

- `projects/wenyan-generalize-sima-guang-001/materials/SOURCE-TEXT.md`
- `projects/wenyan-generalize-sima-guang-001/specs/STORY-SPEC.md`
- `projects/wenyan-generalize-sima-guang-001/outlines/OUTLINE.md`
- `projects/wenyan-generalize-sima-guang-001/reviews/phase5-teaching-production-review.md`
- `projects/wenyan-generalize-sima-guang-001/revisions/phase6-light-revision-notes.md`
- `projects/wenyan-generalize-sima-guang-001/reviews/phase7-prelock-review.md`

内容处理原则：

- 把 Phase 6 修订稿整理为锁稿文本。
- 保留 5 场结构。
- 保留原文绑定、白话释义和教学点。
- 保留事件危机型 / 行动解困型结构。
- 不新增新剧情。
- 不把锁稿文本改成分镜、字幕或视频提示词。

## 10. final-review 计划

`reviews/final-review.md` 应完成最终剧本文本审查，至少包含：

- 锁稿审查范围。
- 输入文件列表。
- Phase 7 审查结论引用。
- 原文准确性最终结论。
- 白话释义最终结论。
- 教学目标最终结论。
- Scene 与原文映射最终结论。
- 事件危机型 / 行动解困型结构最终结论。
- 剧作表达和儿童危机安全表达最终结论。
- 古风真人短剧可拍性最终结论。
- 生产边界最终结论。
- P0 / P1 / P2 最终清单。
- 剩余 P2 是否接受为非阻塞项。
- 是否允许锁稿。
- 未进入视频链路声明。

final-review 不能替代视频生产审查，不能生成分镜、字幕或视频提示词。

## 11. manifest 生成计划

`LOCK-MANIFEST.sha256` 建议记录以下锁稿相关文件的 SHA-256：

- `projects/wenyan-generalize-sima-guang-001/locked/FINAL-SCRIPT.md`
- `projects/wenyan-generalize-sima-guang-001/reviews/final-review.md`
- `projects/wenyan-generalize-sima-guang-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-generalize-sima-guang-001/specs/STORY-SPEC.md`
- `projects/wenyan-generalize-sima-guang-001/outlines/OUTLINE.md`
- `projects/wenyan-generalize-sima-guang-001/reviews/phase7-prelock-review.md`

`SKILL-LOCK-MANIFEST.sha256` 建议记录：

- `projects/wenyan-generalize-sima-guang-001/GENRE-SKILL-LOCK.md`
- `genre-skills/wenyan-skill/SKILL.md`

manifest 只证明剧本文本锁稿相关输入和输出的可追溯性，不代表视频链路启动。

## 12. 剩余 P2 处理计划

Phase 8 Run 必须继续保留 remaining P2：

- 教材版本待确认。
- 目标年级待确认。
- 最终时长待确认。
- 原文采用版本正式化前待确认。

处理规则：

- 不因这些 P2 未确认而阻塞剧本文本锁稿。
- 不把这些 P2 写成已确认。
- 在 final-review、PROJECT-STATE、PROJECT-MEMORY、RUN-LOG、AI-CONTEXT 中继续保留。
- 明确锁稿是剧本文本创作链路锁稿，不等同于正式教材最终版本定稿。

## 13. 状态文档矛盾处理计划

Phase 7 问题记录指出：

- `PROJECT.md` 仍保留 Phase 4 当前阶段表述。
- `specs/STORY-SPEC.md` 仍保留“当前项目已推进到 Phase 4 烟测草案，但尚未进入 Phase 5 教学与生产审查”等早期阶段语境。
- `outlines/OUTLINE.md` 仍保留“当前项目已推进到 Phase 4 烟测草案，但尚未进入 Phase 5 教学与生产审查”等早期阶段语境。

判断：

- 这些旧表述不阻塞本轮 Phase 8 Plan。
- 若不处理，会影响 Phase 8 Run 后的新窗口接力和锁稿状态判断。
- 建议 Phase 8 Run 中对这三份文件做最小一致性修正。

允许修正范围：

- 阶段标记。
- 当前状态。
- 是否已完成 Phase 5 / 6 / 7。
- 是否正在执行 Phase 8 Run。
- 未进入视频链路、未生成后置产物等边界说明。

禁止修正范围：

- 不改原文。
- 不改白话释义。
- 不改事件链。
- 不改教学目标。
- 不改 Scene 数量或结构。
- 不改关键对白方向。
- 不改 `SMOKE-DRAFT.md`。
- 不借机生成分镜、字幕、Seedance prompt 或视频提示词。

如果用户希望 Phase 8 Run 只动锁稿资产，也可以不修正这三份历史阶段文件；但应在 Phase 8 Run 的问题记录中继续声明最新状态以 `PROJECT-STATE.json`、`PROJECT-MEMORY.md`、`RUN-LOG.md`、AI-CONTEXT、`final-review.md` 和锁稿 manifest 为准。

## 14. 视频链路边界

本轮没有进入视频链路。下一轮 Phase 8 Run 也不得进入视频链路。

禁止生成：

- 正式字幕文件。
- 正式分镜文件。
- short-drama-shotlists 正式内容。
- Seedance prompts。
- Seedance2.0 prompt。
- 视频提示词。
- 图像提示词。
- 完整生产稿包。

后续如需分镜、Seedance2.0 或视频生产，应另开 `VIDEO-SKILL-001-PLAN` 或独立后置 Skill。

## 15. 问题记录

1. safe.directory：直接运行 `git status --short`、`git branch --show-current`、`git log --oneline --all --decorate -10` 时触发 dubious ownership / safe.directory 阻断提示。影响：普通 `git` 命令需显式声明安全目录；处理方式：使用 `git -c safe.directory=C:/Users/Administrator/Desktop/novel-agent-shell-demo ...` 复跑并通过；是否遗留：仅环境配置提示。
2. LF/CRLF：预计 `git diff --check` 或 `git add` 可能提示 LF 将被替换为 CRLF。影响：不影响内容和校验；处理方式：记录为 Windows Git 换行提示；是否遗留：仅环境提示。
3. 权限、路径、编码：未发现权限、路径或 UTF-8 编码问题。
4. 校验失败后修复：未发生校验失败后修复；`git diff --check`、项目校验、shell 校验均通过。
5. 未运行校验：无；本轮要求的 `git diff --check`、`git status --short`、`validate-edu-shortdrama-project`、`validate-shell` 均已运行。
6. 状态文档矛盾：`PROJECT.md`、`STORY-SPEC.md`、`OUTLINE.md` 仍保留早期阶段表述；本轮禁止修改这些文件，已在本计划中纳入 Phase 8 Run 最小一致性修正方案。是否遗留：有，等待下一轮用户确认后处理。
7. 旧归档占位：`docs/AI-CONTEXT/archive/WENYAN-GENERALIZE-004-PHASE7-PRELOCK-REVIEW.md` 的校验结果章节仍保留“待本轮校验后以最终输出为准”占位；本轮允许范围不包含修改旧归档，最终状态以对应提交记录、`LAST-TASK.md`、`RUN-LOG.md` 和本轮新状态为准。是否遗留：有。
8. 潜在越界风险：Phase 8 Run 允许生成锁稿资产，但本轮只制定计划；本轮未生成 `FINAL-SCRIPT`、`final-review` 或 manifest。是否遗留：无。
9. 质量风险：儿童角色一致性、击瓮水流等视频化风险仍需后置视频 Skill 控制；本轮只规划剧本文本锁稿，不生成视频方案。是否遗留：有，留给后置视频 Skill。

## 16. 下一步建议

下一步候选：

```text
WENYAN-GENERALIZE-005-PHASE8-RUN：执行《司马光》剧本文本锁稿，生成 final-review、FINAL-SCRIPT 和 manifest
```

其他候选：

- `WENYAN-GENERALIZE-004B-PHASE6-FOLLOWUP-REVISION`：如用户认为仍需修订，可回到 Phase 6。
- `VIDEO-SKILL-001-PLAN`：规划分镜 / Seedance2.0 后置 Skill。
- `CLEANUP-001-AUDIT`：只读仓库清理审计。

## 17. 必须等待用户确认的事项

必须等待用户确认后才能执行：

- 是否进入 `WENYAN-GENERALIZE-005-PHASE8-RUN`。
- 是否在 Phase 8 Run 中执行 `PROJECT.md`、`STORY-SPEC.md`、`OUTLINE.md` 的最小一致性修正。
- 是否接受教材版本、目标年级、最终时长、原文采用版本作为非阻塞 P2。
- 是否保持当前边界，不进入视频链路。
- 是否继续保留 `wenyan-skill` 为“第二篇泛化验证进行中 / 第二篇样本可锁稿”，而不是写成全泛化验证完成。

未经用户确认，不得执行锁稿，不得生成 `FINAL-SCRIPT`、`final-review` 或 manifest，不得进入视频链路。
