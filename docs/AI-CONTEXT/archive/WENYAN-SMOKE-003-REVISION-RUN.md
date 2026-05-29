# WENYAN-SMOKE-003-REVISION-RUN：Phase 4 烟测草案修订记录

- 任务编号：WENYAN-SMOKE-003-REVISION-RUN
- 任务名称：按用户确认范围修订 Phase 4 烟测草案
- 完成日期：2026-05-29
- 当前状态：已完成

## 1. 修订依据

本轮依据用户确认范围和以下归档执行：

- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-003-REVISION-PLAN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-002-REVIEW.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-001-RUN.md`
- `docs/AI-CONTEXT/archive/VALIDATE-007-EDU-ACTIVE-PROJECT-COMPAT-FIX.md`

目标是只处理 Phase 4 烟测草案质量问题，不进入 Phase 5。

## 2. 修改文件列表

本轮修改：

- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/LAST-TASK.md`

本轮新增：

- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-003-REVISION-RUN.md`

## 3. 未修改文件列表

本轮未修改：

- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-STATE.json`
- `projects/wenyan-smoke-liangxiaor-bianri-001/GENRE-SKILL-LOCK.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/specs/STORY-SPEC.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/planning/ENDING-LOCK.md`
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

## 4. P1 修订结果

### P1-1：观点层与证据层分离

已修订 `SMOKE-DRAFT.md`：

- S02 只呈现两个观点：
  - 小儿甲：日出近，日中远。
  - 小儿乙：日出远，日中近。
- S03 专门呈现两个证据：
  - 小儿甲：日初出大如车盖，日中如盘盂。
  - 小儿乙：日初出沧沧凉凉，日中如探汤。

`OUTLINE.md` 已轻量同步为 S02 观点层、S03 证据层。

### P1-2：补白话释义

已在 S05 补充：

```text
孰为汝多知乎？白话：谁说你很有智慧呢？
```

并明确 S05 语气不处理成嘲讽羞辱。

### P1-3：降低口号化 / PPT 味

已将结尾旁白从直白口号调整为更贴近情境的表达：

```text
原来，能提出问题，也要承认自己还有不懂之处。
```

该表达仍服务“敢于质疑 / 学无止境 / 观察角度不同”。

### P1-4：同步 RUN-LOG 状态

已在 `RUN-LOG.md` 追加：

- `VALIDATE-007` 已完成。
- Bash / PowerShell 顶层校验已通过。
- `WENYAN-SMOKE-002-REVIEW` 已完成。
- `WENYAN-SMOKE-003-REVISION-PLAN` 已完成。
- 本轮执行 `WENYAN-SMOKE-003-REVISION-RUN`。
- 当前仍停留 Phase 4，未进入 Phase 5。

同时说明旧校验失败已由 `VALIDATE-007` 的 `projectType` 分流和教辅项目实例专用校验解决。

## 5. P2 处理结果

- 教材版本、目标年级和 60 秒时长：仍作为后续确认项保留，未在本轮强行收敛。
- S03 信息密度：已降低为两个短证据句，不生成正式字幕表。
- 题目钩子：S01 已轻量加入“太阳早晨近，还是中午近？”作为问题钩子，不脱离原文。

## 6. 是否进入 Phase 5

否。

项目仍保持 Phase 4。本轮只修订 Phase 4 烟测草案，不生成 Phase 5 审查产物。

## 7. 是否生成正式产物

否。

本轮未生成：

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

## 8. 是否修改模板 / Skill / workflow / scripts

否。

本轮未修改：

- `genre-skills/`
- `projects/_template/`
- `projects/_template-edu-shortdrama/`
- `workflow/`
- 仓库级 `scripts/`

## 9. 是否补旧小说规划文件

否。

本轮未生成：

- `planning/REVERSE-OUTLINE.md`
- `planning/FORESHADOW-LEDGER.md`
- `planning/REVEAL-SCHEDULE.md`

烟测项目不需要补旧小说 / 剧本规划文件。

## 10. 是否运行校验

是。

本轮运行：

```bash
bash scripts/validate-edu-shortdrama-project.sh
bash scripts/validate-shell.sh
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-edu-shortdrama-project.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-shell.ps1
```

## 11. 校验结果

全部通过：

- `bash scripts/validate-edu-shortdrama-project.sh`：0 error / 0 warning。
- `bash scripts/validate-shell.sh`：0 error / 0 warning。
- `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-edu-shortdrama-project.ps1`：0 error / 0 warning。
- `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-shell.ps1`：0 error / 0 warning。

## 12. 后续建议

下一步只推荐：

```text
WENYAN-SMOKE-004-REVIEW：复核修订后的 Phase 4 烟测草案质量
```

该任务应只做质量复核，不应自动进入 Phase 5，也不应生成正式审查、锁稿、字幕、分镜、视频提示词或生产稿包。

