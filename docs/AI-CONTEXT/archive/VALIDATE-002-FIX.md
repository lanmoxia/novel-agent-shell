# VALIDATE-002-FIX：模板目录识别修复记录

- 任务编号：VALIDATE-002-FIX
- 任务名称：调整验证脚本识别模板目录，并为教辅模板校验留出专用规则
- 完成日期：2026-05-29
- 当前状态：已完成

## 1. 修改范围

本轮只修改旧项目校验对模板目录的识别逻辑，以及必要的 AI-CONTEXT 状态文件。

实际修改范围：

- `scripts/validate-projects.sh`
- `scripts/validate-project-state.sh`
- `scripts/validate-project-state.ps1`
- `scripts/validate-shell.ps1`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/LAST-TASK.md`

实际新增文件：

- `docs/AI-CONTEXT/archive/VALIDATE-002-FIX.md`

## 2. 修改目的

本轮目的不是验证教辅模板自身结构，而是修复旧项目校验的目录识别边界：

- 让真实项目校验跳过 `projects/_template-edu-shortdrama/`。
- 保留旧模板目录 `projects/_template/` 的跳过逻辑。
- 保持 `test-*`、`*-smoke-test` 样例 / 测试目录跳过逻辑不变。
- 避免通过修改教辅模板内容来迎合旧项目校验。
- 为后续教辅模板专用校验规则保留边界。

## 3. 修改的脚本列表

- `scripts/validate-projects.sh`
- `scripts/validate-project-state.sh`
- `scripts/validate-project-state.ps1`
- `scripts/validate-shell.ps1`

未修改：

- `scripts/validate-shell.sh`

原因：`validate-shell.sh` 主要委托 `validate-projects.sh` 和 `validate-project-state.sh` 执行项目校验；本轮修复已覆盖它的委托路径，且本轮不运行顶层 shell 校验。

## 4. 模板目录识别规则

本轮将以下目录明确识别为模板目录：

- `_template`
- `_template-edu-shortdrama`

模板目录不进入真实项目校验。

样例 / 测试目录规则保持不变：

- `test-*`
- `*-smoke-test`

这些目录仍不作为生产项目模板或真实项目进行校验。

## 5. Bash 修复摘要

### `scripts/validate-projects.sh`

新增统一模板目录判断函数：

- `_template`
- `_template-edu-shortdrama`

遍历 `projects/*/` 时，如果目录名属于模板目录，则输出 info 并跳过真实项目校验：

```text
[validate-projects] [info] _template-edu-shortdrama: template directory skipped from active project validation.
```

原有 `test-*`、`*-smoke-test` 跳过逻辑保持不变。

### `scripts/validate-project-state.sh`

新增统一模板目录判断函数：

- `_template`
- `_template-edu-shortdrama`

无指定项目遍历时，模板目录会被跳过。

指定项目模式下，如果用户指定 `_template` 或 `_template-edu-shortdrama`，脚本会拒绝将其作为真实项目校验对象，并输出模板目录拒绝信息。

原有 `test-*`、`*-smoke-test`、隐藏目录和路径分隔符拒绝逻辑保持不变。

## 6. PowerShell 修复摘要

### `scripts/validate-project-state.ps1`

新增模板目录判断函数：

```powershell
function Test-TemplateProjectName {
    param([string]$Name)
    return $Name -eq "_template" -or $Name -eq "_template-edu-shortdrama"
}
```

无指定项目遍历时，模板目录会被跳过。

指定项目模式下，`_template` 和 `_template-edu-shortdrama` 会被拒绝作为真实项目校验对象。

原有 `test-*`、`*-smoke-test`、隐藏目录和路径分隔符检查保持不变。

### `scripts/validate-shell.ps1`

只修复了它自身 active projects 遍历中的模板目录判断。

`_template` 和 `_template-edu-shortdrama` 现在都会从 active project validation 中跳过。

未改动 `.claude/` 探测逻辑，未重写脚本。

## 7. 执行过的验证命令

本轮只运行用户允许的验证命令：

```powershell
bash scripts/validate-projects.sh
bash scripts/validate-project-state.sh
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-project-state.ps1
```

未运行：

- `scripts/validate-shell.sh`
- `scripts/validate-shell.ps1`

原因：顶层 shell 校验涉及 `.claude/` 探测，本轮明确不运行。

## 8. 命令结果

| 命令 | 结果 |
| ---- | ---- |
| `bash scripts/validate-projects.sh` | 通过，0 error，0 warning |
| `bash scripts/validate-project-state.sh` | 通过，0 error，0 warning |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-project-state.ps1` | 通过，0 error，0 warning |

关键输出：

- `validate-projects.sh` 已输出 `_template-edu-shortdrama: template directory skipped from active project validation.`
- Bash project state 校验只检查真实项目 `huanghe-minsu-horror-001`，未再检查 `_template-edu-shortdrama`。
- PowerShell project state 校验只检查真实项目 `huanghe-minsu-horror-001`，未再检查 `_template-edu-shortdrama`。

## 9. 未修改范围

本轮没有修改：

- `projects/`
- `projects/_template/`
- `projects/_template-edu-shortdrama/`
- `genre-skills/`
- `workflow/`
- `docs/GENRE-SKILL-CONTRACT.md`
- `AGENTS.md`
- `README.md`
- `docs/README.md`
- `scripts/validate-shell.sh`

本轮没有创建项目，没有生成剧本、分镜、视频提示词，也没有执行创作测试。

## 10. 对 `_template-edu-shortdrama` 的影响

`projects/_template-edu-shortdrama/` 本身未被修改。

本轮只让真实项目校验跳过教辅模板目录，避免旧项目校验继续把它当成真实项目检查。

这意味着：

- 教辅模板不再需要伪造 `project` 字段来模拟真实项目。
- 教辅模板不再需要伪造 `locked` 状态来满足旧项目恢复校验。
- 教辅模板不再需要通过 `final-review`、`RUN-LOG`、`SCRIPT-STATUS` 等真实项目过程状态来迎合旧脚本。
- 教辅模板专用校验仍未建立。

## 11. 后续任务建议

下一步建议新增并执行：

`VALIDATE-003`：新增教辅模板专用校验规则。

建议 `VALIDATE-003` 检查：

- `projects/_template-edu-shortdrama/` 的模板目录结构。
- `PROJECT-STATE.json` 的教辅模板字段，例如 `projectType`、`skillId`、教辅状态字段和 `lockedArtifacts`。
- 教辅短剧生产稿包边界。
- 模板文件是否表达原文拆解、Scene 映射、字幕、分镜、教学审查和生产稿包等必要结构。

本轮结论：

- 本轮没有修改教辅模板。
- 本轮没有让教辅模板迎合旧项目校验。
- 本轮只让真实项目校验跳过教辅模板目录。
- 教辅模板专用校验仍是后续任务。
- 下一步建议为 `VALIDATE-003`：新增教辅模板专用校验规则。
