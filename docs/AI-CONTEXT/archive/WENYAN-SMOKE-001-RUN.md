# WENYAN-SMOKE-001-RUN：恢复执行记录

- 任务编号：WENYAN-SMOKE-001-RUN-RECOVERY
- 任务名称：恢复未完成的文言文教辅短剧烟测项目创建
- 执行日期：2026-05-29
- 当前状态：已补齐 Phase 0-4 烟测文件；顶层校验失败，任务暂停

## 1. recovery 说明

本轮是 recovery，不是从头重建。

上一轮 `WENYAN-SMOKE-001-RUN` 在创建目录结构后、准备写入 Phase 0-4 文件时因 `503 Service Unavailable` 中断。

本轮先检查目标目录现状，再只补齐缺失的允许文件。

## 2. 恢复前目标目录现状

目标目录：

```text
projects/wenyan-smoke-liangxiaor-bianri-001/
```

恢复前已存在目录：

- `drafts/`
- `drafts/rewrite-candidates/`
- `locked/`
- `materials/`
- `outlines/`
- `planning/`
- `reviews/`
- `revisions/`
- `revisions/snapshots/`
- `scripts/`
- `seedance-prompts/`
- `short-drama-shotlists/`
- `specs/`

恢复前已存在文件：

- 无

恢复前缺失的允许文件：

- `PROJECT.md`
- `PROJECT-STATE.json`
- `GENRE-SKILL-LOCK.md`
- `specs/STORY-SPEC.md`
- `planning/ENDING-LOCK.md`
- `outlines/OUTLINE.md`
- `scripts/SCRIPT-STATUS.md`
- `scripts/SMOKE-DRAFT.md`
- `RUN-LOG.md`
- `PROJECT-MEMORY.md`

恢复前是否发现禁止文件：未发现。

## 3. 本轮补齐文件

本轮新增：

- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-STATE.json`
- `projects/wenyan-smoke-liangxiaor-bianri-001/GENRE-SKILL-LOCK.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/specs/STORY-SPEC.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/planning/ENDING-LOCK.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`

## 4. 禁止文件检查

本轮未发现、未生成以下禁止文件：

- `locked/FINAL-SCRIPT.md`
- `reviews/final-review.md`
- `locked/LOCK-MANIFEST.sha256`
- `locked/SKILL-LOCK-MANIFEST.sha256`
- 正式字幕文件
- 正式分镜文件
- 视频提示词
- Seedance prompts
- 图像提示词
- 完整生产稿包

## 5. Phase 与草案状态

是否推进到 Phase 4：是。

是否生成 `SMOKE-DRAFT.md`：是。

`scripts/SMOKE-DRAFT.md` 已明确标注：

```text
烟测草案，不是最终生产稿。
```

本轮未进入：

- Phase 5 审查
- Phase 6 修订
- Phase 7 锁稿
- Phase 8 后置模块

## 6. 未修改范围

本轮未修改：

- `genre-skills/`
- `projects/_template/`
- `projects/_template-edu-shortdrama/`
- `workflow/`
- `scripts/`
- `docs/GENRE-SKILL-CONTRACT.md`
- `AGENTS.md`
- `README.md`
- `docs/README.md`
- `.claude/`
- `workflow/settings*.json`

## 7. 校验执行情况

已运行：

```bash
bash scripts/validate-shell.sh
```

结果：失败，退出码 1。

关键失败：

- `wenyan-smoke-liangxiaor-bianri-001: missing planning/REVERSE-OUTLINE.md`
- `wenyan-smoke-liangxiaor-bianri-001: missing planning/FORESHADOW-LEDGER.md`
- `wenyan-smoke-liangxiaor-bianri-001: missing planning/REVEAL-SCHEDULE.md`
- `wenyan-smoke-liangxiaor-bianri-001: phase 4 requires confirmedArtifacts.reverseOutline to be true.`

关键警告：

- `GENRE-SKILL-LOCK.md is locked but does not record capability source`
- `locked/SKILL-LOCK-MANIFEST.sha256 is missing`
- `scripts/ contains chapter files but reviews/final-review.md is missing`
- `scripts/ contains chapter files but planning/REVERSE-OUTLINE.md is not marked confirmed`

已运行：

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-shell.ps1
```

结果：失败，退出码 1。

关键失败：

- `wenyan-smoke-liangxiaor-bianri-001 missing planning\REVERSE-OUTLINE.md`
- `wenyan-smoke-liangxiaor-bianri-001 missing planning\FORESHADOW-LEDGER.md`
- `wenyan-smoke-liangxiaor-bianri-001 missing planning\REVEAL-SCHEDULE.md`
- `phase 4 requires confirmedArtifacts.reverseOutline to be true`
- `Project state recovery validation failed`

关键警告：

- `locked/SKILL-LOCK-MANIFEST.sha256 is missing`

## 8. 校验结论

校验未通过。

当前失败不是因为教辅模板专用校验失败；`projects/_template-edu-shortdrama/` 专用校验仍通过。

失败集中在真实烟测项目实例进入 active project 校验后，旧小说 / 剧本项目校验仍要求：

- `planning/REVERSE-OUTLINE.md`
- `planning/FORESHADOW-LEDGER.md`
- `planning/REVEAL-SCHEDULE.md`
- `confirmedArtifacts.reverseOutline == true`
- 锁定 Skill manifest / final review 等旧项目信号

这些文件和状态不在本轮用户允许生成范围内，因此本轮没有补充，也没有修改脚本、模板或 Skill。

## 9. 后续建议

下一步不建议直接进入 `WENYAN-SMOKE-002-REVIEW`。

建议先执行：

`VALIDATE-006-EDU-ACTIVE-PROJECT-COMPAT-AUDIT`：只读审计真实教辅项目实例与 active project 校验规则的兼容问题。

该任务应判断：

- active project 校验是否应识别 `projectType: edu-shortdrama`。
- 教辅项目是否应拥有独立实例校验脚本。
- 是否应允许 Phase 4 教辅项目不生成旧小说规划文件。
- 如何避免为通过旧校验而生成占位文件。
