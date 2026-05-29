# VALIDATE-007-EDU-ACTIVE-PROJECT-COMPAT-FIX：真实教辅项目实例 active project 校验分流修复

- 任务编号：VALIDATE-007-EDU-ACTIVE-PROJECT-COMPAT-FIX
- 任务名称：为真实教辅项目实例增加 active project 校验分流与专用校验
- 完成日期：2026-05-29
- 当前状态：已完成

## 1. 修改范围

本轮新增：

- `scripts/validate-edu-shortdrama-project.sh`
- `scripts/validate-edu-shortdrama-project.ps1`
- `docs/AI-CONTEXT/archive/VALIDATE-007-EDU-ACTIVE-PROJECT-COMPAT-FIX.md`

本轮修改：

- `scripts/validate-projects.sh`
- `scripts/validate-project-state.sh`
- `scripts/validate-project-state.ps1`
- `scripts/validate-shell.sh`
- `scripts/validate-shell.ps1`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/LAST-TASK.md`

## 2. 修改目的

实现 `VALIDATE-006` 推荐方案 D：

```text
旧项目校验按 projectType 分流 + 新增教辅项目实例专用校验。
```

目标是让旧小说 / 剧本项目继续走旧校验，同时让 `projectType: edu-shortdrama` 的真实教辅项目实例不再被旧小说 / 剧本规则误检，并进入教辅真实项目实例专用校验。

## 3. `projectType` 分流规则

分流依据是项目目录下的 `PROJECT-STATE.json`：

- `projectType: edu-shortdrama`：跳过旧 active project 结构校验和旧 recovery Phase gate，交给 `validate-edu-shortdrama-project.*`。
- 其他项目类型或未声明 `projectType` 的旧项目：继续走原有旧小说 / 剧本校验。
- `_template`、`_template-edu-shortdrama`、`test-*`、`*-smoke-test` 仍按既有规则跳过 active project 校验。

## 4. 旧项目校验变化

`scripts/validate-projects.sh` 已新增 `projectType` 判断：

- 如果项目 `PROJECT-STATE.json` 中 `projectType == "edu-shortdrama"`，输出 info 并跳过旧结构校验。
- 因此教辅项目不再触发旧规则要求：
  - `planning/REVERSE-OUTLINE.md`
  - `planning/FORESHADOW-LEDGER.md`
  - `planning/REVEAL-SCHEDULE.md`

`scripts/validate-project-state.sh` 与 `scripts/validate-project-state.ps1` 已新增同等判断：

- 如果 `projectType == "edu-shortdrama"`，输出 info 并跳过旧 recovery validation。
- 因此教辅项目不再触发：
  - `confirmedArtifacts.reverseOutline == true`
  - `planning/REVERSE-OUTLINE.md`

普通旧项目仍保持原校验逻辑。

## 5. 教辅项目实例专用校验规则

新增 `scripts/validate-edu-shortdrama-project.sh` 与 `scripts/validate-edu-shortdrama-project.ps1`，专门扫描 `projects/` 下真实 `projectType: edu-shortdrama` 项目实例，不校验模板。

当前覆盖规则包括：

- 必需文件：
  - `PROJECT.md`
  - `PROJECT-STATE.json`
  - `GENRE-SKILL-LOCK.md`
  - `specs/STORY-SPEC.md`
  - `planning/ENDING-LOCK.md`
  - `outlines/OUTLINE.md`
  - `scripts/SCRIPT-STATUS.md`
  - `RUN-LOG.md`
  - `PROJECT-MEMORY.md`
- `PROJECT-STATE.json` 必需字段：
  - `project`
  - `projectType`
  - `skillId`
  - `phase`
  - `status`
  - `locked`
  - `confirmedArtifacts`
  - `eduTextStatus`
  - `sceneMappingStatus`
  - `scriptStatus`
  - `subtitleStatus`
  - `shotlistStatus`
  - `reviewStatus`
  - `productionPackageStatus`
  - `lockedArtifacts`
  - `lastUpdated`
  - `notes`
- 字段要求：
  - `projectType == "edu-shortdrama"`
  - `skillId == "wenyan-skill"`
  - `phase` 是 0-8 整数
  - `confirmedArtifacts` 是对象
  - `lockedArtifacts` 是数组
  - `notes` 是数组
- Phase gate：
  - Phase >= 0：`PROJECT.md` 存在，`confirmedArtifacts.projectMd == true`
  - Phase >= 1：`GENRE-SKILL-LOCK.md` 存在，`confirmedArtifacts.genreSkillLock == true`
  - Phase >= 2：`STORY-SPEC.md`、`ENDING-LOCK.md` 存在，`storySpec`、`endingLock`、`originalTextAnalysis` 为 true
  - Phase >= 3：`OUTLINE.md` 存在，`outline`、`sceneMapping` 为 true
  - Phase >= 4：`SCRIPT-STATUS.md` 存在，`script == true`，并存在 `scripts/SMOKE-DRAFT.md` 或其他短剧草案文件
- 禁止产物检查：
  - Phase < 5 不应存在 `reviews/final-review.md`
  - Phase < 7 不应存在 `locked/FINAL-SCRIPT.md`、`locked/LOCK-MANIFEST.sha256`、`locked/SKILL-LOCK-MANIFEST.sha256`
  - Phase < 8 不应在 `short-drama-shotlists/` 或 `seedance-prompts/` 下存在非 README 正式产物
- 语义关键词检查：
  - `STORY-SPEC.md` 包含原文、白话、教学目标、不可改写事实
  - `OUTLINE.md` 包含 Scene、原文、字幕、视频生成风险或视频风险
  - `SCRIPT-STATUS.md` 包含 Phase 4、烟测草案、不是最终生产稿或不代表正式生产稿
  - `SMOKE-DRAFT.md` 包含烟测草案、不是最终生产稿

新校验明确不要求旧小说 / 剧本规划文件、final review、锁稿 manifest 或 final script。

## 6. Bash 实现说明

Bash 侧变更：

- `validate-projects.sh` 使用 `PROJECT-STATE.json` 中的 `projectType` 判断是否跳过旧 active project 校验。
- `validate-project-state.sh` 在读取基础状态后先判断 `projectType`，对 `edu-shortdrama` 输出 info 并返回。
- `validate-edu-shortdrama-project.sh` 使用 Python 解析 JSON，避免用脆弱 grep 解析嵌套对象和数组。
- `validate-shell.sh` 增加新脚本语法检查，并在旧 active project / state 校验后调用教辅真实项目实例校验。

## 7. PowerShell 实现说明

PowerShell 侧变更：

- `validate-project-state.ps1` 在解析 `PROJECT-STATE.json` 后先判断 `projectType`，对 `edu-shortdrama` 输出 info 并跳过旧 recovery validation。
- `validate-shell.ps1` 的内联 active project 结构校验也按 `projectType` 跳过 `edu-shortdrama` 项目。
- `validate-edu-shortdrama-project.ps1` 不依赖 Bash，使用 `ConvertFrom-Json` 校验字段、类型、Phase gate、禁止产物和语义关键词。
- PowerShell 中文关键词使用 codepoint 构造，避免 Windows PowerShell 源码解码差异导致误判。

## 8. 顶层 validate-shell 调用链变化

Bash 顶层调用链现在包括：

1. repository / workflow 基础检查
2. 教辅模板专用校验
3. legacy active project validation
4. legacy project state validation
5. edu shortdrama real project validation
6. genre skill validation

PowerShell 顶层调用链现在包括：

1. repository / workflow 基础检查
2. 教辅模板专用校验
3. PowerShell 内联 legacy active project validation，并跳过 `edu-shortdrama`
4. legacy project state validation，并跳过 `edu-shortdrama`
5. edu shortdrama real project validation
6. genre skill validation

未新增或修改 `.claude/` 探测逻辑。

## 9. 执行过的命令

本轮执行过：

```bash
bash scripts/validate-projects.sh
bash scripts/validate-project-state.sh
bash scripts/validate-edu-shortdrama-project.sh
bash scripts/validate-shell.sh
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-project-state.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-edu-shortdrama-project.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-shell.ps1
```

## 10. 命令结果

最终结果：

- `bash scripts/validate-projects.sh`：通过，0 error / 0 warning。
- `bash scripts/validate-project-state.sh`：通过，0 error / 0 warning。
- `bash scripts/validate-edu-shortdrama-project.sh`：通过，0 error / 0 warning。
- `bash scripts/validate-shell.sh`：通过，0 error / 0 warning。
- `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-project-state.ps1`：通过，0 error / 0 warning。
- `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-edu-shortdrama-project.ps1`：通过，0 error / 0 warning。
- `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-shell.ps1`：通过，0 error / 0 warning。

实现过程中，PowerShell 教辅项目实例校验曾因新脚本内中文关键词解码和空数组类型判断失败；已仅在新脚本内修正，未修改烟测项目内容。

## 11. 是否修改烟测项目

否。

本轮未修改：

```text
projects/wenyan-smoke-liangxiaor-bianri-001/
```

## 12. 是否补旧规划文件

否。

以下文件仍未补、也不需要补：

- `planning/REVERSE-OUTLINE.md`
- `planning/FORESHADOW-LEDGER.md`
- `planning/REVEAL-SCHEDULE.md`
- `reviews/final-review.md`
- `locked/SKILL-LOCK-MANIFEST.sha256`
- `locked/FINAL-SCRIPT.md`

## 13. 是否修改模板 / Skill / workflow

否。

本轮未修改：

- `projects/_template/`
- `projects/_template-edu-shortdrama/`
- `genre-skills/`
- `workflow/`
- `docs/GENRE-SKILL-CONTRACT.md`

## 14. 是否新增 `.claude/` 探测逻辑

否。

顶层 `validate-shell.*` 保留既有 `.claude/` warning 行为，本轮未新增、未扩大该探测逻辑。

## 15. 结论

旧小说 / 剧本项目继续走旧校验。

`projectType: edu-shortdrama` 项目走教辅真实项目实例专用校验。

烟测项目不需要补旧小说规划文件。

Bash / PowerShell 顶层校验均已通过 0 error / 0 warning。

## 16. 后续建议

下一步只推荐：

```text
WENYAN-SMOKE-002-REVIEW：审查烟测项目输出质量与是否符合 wenyan-skill
```

该任务应审查现有烟测输出质量，不应自动进入 Phase 5 / 6 / 7 / 8，也不应生成正式字幕、正式分镜、视频提示词或生产稿包，除非用户另行确认。
