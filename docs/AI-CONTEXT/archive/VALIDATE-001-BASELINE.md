# VALIDATE-001：现有校验基线记录

- 任务编号：VALIDATE-001
- 任务名称：运行现有校验并记录结果
- 收尾日期：2026-05-28
- 当前状态：基线记录已完成

## 1. 本轮验证范围

本轮记录的是现有 validate 脚本在当前仓库结构下的基线结果，不是修复任务。

覆盖范围：

- 仓库验证入口识别。
- `scripts/` 下现有验证脚本的基线结果记录。
- `wenyan-skill` 与新 Skill 合约元数据的验证结论。
- `projects/_template-edu-shortdrama/` 在旧项目校验脚本下的表现。
- workflow 文档同步后的基线判断。

未纳入范围：

- 不修复 `scripts/`。
- 不修改 `workflow/`。
- 不修改 `genre-skills/`。
- 不修改 `projects/`、`projects/_template/` 或 `projects/_template-edu-shortdrama/`。
- 不创建项目。
- 不生成剧本、分镜、视频提示词或创作测试内容。

## 2. 已执行命令

以下命令来自上一次 `VALIDATE-001` 已实际执行出的结果；本收尾任务未重新运行 validate 脚本。

| 命令 | 结果 |
| ---- | ---- |
| 检查仓库根目录是否存在 `package.json` | 未发现 `package.json` |
| 检查验证入口位置 | 验证入口主要在 `scripts/` 下 |
| 检查 `validate-shell.sh` / `validate-shell.ps1` 行为 | 会探测 `.claude/`，上轮未执行 |
| `bash scripts/validate-workflow-assets.sh` | 通过，0 error，0 warning |
| `bash scripts/validate-genre-skills.sh` | 通过，0 error，0 warning |
| `bash scripts/validate-project-state.sh` | 失败 |
| `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-project-state.ps1` | 失败或有 warning |
| `bash scripts/validate-projects.sh` | 失败 |

## 3. 命令结果表

| 校验项 | 结果 | 关键结论 |
| ---- | ---- | ---- |
| 仓库包管理入口 | 未发现 | 仓库没有 `package.json`，不是 npm 包式验证入口 |
| 验证脚本入口 | 已确认 | 主要入口位于 `scripts/` |
| shell 总体验证 | 未执行 | `validate-shell.*` 会探测 `.claude/`，本轮按范围限制未执行 |
| workflow assets 校验 | 通过 | `validate-workflow-assets.sh` 返回 0 error / 0 warning |
| genre skills 校验 | 通过 | `validate-genre-skills.sh` 返回 0 error / 0 warning |
| project state 校验 Bash 版 | 未通过 | 旧脚本把 `_template-edu-shortdrama` 当作真实项目检查 |
| project state 校验 PowerShell 版 | 未完全通过 | 失败或出现 warning，原因集中在模板目录被项目化检查 |
| projects 校验 | 未通过 | 旧脚本把 `_template-edu-shortdrama` 当作真实项目检查 |

## 4. 通过项

- `bash scripts/validate-workflow-assets.sh` 已通过，0 error，0 warning。
- `bash scripts/validate-genre-skills.sh` 已通过，0 error，0 warning。
- `wenyan-skill` 的新元数据已能被当前 genre skill 校验基线接受。
- workflow 文档同步本身没有在 workflow assets 校验中暴露错误。

## 5. 失败项

当前验证未完全通过。

失败集中在项目类校验：

- `bash scripts/validate-project-state.sh` 失败。
- `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-project-state.ps1` 失败或有 warning。
- `bash scripts/validate-projects.sh` 失败。

已发现的核心报错 / 警告包括：

- `_template-edu-shortdrama: PROJECT-STATE.json missing project`
- `_template-edu-shortdrama: PROJECT-STATE.json missing locked`
- `_template-edu-shortdrama: PROJECT-STATE.json locked must be true or false`
- `_template-edu-shortdrama: locked/FINAL-SCRIPT.md exists but reviews/final-review.md is missing`
- `_template-edu-shortdrama: locked/FINAL-SCRIPT.md exists but scripts/SCRIPT-STATUS.md does not say 已锁稿`
- `_template-edu-shortdrama: RUN-LOG.md has no 下一步 entry`
- `_template-edu-shortdrama: RUN-LOG.md does not contain a run record section`

## 6. 未覆盖项

- 未执行 `validate-shell.sh` / `validate-shell.ps1`，因为它们会探测 `.claude/`。
- 未重新运行任何 validate 脚本。
- 未创建真实教辅短剧项目进行端到端验证。
- 未执行 Skill 创作测试。
- 未生成剧本、分镜、视频提示词或生产稿包。
- 未验证后置视频生产链路。
- 未验证 `_template-edu-shortdrama` 的专用模板规则，因为当前还没有专用校验脚本或跳过规则。

## 7. 对 wenyan-skill 的验证结论

`wenyan-skill` 在当前基线下通过了 `validate-genre-skills.sh`。

这说明 `SKILL-002` 补充的 `version`、`capabilities`、`fallbackRules` 和 `shellBoundary` 元数据没有破坏现有 genre skill 校验。该结论只表示现有脚本可接受当前 Skill 结构，不表示已经完成教辅短剧生产能力的端到端验证。

## 8. 对 projects/_template-edu-shortdrama/ 的验证结论

`projects/_template-edu-shortdrama/` 是教辅短剧专用模板目录，不是实际生产项目目录。

当前失败不等于教辅模板业务设计失败。主要原因是旧 `validate-projects` / `validate-project-state` 脚本还不知道 `_template-edu-shortdrama` 是模板目录，因此把它当成真实项目检查，进而要求真实项目才应满足的字段、锁稿状态、运行日志和审查产物。

本轮不修改 `_template-edu-shortdrama`，也不通过改模板内容来迎合旧项目校验。

## 9. 对 workflow 文档同步的验证结论

`bash scripts/validate-workflow-assets.sh` 已通过，0 error，0 warning。

基线判断：`WORKFLOW-DOC-001` 后的 workflow 文档同步没有在现有 workflow assets 校验中暴露结构性错误。该结论仅限现有脚本覆盖范围，不代表 workflow 运行逻辑或 Phase gate 已完成教辅短剧生产化改造。

## 10. 是否存在脚本不支持新教辅模板的问题

存在。

当前主要问题是现有项目类验证脚本不支持 `projects/_template-edu-shortdrama/` 这类新增模板目录。旧脚本只跳过旧 `_template`、`test-*`、`*-smoke-test` 等目录，没有识别新的教辅模板目录，导致模板目录被当作真实项目检查。

因此，当前验证未完全通过的主要失败原因是脚本识别范围问题，而不是现在需要修改教辅模板内容。

## 11. 后续任务建议

建议新增并执行后续任务 `VALIDATE-002`：

- 设计教辅模板校验规则。
- 或调整旧项目校验脚本，使其明确识别并跳过 `projects/_template-edu-shortdrama/`。
- 明确模板目录与真实项目目录的校验边界。
- 补充针对教辅模板结构、字段和生产稿包边界的专用校验标准。

本轮结论：

- `VALIDATE-001` 已完成的是基线记录，不是修复。
- 当前验证未完全通过。
- 主要失败原因是旧验证脚本把 `projects/_template-edu-shortdrama/` 当成真实项目检查。
- 下一步建议 `VALIDATE-002`：设计教辅模板校验规则 / 调整验证脚本识别模板目录。
- 不要现在修复脚本。
- 不要现在修改 `_template-edu-shortdrama`。
