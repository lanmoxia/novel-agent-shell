# WENYAN-SMOKE-006-PHASE6-PLAN：进入 Phase 6 的轻量修订计划

- 任务编号：WENYAN-SMOKE-006-PHASE6-PLAN
- 任务名称：制定进入 Phase 6 的修订计划
- 完成日期：2026-05-29
- 状态：已完成计划制定，未进入 Phase 6 执行

## 1. 制定计划的依据

本计划依据以下文件和结论制定：

- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-005-PHASE5-RUN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-005-PHASE5-PLAN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-004-REVIEW.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-003-REVISION-RUN.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-STATE.json`
- `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase5-teaching-production-review.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/specs/STORY-SPEC.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`

Phase 5 审查结论：

- 教学审查通过。
- 生产边界审查通过。
- P0 = 0。
- P1 = 0。
- P2 = 3。

## 2. Phase 6 定义

Phase 6 定义为轻量修订阶段。

它不是锁稿，不是后置生产，不是正式字幕阶段，不是正式分镜阶段，也不是视频提示词或生产稿包生成阶段。

本轮只制定 Phase 6 修订计划，不执行修订，不修改项目正文，不更新 `PROJECT-STATE.json`，不进入 Phase 6 执行。

## 3. Phase 5 残留 P2 摘要

Phase 5 审查后仅剩三个非阻塞 P2：

1. 教材版本、目标年级和最终时长仍未在正式项目文档中完全定稿，正式化前仍需用户确认。
2. S03 的证据句在正式字幕阶段仍可继续压缩，降低后续字幕负载。
3. S05 的主题收束仍可再弱化一点说教感，但不阻塞进入 Phase 6。

## 4. P2 修订计划

### P2-1：教材版本 / 目标年级 / 时长确认

修订目标：

- 不在脚本正文中强行写死未确认信息。
- 后续执行 Phase 6 前，由用户确认教材版本、目标年级和目标时长是否仍采用约 60 秒烟测结构。
- 如用户确认，可在项目状态类文档中记录确认结果；如用户未确认，则保留为后续正式化前的待确认项。

建议处理方式：

- 优先把确认结果写入状态 / 记忆 / 运行记录类文件。
- 不建议为此改写 `SMOKE-DRAFT.md` 的剧情结构。
- 不建议把烟测项目升级为正式项目。

### P2-2：S03 字幕负载压缩方向

修订目标：

- 保留 S03 的证据层功能。
- 保留两条原文证据：大小证据与冷热证据。
- 降低后续正式字幕承载压力。

建议压缩方向：

- 将 S03 的说明性表达控制为短句。
- 避免同一屏同时堆叠原文、白话、术语解释和教学总结。
- 保留“车盖 / 盘盂”和“沧沧凉凉 / 探汤”的证据对照，但不展开现代科学解释。
- 如后续需要修改正文，优先轻改 `SMOKE-DRAFT.md` 的 S03 对白或教学点，不扩大到正式字幕文件。

### P2-3：S05 主题收束弱化方向

修订目标：

- 保留“孰为汝多知乎？”与白话释义。
- 保留“敢于质疑 / 学无止境 / 观察角度不同”的教学闭环。
- 进一步弱化直白说教感，让主题从人物情境中自然落下。

建议弱化方向：

- 避免新增口号式旁白。
- 不把两小儿写成嘲讽孔子。
- 不把孔子写成现代科学解释者。
- 如后续需要修改正文，优先轻改 S05 旁白句，不改动原文反问句和白话释义。

## 5. 后续允许修改文件建议

如果用户后续确认执行 Phase 6，最多建议允许修改：

- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/LAST-TASK.md`

是否允许修改 `PROJECT-STATE.json`：

- 本轮不允许修改。
- 后续执行 `WENYAN-SMOKE-006-PHASE6-RUN` 时，如需把状态从 Phase 5 推进到 Phase 6，必须由用户明确确认。

## 6. 后续禁止生成内容

Phase 6 后续执行时仍禁止生成：

- `reviews/final-review.md`
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

同时不得修改：

- `workflow/`
- 仓库级 `scripts/`
- `projects/_template/`
- `projects/_template-edu-shortdrama/`
- `genre-skills/`

## 7. 是否进入 Phase 6 执行

否。

本轮只制定 Phase 6 修订计划，不执行修订，不修改烟测项目正文，不更新 `PROJECT-STATE.json`，不进入 Phase 7 / 8。

## 8. 用户确认项

执行 `WENYAN-SMOKE-006-PHASE6-RUN` 前，需要用户确认：

1. 是否允许进入 Phase 6 轻量修订执行。
2. 是否确认教材版本、目标年级和最终时长；如不确认，是否继续保留为待确认项。
3. 是否允许轻改 S03 对白或教学点以降低字幕负载。
4. 是否允许轻改 S05 旁白以弱化说教感。
5. 是否允许修改 `PROJECT-STATE.json`，将项目状态推进到 Phase 6。
6. 是否允许同步 `SCRIPT-STATUS.md`、`RUN-LOG.md` 和 `PROJECT-MEMORY.md`。

## 9. 成功标准

后续执行 Phase 6 的成功标准建议为：

1. 只处理三个 P2，不新增 P0 / P1 范围。
2. S03 更适合后续字幕承载，但仍保留观点 / 证据结构。
3. S05 主题收束更自然，但仍保留原文反问和白话释义。
4. 教材版本、目标年级和时长确认状态被清楚记录。
5. 不生成 `reviews/final-review.md`、锁稿、正式字幕、正式分镜、视频提示词或生产稿包。
6. 不修改模板、Skill、workflow 或仓库级 scripts。
7. 如修改 `PROJECT-STATE.json`，必须有用户明确确认。

## 10. 后续任务建议

后续只推荐一个任务：

```text
WENYAN-SMOKE-006-PHASE6-RUN：按用户确认范围执行 Phase 6 轻量修订
```

该任务必须等待用户确认后执行。
