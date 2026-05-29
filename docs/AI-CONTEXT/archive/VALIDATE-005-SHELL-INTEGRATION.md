# VALIDATE-005：顶层 validate-shell 接入记录

- 任务编号：VALIDATE-005
- 任务名称：将教辅模板专用校验接入顶层 validate-shell
- 完成日期：2026-05-29
- 当前状态：已完成

## 1. 修改范围

新增文件：

- `scripts/validate-edu-shortdrama-template.ps1`
- `docs/AI-CONTEXT/archive/VALIDATE-005-SHELL-INTEGRATION.md`

修改文件：

- `scripts/validate-shell.sh`
- `scripts/validate-shell.ps1`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/LAST-TASK.md`

## 2. 修改目的

本轮将教辅短剧模板专用校验接入顶层 `validate-shell` 调用链，使顶层 Bash 和 PowerShell 校验都能覆盖 `projects/_template-edu-shortdrama/` 的模板结构、教辅字段和生产稿包边界。

本轮目的不是修改教辅模板，也不是把教辅模板重新纳入真实项目校验。

## 3. Bash 顶层接入方式

`scripts/validate-shell.sh` 新增独立接入点：

```bash
echo "[validate-shell] Checking edu shortdrama project template..."
bash "$ROOT_DIR/scripts/validate-edu-shortdrama-template.sh" || ERRORS=$((ERRORS + 1))
```

接入位置在旧 `projects/_template/` 模板检查之后、active projects 检查之前。

该步骤调用现有 Bash 专用校验脚本，不改变 `validate-projects.sh` 或 `validate-project-state.sh` 对真实项目的职责。

## 4. PowerShell 顶层接入方式

`scripts/validate-shell.ps1` 新增独立接入点：

```powershell
Write-Output "[validate-shell] Checking edu shortdrama project template..."
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $RootDir "scripts\validate-edu-shortdrama-template.ps1")
if ($LASTEXITCODE -ne 0) {
    Add-ErrorMessage "Edu shortdrama template validation failed."
}
```

接入位置同样在旧 `projects/_template/` 模板检查之后、active projects 检查之前。

## 5. 是否新增 PowerShell 等价脚本

已新增：

```text
scripts/validate-edu-shortdrama-template.ps1
```

该脚本与 Bash 版校验范围保持一致：

- 检查 `projects/_template-edu-shortdrama/` 模板根目录。
- 检查必需目录和文件。
- 检查 `PROJECT-STATE.json` 合法性、必需字段、字段类型和关键值。
- 检查核心模板文件中的最低语义关键词。
- 明确不检查真实项目 locked / final-review / RUN-LOG 运行记录、Phase 7 或 lock manifest。

## 6. 执行过的验证命令

```bash
bash scripts/validate-edu-shortdrama-template.sh
bash scripts/validate-projects.sh
bash scripts/validate-project-state.sh
bash scripts/validate-shell.sh
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-edu-shortdrama-template.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-project-state.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-shell.ps1
```

## 7. 命令结果

| 命令 | 结果 |
| ---- | ---- |
| `bash scripts/validate-edu-shortdrama-template.sh` | 通过，0 error，0 warning |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-edu-shortdrama-template.ps1` | 通过，0 error，0 warning |
| `bash scripts/validate-projects.sh` | 通过，0 error，0 warning |
| `bash scripts/validate-project-state.sh` | 通过，0 error，0 warning |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-project-state.ps1` | 通过，0 error，0 warning |
| `bash scripts/validate-shell.sh` | 通过，0 error，0 warning |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-shell.ps1` | 通过，0 error，0 warning |

关键输出确认：

- Bash 顶层输出 `Checking edu shortdrama project template...`，并成功调用 `validate-edu-shortdrama-template.sh`。
- PowerShell 顶层输出 `Checking edu shortdrama project template...`，并成功调用 `validate-edu-shortdrama-template.ps1`。
- `validate-projects.sh` 仍输出 `_template-edu-shortdrama: template directory skipped from active project validation.`。

## 8. `.claude/` 探测边界说明

本轮没有新增 `.claude/` 探测逻辑。

本轮没有读取或修改 `.claude/`，也没有修改 `workflow/settings*.json`。

`validate-shell.sh` 与 `validate-shell.ps1` 中既有 `.claude/` warning 逻辑保持原样；本轮只新增教辅模板专用校验接入点。

## 9. 对旧项目校验的影响

旧项目校验职责保持不变：

- `projects/_template/` 继续由既有顶层模板检查覆盖。
- `validate-projects.sh` 继续负责 active project 结构校验。
- `validate-project-state.sh` / `validate-project-state.ps1` 继续负责真实项目状态恢复校验。
- `test-*`、`*-smoke-test` 继续作为样例 / 测试项目跳过。

本轮未修改 active project 校验规则。

## 10. 对 `_template-edu-shortdrama` 的影响

`_template-edu-shortdrama` 现在由专用模板校验覆盖，但仍不进入真实项目校验链。

本轮没有修改：

- `projects/_template-edu-shortdrama/`
- `projects/_template/`
- 任何真实项目目录

## 11. 未修改范围

本轮未修改：

- `projects/`
- `projects/_template/`
- `projects/_template-edu-shortdrama/`
- `genre-skills/`
- `workflow/`
- `docs/GENRE-SKILL-CONTRACT.md`
- `AGENTS.md`
- `README.md`
- `docs/README.md`
- `.claude/`
- `workflow/settings*.json`

本轮没有创建项目，没有生成剧本、分镜、视频提示词或创作内容。

## 12. 后续任务建议

下一步建议执行：

`WENYAN-SMOKE-001`：进行实际文言文教辅短剧烟测。

建议该任务单独开启，并在执行前明确：

- 是否创建真实烟测项目。
- 使用哪个文言文样本。
- 是否只验证建档 / 状态 / 模板链路，还是进一步验证脚本、字幕、分镜和生产稿包。
- 烟测项目完成后是否保留或清理。
