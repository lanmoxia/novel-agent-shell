# VALIDATE-006-EDU-ACTIVE-PROJECT-COMPAT-AUDIT：真实教辅项目实例与 active project 校验兼容审计

- 任务编号：VALIDATE-006-EDU-ACTIVE-PROJECT-COMPAT-AUDIT-RECOVERY
- 原任务编号：VALIDATE-006-EDU-ACTIVE-PROJECT-COMPAT-AUDIT
- 任务名称：恢复真实教辅项目实例与 active project 校验兼容审计
- 完成日期：2026-05-29
- 当前状态：已完成只读审计

## 1. 审计范围

本轮是 recovery：上一轮 `VALIDATE-006-EDU-ACTIVE-PROJECT-COMPAT-AUDIT` 已读取上下文、烟测项目和校验脚本，但在归档与状态更新前因 compact / stream disconnected 中断。

本轮只完成审计归档和 AI-CONTEXT 状态更新，不修复脚本，不修改烟测项目，不为通过旧校验补占位文件。

审计目标是判断真实 `projectType: edu-shortdrama` 项目进入 active project 校验后，为什么触发旧小说 / 剧本项目规则，以及后续应如何分流。

## 2. 读取文件列表

本轮按任务限定读取：

- `docs/AI-CONTEXT/README.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-001-PLAN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-001-RUN.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-STATE.json`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `scripts/validate-projects.sh`
- `scripts/validate-project-state.sh`
- `scripts/validate-project-state.ps1`
- `scripts/validate-shell.sh`
- `scripts/validate-shell.ps1`

未读取 Codex 全局 memory、`.claude/`、`workflow/settings*.json`、`genre-skills/`、`projects/_template/`、`projects/_template-edu-shortdrama/`、`workflow/` 或 `docs/GENRE-SKILL-CONTRACT.md`。

## 3. 当前失败命令与失败摘要

失败命令来自 `WENYAN-SMOKE-001-RUN` 归档和烟测项目 `RUN-LOG.md`：

```bash
bash scripts/validate-shell.sh
```

失败摘要：

