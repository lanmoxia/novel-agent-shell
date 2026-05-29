# WENYAN-SMOKE-007-REVIEW：Phase 6 轻量修订结果复核

- 任务编号：WENYAN-SMOKE-007-REVIEW
- 任务名称：复核 Phase 6 轻量修订结果
- 完成日期：2026-05-29
- 状态：已完成只读复核

## 1. 复核范围

本轮只复核 `WENYAN-SMOKE-006-PHASE6-RUN` 后的轻量修订结果。

复核对象：

- Phase 6 是否只处理 3 个 P2
- 是否新增 P0 / P1
- 教材版本、目标年级、最终时长状态是否记录清楚
- S03 字幕负载是否压缩
- S05 主题收束是否弱化说教感
- 原文准确性是否仍保持
- 教学结构是否仍保持
- 生产边界是否仍保持
- 是否可以进入 Phase 7 计划制定

本轮不修改烟测项目正文，不进入 Phase 7 / 8，不锁稿，不生成正式字幕、正式分镜、视频提示词或生产稿包。

## 2. 读取文件列表

本轮按任务限定读取：

- `docs/AI-CONTEXT/README.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-006-PHASE6-RUN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-006-PHASE6-PLAN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-005-PHASE5-RUN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-005-PHASE5-PLAN.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-STATE.json`
- `projects/wenyan-smoke-liangxiaor-bianri-001/reviews/phase5-teaching-production-review.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/specs/STORY-SPEC.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`

未读取 Codex 全局 memory、`.claude/`、`workflow/settings*.json`、`workflow/`、仓库级 `scripts/` 源码、`projects/_template/`、`projects/_template-edu-shortdrama/`、`genre-skills/`、`docs/GENRE-SKILL-CONTRACT.md`、`AGENTS.md`、`README.md` 或 `docs/README.md`。

## 3. Phase 6 范围复核

结论：通过。

证据：

- `WENYAN-SMOKE-006-PHASE6-RUN.md` 明确本轮只处理三个 P2。
- `SMOKE-DRAFT.md` 的正文修改集中在 S03 和 S05。
- `SCRIPT-STATUS.md`、`RUN-LOG.md` 和 `PROJECT-MEMORY.md` 只同步 Phase 6 轻量修订状态、确认项和生产边界。
- 未修改 `STORY-SPEC.md`、Phase 5 审查报告、模板、Skill、workflow 或仓库级 scripts。

是否阻塞进入 Phase 7 计划制定：否。

## 4. P2 处理结果

### P2-1：教材版本 / 目标年级 / 最终时长确认状态

结论：已解决。

证据：

- `SCRIPT-STATUS.md` 记录：
  - 教材版本仍待用户确认。
  - 目标年级仍待用户确认。
  - 最终时长当前仍按约 60 秒烟测结构处理，正式化前待用户确认。
- `RUN-LOG.md` 和 `PROJECT-MEMORY.md` 已同步同等语义。
- `STORY-SPEC.md` 未被修改，未虚构教材版本或目标年级。

是否阻塞进入 Phase 7 计划制定：否。

### P2-2：S03 证据句字幕负载压缩

结论：已解决。

证据：

- `SMOKE-DRAFT.md` S03 保留两条原文证据：
  - `日初出大如车盖，日中如盘盂。`
  - `日初出沧沧凉凉，日中如探汤。`
- Phase 6 删除了附加解释句，减少了后续字幕承载压力。
- `OUTLINE.md` 已同步为“证据短句已压缩，仍不生成正式字幕表”。
- 未生成正式字幕文件，未加入现代天文学答案。

是否阻塞进入 Phase 7 计划制定：否。

### P2-3：S05 主题收束说教感弱化

结论：已解决。

证据：

- `SMOKE-DRAFT.md` S05 保留：
  - `孰为汝多知乎？`
  - `谁说你很有智慧呢？`
- 旁白已弱化为更开放的收束：

```text
这一问，留给后来人继续想。
```

- `SMOKE-DRAFT.md` 明确不处理成嘲讽，也不让孔子给出现代科学答案。
- `OUTLINE.md` 已同步为“弱化主题收束”。

是否阻塞进入 Phase 7 计划制定：否。

## 5. 原文准确性复核

结论：通过。

复核结果：

- 《两小儿辩日》的核心事件链仍准确：孔子东游 -> 见两小儿辩斗 -> 两方观点 -> 两方证据 -> 孔子不能决 -> 两小儿反问。
- `孔子不能决也` 仍在 S04 保留。
- `孰为汝多知乎？` 仍在 S05 保留。
- 白话 `谁说你很有智慧呢？` 仍在 S05 保留。
- 未让孔子给出现代科学答案。
- 未把两小儿处理成恶意嘲讽。

## 6. 教学结构复核

结论：通过。

当前结构仍符合：

```text
入古境 -> 见事件 -> 起争辩 -> 摆观点 -> 举证据 -> 难判断 -> 回原文 -> 明主题
```

重点确认：

- S01 仍承担入古境、见事件、起争辩。
- S02 仍是观点层。
- S03 仍是证据层。
- S04 仍保留孔子不能决。
- S05 仍是原文回扣 + 白话释义 + 主题收束。

## 7. 生产边界复核

结论：通过。

复核结果：

- `PROJECT-STATE.json` 为 `phase: 6`。
- `PROJECT-STATE.json` 的 `status` 为 `phase6_light_revision_completed`。
- `locked` 仍为 `false`。
- `productionPackageStatus` 仍为 `not_generated`。
- `lockedArtifacts` 仍为空数组。
- 未进入 Phase 7 / 8。
- 未生成 `reviews/final-review.md`。
- 未生成 `locked/FINAL-SCRIPT.md`。
- 未生成 `locked/LOCK-MANIFEST.sha256`。
- 未生成 `locked/SKILL-LOCK-MANIFEST.sha256`。
- 未生成正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词或完整生产稿包。
- 未补旧小说规划文件 `REVERSE-OUTLINE.md`、`FORESHADOW-LEDGER.md` 或 `REVEAL-SCHEDULE.md`。

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

## 8. 残留问题清单

### P0：必须修复，否则不能进入任何下一步计划

无。

### P1：建议修复，否则不建议进入 Phase 7 计划

无。

### P2：可优化，不阻塞进入 Phase 7 计划

1. 教材版本、目标年级和最终时长仍需在正式化前由用户确认。

该 P2 已被清楚记录，不阻塞进入 Phase 7 计划制定。

## 9. 是否通过 Phase 6 轻量修订复核

通过。

理由：

- Phase 6 只处理了三个 P2。
- 未新增 P0。
- 未新增 P1。
- 原文准确性、教学结构和生产边界均保持。
- 校验均通过 0 error / 0 warning。

## 10. 是否建议进入 Phase 7 计划制定

建议进入 Phase 7 计划制定。

注意：本轮不进入 Phase 7，不生成 `reviews/final-review.md`，不锁稿，不生成正式字幕 / 分镜 / 视频提示词 / 生产稿包。

是否建议继续 Phase 6 修订：否。

## 11. 后续任务建议

后续只推荐一个任务：

```text
WENYAN-SMOKE-008-PHASE7-PLAN：制定进入 Phase 7 锁稿前审查计划
```
