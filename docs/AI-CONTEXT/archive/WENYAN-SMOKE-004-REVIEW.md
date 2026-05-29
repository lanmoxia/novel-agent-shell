# WENYAN-SMOKE-004-REVIEW：修订后 Phase 4 烟测草案质量复核

- 任务编号：WENYAN-SMOKE-004-REVIEW
- 任务名称：复核修订后的 Phase 4 烟测草案质量
- 完成日期：2026-05-29
- 当前状态：已完成只读复核

## 1. 复核范围

本轮只复核 `WENYAN-SMOKE-003-REVISION-RUN` 后的 Phase 4 烟测草案质量。

复核对象：

- `projects/wenyan-smoke-liangxiaor-bianri-001/`
- `scripts/SMOKE-DRAFT.md`
- `scripts/SCRIPT-STATUS.md`
- `outlines/OUTLINE.md`
- `RUN-LOG.md`
- `PROJECT-MEMORY.md`
- `PROJECT-STATE.json`

本轮未修改烟测项目，不进入 Phase 5 / 6 / 7 / 8，不生成正式审查、锁稿、字幕、分镜、视频提示词或生产稿包。

## 2. 读取文件列表

本轮按任务限定读取：

- `docs/AI-CONTEXT/README.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-003-REVISION-RUN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-003-REVISION-PLAN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-002-REVIEW.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-001-RUN.md`
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

未读取 Codex 全局 memory、`.claude/`、`workflow/settings*.json`、`workflow/`、仓库级 `scripts/`、`projects/_template/`、`projects/_template-edu-shortdrama/`、`docs/GENRE-SKILL-CONTRACT.md`、`AGENTS.md`、`README.md` 或 `docs/README.md`。

## 3. P1 复核结果

### P1-1：观点层与证据层分离

结论：已解决。

证据：

- `SMOKE-DRAFT.md` 的 S02 只呈现：
  - 小儿甲：日出时近，日中时远。
  - 小儿乙：日出时远，日中时近。
- S02 教学点明确写明不提前讲“日初出大”“日中热”“车盖”“盘盂”或“探汤”。
- `SMOKE-DRAFT.md` 的 S03 专门呈现：
  - 日初出大如车盖，日中如盘盂。
  - 日初出沧沧凉凉，日中如探汤。
- `OUTLINE.md` 已将 S02 标为观点层、S03 标为证据层。

是否仍阻塞进入下一步计划：否。

### P1-2：S05 白话释义

结论：已解决。

证据：

- `SMOKE-DRAFT.md` S05 包含：

```text
两小儿：孰为汝多知乎？
白话提示：谁说你很有智慧呢？
```

- S05 教学点明确回到：

```text
孰为汝多知乎？白话：谁说你很有智慧呢？
```

是否仍阻塞进入下一步计划：否。

### P1-3：降低口号化 / PPT 味

结论：已解决。

证据：

- 原先“敢问，敢想，也要知道学无止境”已替换为：

```text
原来，能提出问题，也要承认自己还有不懂之处。
```

- 新表达从情境中的“不知 / 不能决”自然收束，比原先口号化更弱。

是否仍阻塞进入下一步计划：否。

### P1-4：RUN-LOG 状态同步

结论：已解决。

证据：

- `RUN-LOG.md` 已补记 `VALIDATE-007-EDU-ACTIVE-PROJECT-COMPAT-FIX` 已完成。
- 已记录 Bash / PowerShell 顶层校验已通过。
- 已记录旧校验失败由 `projectType` 分流和教辅项目实例专用校验解决。
- 已记录 `WENYAN-SMOKE-002-REVIEW`、`WENYAN-SMOKE-003-REVISION-PLAN` 和 `WENYAN-SMOKE-003-REVISION-RUN`。
- 已记录当前仍停留 Phase 4，未进入 Phase 5。

是否仍阻塞进入下一步计划：否。

## 4. P2 复核结果

### P2-1：教材版本、目标年级和 60 秒时长

结论：可接受。

理由：

- `PROJECT.md` 和 `SCRIPT-STATUS.md` 仍保留教材版本、目标年级、60 秒时长为后续确认项。
- 这些事项会影响正式审查标准，但不阻塞 Phase 5 计划制定。

是否阻塞：否。

### P2-2：S03 证据对照信息密度

结论：可接受。

理由：

