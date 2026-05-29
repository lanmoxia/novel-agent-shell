# VALIDATE-003：教辅模板专用校验规则记录

- 任务编号：VALIDATE-003
- 任务名称：新增教辅模板专用校验规则
- 完成日期：2026-05-29
- 当前状态：已完成

## 1. 修改范围

实际新增文件：

- `scripts/validate-edu-shortdrama-template.sh`
- `docs/AI-CONTEXT/archive/VALIDATE-003-EDU-TEMPLATE-VALIDATION.md`

实际修改文件：

- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/LAST-TASK.md`

## 2. 修改目的

本轮新增教辅短剧模板专用校验脚本，用于检查 `projects/_template-edu-shortdrama/` 的模板结构、教辅字段和生产稿包边界。

本轮目的不是把教辅模板当成真实项目，也不是让模板满足旧项目校验的 locked / final-review / RUN-LOG 运行状态。

## 3. 新增脚本说明

新增脚本：

```bash
scripts/validate-edu-shortdrama-template.sh
```

校验目标固定为：

```text
projects/_template-edu-shortdrama/
```

脚本输出格式与现有 validate 脚本保持一致：

```text
[validate-edu-shortdrama-template] [info] ...
[validate-edu-shortdrama-template] [warn] ...
[validate-edu-shortdrama-template] [error] ...
[validate-edu-shortdrama-template] Completed with X error(s), Y warning(s).
```

退出规则：

- 有 error 时退出码非 0。
- 只有 warning 时退出码为 0。
- 0 error / 0 warning 时退出码为 0。

## 4. 校验规则清单

### 目录存在性

检查模板根目录：

- `projects/_template-edu-shortdrama/`

检查必需目录：

- `materials/`
- `specs/`
- `planning/`
- `outlines/`
- `scripts/`
- `reviews/`
- `revisions/`
- `locked/`
- `short-drama-shotlists/`
- `seedance-prompts/`
- `drafts/`

### 文件存在性

检查必需文件：

- `PROJECT.md`
- `PROJECT-STATE.json`
- `GENRE-SKILL-LOCK.md`
- `PROJECT-MEMORY.md`
- `RUN-LOG.md`
- `materials/README.md`
- `specs/STORY-SPEC.md`
- `planning/ENDING-LOCK.md`
- `outlines/OUTLINE.md`
- `scripts/SCRIPT-STATUS.md`
- `reviews/README.md`
- `revisions/README.md`
- `revisions/revision-log.md`
- `locked/README.md`
- `locked/FINAL-SCRIPT.md`
- `short-drama-shotlists/README.md`
- `seedance-prompts/README.md`
- `drafts/README.md`

### `PROJECT-STATE.json`

检查 JSON 合法性。

检查必需字段：

- `projectType`
- `skillId`
- `phase`
- `status`
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

检查字段值 / 类型：

- `projectType == "edu-shortdrama"`
- `skillId == "wenyan-skill"`
- `phase` 是整数
- `status` 存在且非空
- `confirmedArtifacts` 是对象
- `lockedArtifacts` 是数组
- `notes` 是数组

检查 `confirmedArtifacts` 至少包含：

- `projectMd`
- `genreSkillLock`
- `storySpec`
- `endingLock`
- `outline`
- `originalTextAnalysis`
- `sceneMapping`
- `script`
- `subtitlePlan`
- `shotlistPlan`
- `teachingReview`
- `revisionLog`
- `finalScript`
- `productionPackage`

### 关键语义词

检查核心模板文件包含最低关键语义：

- `specs/STORY-SPEC.md`：`原文`、`白话`、`教学目标`
- `outlines/OUTLINE.md`：`Scene` 或 `场景`，并包含 `原文`
- `scripts/SCRIPT-STATUS.md`：`字幕`、`分镜`
- `GENRE-SKILL-LOCK.md`：`capabilities` 或 `declaredCapabilities`
- `locked/FINAL-SCRIPT.md`：`最终剧本` 或 `生产稿包`

## 5. 明确不校验真实项目状态的原因

教辅模板不是由模板实例化出的真实项目，因此不应强制它满足真实项目运行状态。

本脚本明确不要求：

- `project`
- `locked`
- `reviews/final-review.md`
- `RUN-LOG` 真实运行记录
- `PROJECT.md` Phase 7
- `LOCK-MANIFEST.sha256`
- 真实项目锁稿状态

原因：

- `project` 是真实项目实例名，不是模板字段。
- `locked` 是真实项目运行状态，不应强加给模板。
- `final-review.md`、真实运行日志和锁稿 manifest 表达的是执行过程，不是模板结构。
- 教辅模板需要的是结构、字段和生产稿包边界校验，而不是旧项目恢复状态校验。

## 6. 执行过的命令

本轮只运行用户允许的命令：

```bash
bash scripts/validate-edu-shortdrama-template.sh
bash scripts/validate-projects.sh
bash scripts/validate-project-state.sh
```

未运行：

- `scripts/validate-shell.sh`
- `scripts/validate-shell.ps1`

## 7. 命令结果

| 命令 | 结果 |
| ---- | ---- |
| `bash scripts/validate-edu-shortdrama-template.sh` | 通过，0 error，0 warning |
| `bash scripts/validate-projects.sh` | 通过，0 error，0 warning |
| `bash scripts/validate-project-state.sh` | 通过，0 error，0 warning |

关键结论：

- 教辅模板专用校验通过。
- 旧项目校验仍通过。
- 旧项目校验继续跳过 `_template-edu-shortdrama`，不会把它当成真实项目。

## 8. 是否修改教辅模板

没有。

本轮没有修改：

- `projects/_template-edu-shortdrama/`
- `projects/_template/`
- `projects/`

本轮没有创建项目，没有生成剧本、分镜、视频提示词，也没有执行创作测试。

## 9. 未覆盖项

本轮尚未覆盖：

- 未将 `validate-edu-shortdrama-template.sh` 接入 `validate-shell.sh`。
- 未将 `validate-edu-shortdrama-template.sh` 接入 `validate-shell.ps1`。
- 未运行顶层 shell 校验。
- 未创建真实教辅短剧项目做端到端验证。
- 未验证后置视频提示词、分镜或生产稿包生成链路。

## 10. 后续任务建议

下一步建议：

`VALIDATE-004`：决定是否把教辅模板专用校验接入顶层 validate-shell。

建议 `VALIDATE-004` 先评估：

- 是否将 `scripts/validate-edu-shortdrama-template.sh` 纳入 `scripts/validate-shell.sh`。
- 是否为 PowerShell 顶层校验提供等价入口，或只在 Bash 顶层校验中接入。
- 顶层校验接入后是否仍避免 `.claude/` 相关噪声影响当前验证判断。

本轮结论：

- 本轮新增的是教辅模板专用校验脚本。
- 本轮没有修改教辅模板。
- 本轮没有创建项目。
- 本轮没有生成创作内容。
- 旧项目校验与教辅模板校验职责已经分离。
- 下一步建议为 `VALIDATE-004`：决定是否把教辅模板专用校验接入顶层 validate-shell。