- `wenyan-smoke-liangxiaor-bianri-001: missing planning/REVERSE-OUTLINE.md`
- `wenyan-smoke-liangxiaor-bianri-001: missing planning/FORESHADOW-LEDGER.md`
- `wenyan-smoke-liangxiaor-bianri-001: missing planning/REVEAL-SCHEDULE.md`
- `wenyan-smoke-liangxiaor-bianri-001: phase 4 requires confirmedArtifacts.reverseOutline to be true.`

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-shell.ps1
```

失败摘要：

- `wenyan-smoke-liangxiaor-bianri-001 missing planning\REVERSE-OUTLINE.md`
- `wenyan-smoke-liangxiaor-bianri-001 missing planning\FORESHADOW-LEDGER.md`
- `wenyan-smoke-liangxiaor-bianri-001 missing planning\REVEAL-SCHEDULE.md`
- `phase 4 requires confirmedArtifacts.reverseOutline to be true`
- `Project state recovery validation failed`

这些失败不来自教辅模板专用校验，而是来自真实项目实例进入 active project 校验后被旧规则检查。

## 4. `validate-projects.sh` 失败点分析

`validate-projects.sh` 的 active project 识别规则只跳过：

- `_template`
- `_template-edu-shortdrama`
- `test-*`
- `*-smoke-test`

烟测项目目录名是：

```text
projects/wenyan-smoke-liangxiaor-bianri-001
```

它不是模板目录，也不匹配 `*-smoke-test`，因此被视为真实 active project。

进入 active project 分支后，脚本无条件检查旧小说 / 剧本项目结构，其中包括：

```text
planning/ENDING-LOCK.md
planning/REVERSE-OUTLINE.md
planning/FORESHADOW-LEDGER.md
planning/REVEAL-SCHEDULE.md
```

`ENDING-LOCK.md` 在教辅短剧里可以表达学习闭环和原文结论边界；但 `REVERSE-OUTLINE.md`、`FORESHADOW-LEDGER.md`、`REVEAL-SCHEDULE.md` 是旧小说 / 剧本流程中的反推大纲、伏笔账本和揭示排期语义，不是 Phase 0-4 教辅短剧烟测的必要产物。

脚本没有读取 `PROJECT-STATE.json` 中的 `projectType` 后分支，也没有识别 `skillId: wenyan-skill`，所以无法区分旧小说 / 剧本项目与教辅短剧项目。

## 5. `validate-project-state.sh` / `.ps1` 失败点分析

`validate-project-state.sh` 和 `validate-project-state.ps1` 都读取 `PROJECT-STATE.json`，但当前校验逻辑没有按 `projectType` 分流。

Bash 版本中：

- `require_confirmed_file` 将 `reverseOutline` 映射到 `planning/REVERSE-OUTLINE.md`。
- Phase >= 4 时无条件要求：
  - `confirmedArtifacts.outline == true`
  - `confirmedArtifacts.reverseOutline == true`

PowerShell 版本中：

- `$ArtifactMap` 将 `reverseOutline` 映射到 `planning\REVERSE-OUTLINE.md`。
- Phase >= 4 时无条件调用：
  - `Require-Gate ... -Key "outline"`
  - `Require-Gate ... -Key "reverseOutline"`

因此，只要教辅项目处于 Phase 4 且 `confirmedArtifacts.reverseOutline` 为 false，就会失败，即使该项目已经有教辅语义下的原文拆解、教学目标、Scene 映射和烟测草案。

## 6. 烟测项目 `PROJECT-STATE.json` 分析

烟测项目状态文件包含足够的分流信号：

```json
{
  "project": "wenyan-smoke-liangxiaor-bianri-001",
  "projectType": "edu-shortdrama",
  "skillId": "wenyan-skill",
  "phase": 4,
  "status": "phase4_smoke_draft_created",
  "locked": false
}
```

其中：

- `projectType: edu-shortdrama` 是项目类型分流的直接依据。
- `skillId: wenyan-skill` 可作为教辅文言文 Skill 绑定的补充依据。
- `phase: 4` 表示已到短剧脚本草案阶段，但不是旧小说流程中的正文完成 / 反推大纲确认。
- `confirmedArtifacts.reverseOutline: false` 是合理状态，因为本烟测不应生成旧小说反推大纲。
- `confirmedArtifacts.originalTextAnalysis: true`、`sceneMapping: true`、`script: true` 更符合教辅短剧 Phase 2-4 的真实产物语义。

结论：`projectType` 已足够作为第一分流依据；`skillId` 可作为附加一致性检查，但不应替代 `projectType`。

## 7. 旧小说 / 剧本规则与教辅短剧规则差异

旧小说 / 剧本 active project 规则关注：

- 反推大纲
- 伏笔账本
- 揭示排期
- 正文 / 章节稿
- final review
- revision log
- final script
- lock manifest

教辅短剧 Phase 0-4 关注：

- 项目建档
- 教辅 Skill lock
- 原文拆解
- 白话释义
- 教学目标
- 不可改写事实
- Scene 与原文 / 教学点映射
- 字幕要点边界
- 视频风险提示
- 极短烟测草案

两者都可以共用 shell 的项目状态、运行日志、Skill lock 和阶段门禁思想，但具体 artifact 不应混用。

## 8. A / B / C / D 方案对比

### A：给烟测项目补旧小说规划文件

做法：

- 补 `planning/REVERSE-OUTLINE.md`
- 补 `planning/FORESHADOW-LEDGER.md`
- 补 `planning/REVEAL-SCHEDULE.md`
- 将 `confirmedArtifacts.reverseOutline` 改为 true

判断：不推荐。

原因：

- 会把教辅短剧项目伪装成旧小说 / 剧本项目。
- 会污染 `PROJECT-STATE.json` 的语义，让状态不再反映真实产物。
- 会鼓励用占位文件通过 gate，违背烟测边界。
- 会掩盖 active project 校验没有分流的真实问题。

### B：让旧 active project 校验跳过 `projectType: edu-shortdrama`

做法：

- 旧 active project 校验读取 `PROJECT-STATE.json`。
- 如果 `projectType` 是 `edu-shortdrama`，则跳过旧小说 / 剧本规则。

判断：可短期止血，但不完整。

优点：

- 能立刻避免旧规则误报。
- 不需要修改烟测项目内容。

风险：

- 如果没有教辅真实项目实例校验，真实教辅项目会漏检。
- 只能证明不套旧规则，不能证明教辅项目结构和状态正确。

### C：为 `projectType: edu-shortdrama` 新增专用真实项目校验

做法：

- 新增 `scripts/validate-edu-shortdrama-project.sh`
- 新增 `scripts/validate-edu-shortdrama-project.ps1`
- 校验真实教辅项目实例的结构、状态字段、Phase 0-4 artifact、禁止产物和 Phase 边界。

判断：推荐方向之一。

优点：

- 能把教辅项目的真实语义落到校验层。
- 能检查烟测项目是否误生成正式字幕、分镜、视频提示词或生产稿包。

风险：

- 如果旧 active project 校验不分流，新增脚本仍无法阻止旧规则误报。

### D：旧项目校验分流 + 教辅项目实例专用校验

做法：

- 旧项目校验按 `projectType` 分流。
- `novel` / `script` 或缺省旧项目继续走现有旧规则。
- `edu-shortdrama` 项目跳过旧小说 / 剧本 artifact 要求。
- 新增教辅真实项目实例专用校验，检查教辅项目自己的结构、状态和禁止产物。
- 顶层 `validate-shell.*` 同时调用旧项目校验、教辅模板校验、教辅真实项目校验。

判断：优先推荐。

原因：

- 保留旧项目校验能力。
- 避免教辅项目被旧语义污染。
- 不让真实教辅项目漏检。
- 与现有 `projectType: edu-shortdrama` 状态字段自然衔接。

## 9. 推荐方案

优先推荐 D：

```text
旧项目校验按 projectType 分流 + 新增教辅项目实例专用校验。
```

建议分流原则：

- `projectType` 缺失或为旧小说 / 剧本项目：继续走现有旧 active project 规则。
- `projectType: edu-shortdrama`：不再要求旧规划文件和 `confirmedArtifacts.reverseOutline == true`。
- `skillId: wenyan-skill`：作为教辅文言文 Skill 绑定校验的一部分。

建议新增脚本：

```text
scripts/validate-edu-shortdrama-project.sh
scripts/validate-edu-shortdrama-project.ps1
```

建议顶层 `validate-shell.*` 后续调用顺序：

1. 旧 shell / workflow / legacy template 基础校验。
2. 教辅模板专用校验：`validate-edu-shortdrama-template.*`。
3. 旧 active project 校验：只检查非 `edu-shortdrama` 项目。
4. 教辅真实项目实例校验：只检查 `projectType: edu-shortdrama` 项目。
5. 项目状态校验也按 `projectType` 分支，不再用单一 Phase gate 覆盖所有项目类型。

## 10. 为什么不应补旧规划占位文件

不应补 `REVERSE-OUTLINE.md`、`FORESHADOW-LEDGER.md`、`REVEAL-SCHEDULE.md`，原因是：

- 它们不属于本次 Phase 0-4 教辅短剧烟测允许产物。
- 它们对应旧小说 / 剧本叙事工程语义，不等同于原文拆解、教学目标或 Scene 映射。
- 补占位文件会让校验通过但项目语义失真。
- 这会把校验问题转嫁给项目内容，后续更难判断真实状态。

## 11. 为什么不应修改烟测内容迎合旧校验

烟测项目当前状态是合理的：

- 已明确 `projectType: edu-shortdrama`。
- 已明确 `skillId: wenyan-skill`。
- 已推进到 Phase 4。
- 已生成 `SMOKE-DRAFT.md`，并标注为烟测草案。
- 未生成锁稿、final review、正式字幕、正式分镜、视频提示词或生产稿包。

如果修改烟测内容来迎合旧校验，会破坏本次烟测最重要的发现：真实教辅项目实例已经具备自己的 artifact 语义，而现有 active project 校验尚未支持分流。

## 12. 后续任务建议

后续只推荐一个主任务：

```text
VALIDATE-007-EDU-ACTIVE-PROJECT-COMPAT-FIX：为真实教辅项目实例增加 active project 校验分流与专用校验
```

建议修复顺序：

1. 先设计 `projectType` 分流规则，确认旧项目默认仍走旧校验。
2. 调整 Bash / PowerShell active project 校验入口，使 `edu-shortdrama` 不再进入旧 artifact 要求。
3. 新增教辅真实项目实例校验脚本，覆盖 Phase 0-4 必要文件、状态字段和禁止产物。
4. 将新脚本接入 `validate-shell.sh` 与 `validate-shell.ps1`。
5. 重新运行 Bash / PowerShell 顶层校验，并记录结果。

本轮未修改 `scripts/`，未修改烟测项目，未补旧小说 / 剧本规划文件，未运行创作流程。