- S03 已从混合解释调整为两条短证据句。
- 仍保留两个证据成对出现。
- 未生成正式字幕表，也未展开复杂术语解释。
- 对 Phase 4 烟测草案而言，信息密度已降到可接受程度。

是否阻塞：否。

### P2-3：S01 题目钩子

结论：可接受。

理由：

- S01 已加入“太阳早晨近，还是中午近？”作为问题钩子。
- 该钩子直接来自《两小儿辩日》的核心争议，没有引入穿越、悬疑、玄幻或现代网络梗。

是否阻塞：否。

## 5. 原文准确性复核

结论：通过。

复核结果：

- 保留完整核心事件链：孔子东游 -> 两小儿辩斗 -> 两方观点 -> 两方证据 -> 孔子不能决 -> 两小儿反问。
- `SMOKE-DRAFT.md` 保留“孔子不能决也”，没有让孔子给出现代科学答案。
- S05 保留“孰为汝多知乎？”，没有误改原文反问。
- S05 明确语气是发问，不处理成嘲讽羞辱。
- 未把现代科学解释写成原文结论。

## 6. 教学结构复核

结论：通过。

修订后结构符合：

```text
入古境 -> 见事件 -> 起争辩 -> 摆观点 -> 举证据 -> 难判断 -> 回原文 -> 明主题
```

对应关系：

- S01：入古境、见事件、起争辩。
- S02：摆观点，且明确为观点层。
- S03：举证据，且明确为证据层。
- S04：难判断，保留“孔子不能决也”。
- S05：回原文、白话释义、主题收束。

## 7. 生产边界复核

结论：通过。

复核结果：

- `PROJECT-STATE.json` 仍为 `"phase": 4`。
- `locked` 仍为 `false`。
- `reviewStatus` 仍为 `not_started`。
- `productionPackageStatus` 仍为 `not_generated`。
- `SCRIPT-STATUS.md` 明确未进入 Phase 5 / 6 / 7。
- `SMOKE-DRAFT.md` 明确是“烟测草案，不是最终生产稿”。
- 未生成 `reviews/final-review.md`。
- 未生成 `locked/FINAL-SCRIPT.md`、`locked/LOCK-MANIFEST.sha256`、`locked/SKILL-LOCK-MANIFEST.sha256`。
- 未生成正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词或完整生产稿包。
- 未补旧小说规划文件 `REVERSE-OUTLINE.md`、`FORESHADOW-LEDGER.md`、`REVEAL-SCHEDULE.md`。

本轮运行校验：

```bash
bash scripts/validate-edu-shortdrama-project.sh
bash scripts/validate-shell.sh
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-edu-shortdrama-project.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-shell.ps1
```

结果均为 0 error / 0 warning。

## 8. 与 `wenyan-skill` 一致性复核

结论：通过。

复核结果：

- 仍服务文言文理解、释义、记忆和主题。
- 保留 T-WY001 情境复演型结构。
- 保留观点 + 证据结构。
- 保留关键文言句和白话释义。
- 避免玄幻、权谋、恋爱化。
- 仍是真人古风教辅短剧方向。
- 仍是烟测草案，不是最终生产稿。

## 9. 残留问题清单

### P0：必须修复，否则不能进入任何下一步计划

无。

### P1：建议修复，否则不建议进入 Phase 5 计划

无。

### P2：可优化，不阻塞进入 Phase 5 计划

1. 教材版本、目标年级和最终时长仍需在正式 Phase 5 计划或审查前由用户确认。
2. 未来若进入正式生产，可继续优化 S03 的字幕节奏和术语解释承载方式。

## 10. 是否通过修订后 Phase 4 质量复核

结论：通过。

理由：

- 4 个 P1 均已解决。
- 无 P0。
- 无残留 P1。
- 仅剩不阻塞的 P2 确认项。
- 原文准确性、教学结构、生产边界和 `wenyan-skill` 一致性均通过复核。

## 11. 是否建议进入 Phase 5 计划制定

建议进入 Phase 5 计划制定。

注意：本轮只是建议制定 Phase 5 计划，不进入 Phase 5，不生成 `reviews/final-review.md`。

## 12. 后续任务建议

后续只推荐一个任务：

```text
WENYAN-SMOKE-005-PHASE5-PLAN：制定进入 Phase 5 教学与生产审查计划
```

该任务应先制定 Phase 5 审查边界、审查对象、允许 / 禁止产物和用户确认项，不应直接生成正式审查文件。

