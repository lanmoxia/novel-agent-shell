# 运行记录

## 2026-05-29 WENYAN-SMOKE-006-PHASE6-RUN

- 任务：按用户确认范围执行 Phase 6 轻量修订。
- 当前阶段：Phase 6。
- 当前状态：Phase 6 轻量修订已完成，等待 `WENYAN-SMOKE-007-REVIEW` 复核。
- 处理 P2：
  - 教材版本：仍待用户确认。
  - 目标年级：仍待用户确认。
  - 最终时长：当前仍按约 60 秒烟测结构处理，正式化前待用户确认。
  - S03：压缩证据句说明性负载，保留两条原文证据。
  - S05：弱化主题收束说教感，保留“孰为汝多知乎？”和“谁说你很有智慧呢？”。
- 未生成：`reviews/final-review.md`、`locked/FINAL-SCRIPT.md`、正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词或完整生产稿包。
- 未进入：Phase 7 / 8。
- 未修改：模板、Skill、workflow 或仓库级 scripts。
- 未补旧小说规划文件。
- 校验记录：
  - `bash scripts/validate-edu-shortdrama-project.sh`：通过，0 error / 0 warning。
  - `bash scripts/validate-shell.sh`：通过，0 error / 0 warning。
  - `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-edu-shortdrama-project.ps1`：通过，0 error / 0 warning。
  - `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-shell.ps1`：通过，0 error / 0 warning。
- 下一步：`WENYAN-SMOKE-007-REVIEW`。

## 2026-05-29 WENYAN-SMOKE-005-PHASE5-RUN

- 任务：按用户确认范围执行 Phase 5 教学与生产审查。
- 当前阶段：Phase 5。
- 当前状态：已生成 `reviews/phase5-teaching-production-review.md`，已同步 `PROJECT-STATE.json`。
- 审查结论：教学审查通过，生产边界审查通过，P0=0，P1=0，P2=3。
- 未生成：`reviews/final-review.md`、`locked/FINAL-SCRIPT.md`、正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词或完整生产稿包。
- 未进入：Phase 6 / 7 / 8。
- 校验记录：
  - `bash scripts/validate-edu-shortdrama-project.sh`：通过，0 error / 0 warning。
  - `bash scripts/validate-shell.sh`：通过，0 error / 0 warning。
  - `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-edu-shortdrama-project.ps1`：通过，0 error / 0 warning。
  - `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-shell.ps1`：通过，0 error / 0 warning。
- 下一步：`WENYAN-SMOKE-006-PHASE6-PLAN`。

## 2026-05-29 WENYAN-SMOKE-001-RUN-RECOVERY

- 任务：恢复并完成文言文教辅短剧烟测项目创建。
- 中断来源：上一轮 `WENYAN-SMOKE-001-RUN` 因 503 Service Unavailable 中断。
- 恢复前状态：目标目录与必要空目录已存在；允许文件均缺失；未发现禁止文件。
- 输入文本：《两小儿辩日》。
- 当前阶段：Phase 4。
- 当前状态：Phase 0-4 烟测文件已补齐，等待校验。
- 已生成：
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
- 未生成：
  - `locked/FINAL-SCRIPT.md`
  - `reviews/final-review.md`
  - 正式字幕文件
  - 长篇分镜
  - 视频提示词
  - Seedance prompts
  - 图像提示词
  - 完整生产稿包
- 下一步：运行允许的顶层校验并记录结果；如失败，只记录，不修改脚本、模板或 Skill。

## 2026-05-29 校验记录

- 执行命令：`bash scripts/validate-shell.sh`
- 结果：失败，退出码 1。
- 关键失败：
  - `wenyan-smoke-liangxiaor-bianri-001: missing planning/REVERSE-OUTLINE.md`
  - `wenyan-smoke-liangxiaor-bianri-001: missing planning/FORESHADOW-LEDGER.md`
  - `wenyan-smoke-liangxiaor-bianri-001: missing planning/REVEAL-SCHEDULE.md`
  - `wenyan-smoke-liangxiaor-bianri-001: phase 4 requires confirmedArtifacts.reverseOutline to be true.`
- 关键警告：
  - `locked/SKILL-LOCK-MANIFEST.sha256 is missing`
  - `scripts/ contains chapter files but reviews/final-review.md is missing`
  - `scripts/ contains chapter files but planning/REVERSE-OUTLINE.md is not marked confirmed`

- 执行命令：`powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-shell.ps1`
- 结果：失败，退出码 1。
- 关键失败：
  - `missing planning\REVERSE-OUTLINE.md`
  - `missing planning\FORESHADOW-LEDGER.md`
  - `missing planning\REVEAL-SCHEDULE.md`
  - `phase 4 requires confirmedArtifacts.reverseOutline to be true`
  - `Project state recovery validation failed`
- 关键警告：
  - `locked/SKILL-LOCK-MANIFEST.sha256 is missing`

## 失败处理

- 未修改 `workflow/`。
- 未修改 `scripts/`。
- 未修改 `genre-skills/`。
- 未修改 `projects/_template/` 或 `projects/_template-edu-shortdrama/`。
- 未补充禁外文件。
- 当前判断：烟测项目文件已补齐，但真实教辅项目实例与旧 active project 校验规则存在兼容问题。
- 下一步建议：先审计 active project 校验如何支持 `projectType: edu-shortdrama`，再决定是否进入烟测输出质量审查。

## 2026-05-29 状态同步记录

- `VALIDATE-007-EDU-ACTIVE-PROJECT-COMPAT-FIX` 已完成。
- Bash / PowerShell 顶层校验已通过。
- 旧校验失败已经由 `VALIDATE-007` 的 `projectType` 分流和教辅项目实例专用校验解决。
- 未为通过校验补充旧小说 / 剧本规划文件。
- 未生成 `planning/REVERSE-OUTLINE.md`、`planning/FORESHADOW-LEDGER.md` 或 `planning/REVEAL-SCHEDULE.md`。
- `WENYAN-SMOKE-002-REVIEW` 已完成。
- `WENYAN-SMOKE-003-REVISION-PLAN` 已完成。

## 2026-05-29 WENYAN-SMOKE-003-REVISION-RUN

- 任务：按用户确认范围修订 Phase 4 烟测草案。
- 当前阶段：Phase 4。
- 当前状态：已执行 Phase 4 烟测草案修订，等待修订后质量复核。
- 修订文件：
  - `scripts/SMOKE-DRAFT.md`
  - `scripts/SCRIPT-STATUS.md`
  - `outlines/OUTLINE.md`
  - `RUN-LOG.md`
  - `PROJECT-MEMORY.md`
- 修订重点：
  - 分离 S02 观点层与 S03 证据层。
  - 在 S05 补充“孰为汝多知乎？”白话释义。
  - 降低结尾旁白口号化 / PPT 味。
  - 同步 `VALIDATE-007` 后的真实校验状态。
- 当前仍停留 Phase 4，未进入 Phase 5。
- 未生成正式字幕、正式分镜、视频提示词、Seedance prompts、图像提示词或完整生产稿包。
- 未生成 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md`、`locked/LOCK-MANIFEST.sha256` 或 `locked/SKILL-LOCK-MANIFEST.sha256`。
- 校验记录：
  - `bash scripts/validate-edu-shortdrama-project.sh`：通过，0 error / 0 warning。
  - `bash scripts/validate-shell.sh`：通过，0 error / 0 warning。
  - `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-edu-shortdrama-project.ps1`：通过，0 error / 0 warning。
  - `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-shell.ps1`：通过，0 error / 0 warning。
