# VALIDATE-002-AUDIT：validate 项目目录识别只读审计

- 任务编号：VALIDATE-002-AUDIT
- 任务名称：只读分析现有 validate 脚本如何识别项目目录和模板目录
- 审计日期：2026-05-29
- 当前状态：已完成

## 1. 审计范围

本轮只读审计现有 validate 脚本如何识别 `projects/` 下的真实项目目录、模板目录和样例 / 测试目录，并判断 `projects/_template-edu-shortdrama/` 被旧项目校验误检的原因。

本轮不是修复任务：

- 未修改 `scripts/`。
- 未修改 `workflow/`。
- 未修改 `genre-skills/`。
- 未修改 `projects/`、`projects/_template/` 或 `projects/_template-edu-shortdrama/`。
- 未运行 validate 脚本。
- 未创建项目。
- 未生成剧本、分镜、视频提示词或创作测试内容。

## 2. 读取文件列表

本轮只读取以下文件：

- `docs/AI-CONTEXT/README.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/archive/VALIDATE-001-BASELINE.md`
- `scripts/validate-projects.sh`
- `scripts/validate-project-state.sh`
- `scripts/validate-project-state.ps1`
- `scripts/validate-shell.sh`
- `scripts/validate-shell.ps1`
- `projects/_template/PROJECT-STATE.json`
- `projects/_template-edu-shortdrama/PROJECT-STATE.json`

未读取：

- Codex 全局 memory。
- `.claude/`。
- `workflow/settings*.json`。

## 3. 现有项目校验目录识别逻辑

### `scripts/validate-projects.sh`

`validate-projects.sh` 使用 shell glob 遍历：

```bash
for project_dir in "$PROJECTS_DIR"/*/; do
  project="$(basename "$project_dir")"
```

当前跳过规则只有：

- `_template`
- `test-*`
- `*-smoke-test`

`_template` 会直接 `continue`。`test-*` 和 `*-smoke-test` 会输出 info 后 `continue`。

未被跳过的目录会被计入 `FOUND`，并作为真实生产项目检查：

- 必须有 `PROJECT.md`
- 必须有 `PROJECT-STATE.json`
- 必须有 `RUN-LOG.md`
- 必须有 `GENRE-SKILL-LOCK.md`
- 必须有 `PROJECT-MEMORY.md`
- 必须有 `specs/`、`outlines/`、`planning/`、`materials/`、`scripts/`、`drafts/`、`reviews/`、`revisions/`、`locked/` 等项目目录
- `PROJECT-STATE.json` 必须至少包含 `phase`、`status`、`locked`
- 如果存在 `locked/FINAL-SCRIPT.md`，会继续检查 `reviews/final-review.md`、`scripts/SCRIPT-STATUS.md`、`PROJECT.md` Phase 7、lock manifest、`PROJECT-STATE.json locked`
- `RUN-LOG.md` 需要包含运行记录章节

### `scripts/validate-project-state.sh`

无指定项目时，脚本同样遍历 `projects/*/`：

```bash
for project_dir in "$PROJECTS_DIR"/*/; do
  project="$(basename "$project_dir")"
```

当前跳过规则只有：

- `_template`
- `test-*`
- `*-smoke-test`

指定项目模式下，拒绝规则是：

- `_template`
- `test-*`
- `*-smoke-test`
- 包含 `/`
- 包含 `\`
- 以 `.` 开头

`_template-edu-shortdrama` 不匹配这些规则，因此会进入真实项目状态校验。

### `scripts/validate-project-state.ps1`

无指定项目时，PowerShell 版使用：

```powershell
Get-ChildItem -LiteralPath $ProjectsDir -Directory
```

当前跳过规则只有：

- `$Name -eq "_template"`
- `$Name -like "test-*"`
- `$Name -like "*-smoke-test"`

指定项目模式下，拒绝规则也是 `_template`、`test-*`、`*-smoke-test`、隐藏目录和路径分隔符。`_template-edu-shortdrama` 不会被拒绝，也不会被识别为模板。

### `scripts/validate-shell.sh`

`validate-shell.sh` 本身只把 `projects/_template/` 当作项目模板做结构检查。随后它会调用：

- `bash "$ROOT_DIR/scripts/validate-projects.sh"`
- `bash "$ROOT_DIR/scripts/validate-project-state.sh"`

因此 `validate-shell.sh` 会继承这两个脚本对 `_template-edu-shortdrama` 的误检。

### `scripts/validate-shell.ps1`

PowerShell 版除了检查 `projects/_template/`，还在自身的 active projects 段遍历 `projects/`。该段同样只跳过：

- `_template`
- `test-*`
- `*-smoke-test`

随后它还会调用：

- `scripts\validate-project-state.ps1`

因此 `validate-shell.ps1` 有两条路径会把 `_template-edu-shortdrama` 当作真实项目：自身 active projects 遍历，以及 delegated project state 校验。

## 4. 现有项目状态字段要求

### `validate-projects.sh` 的状态字段要求

`validate-projects.sh` 对 `PROJECT-STATE.json` 的直接字段要求较浅，但面向真实项目：

- 必须存在 `phase`
- 必须存在 `status`
- 必须存在 `locked`

此外，如果 `locked/FINAL-SCRIPT.md` 存在，它还会要求或提示：

- `reviews/final-review.md` 存在
- `scripts/SCRIPT-STATUS.md` 表示已锁稿
- `PROJECT.md` 表示 Phase 7
- `locked/LOCK-MANIFEST.sha256` 存在且匹配
- `PROJECT-STATE.json locked` 为 `true`

### `validate-project-state.sh` / `.ps1` 的状态字段要求

两个版本的语义基本一致，要求 `PROJECT-STATE.json` 是真实项目恢复状态：

- `project` 必须存在，并且必须等于目录名
- `phase` 必须是 `0` 到 `8` 的整数
- `status` 必须存在
- `locked` 必须是布尔值
- `confirmedArtifacts` 下按阶段检查真实项目产物

关键 `confirmedArtifacts` 键包括：

- `projectMd`
- `genreSkillLock`
- `storySpec`
- `endingLock`
- `outline`
- `reverseOutline`
- `finalReview`
- `revisionLog`
- `finalScript`

阶段门禁要求：

- Phase 1 及以后要求 `projectMd`
- Phase 2 及以后要求 `genreSkillLock`
- Phase 3 及以后要求 `storySpec`、`endingLock`
- Phase 4 及以后要求 `outline`、`reverseOutline`
- Phase 5 及以后要求 `scripts/` 下存在至少一个正文 / 章节文件
- Phase 6 及以后要求 `finalReview`
- Phase 7 及以后要求 `finalScript` 且 `locked` 为 `true`

运行日志要求：

- 如果存在 `RUN-LOG.md`，Bash 版要求有 `- 下一步：` 记录
- PowerShell 版要求有 next-step entry
- 两版都会尝试用最新 Phase 记录与 `PROJECT-STATE.json phase` 做一致性检查

### 字段要求是否适用于模板目录

这些字段要求不适合直接套用到模板目录。

原因是它们描述的是一个已经从模板实例化出来的真实项目的恢复状态，而不是模板自身的结构状态。模板目录可以包含示例文件、空文件、字段草案、生产稿包占位、锁稿产物模板或阶段说明，但不应被要求具备真实项目的：

- 项目实例名 `project`
- `locked` 运行状态
- 已确认的 `finalReview`
- 已锁稿的 `FINAL-SCRIPT`
- 与真实执行历史匹配的 `RUN-LOG.md`
- Phase 5/6/7 的真实阶段门禁产物

## 5. `_template-edu-shortdrama` 被误检原因

直接原因：现有脚本的模板目录识别是硬编码名单，只识别旧模板名 `_template`，没有识别 `_template-edu-shortdrama`。

具体表现：

- `validate-projects.sh` 只跳过 `_template`、`test-*`、`*-smoke-test`。
- `validate-project-state.sh` 只跳过 `_template`、`test-*`、`*-smoke-test`。
- `validate-project-state.ps1` 只跳过 `_template`、`test-*`、`*-smoke-test`。
- `validate-shell.ps1` 自身 active projects 遍历也只跳过 `_template`、`test-*`、`*-smoke-test`。

`projects/_template-edu-shortdrama/PROJECT-STATE.json` 的结构是教辅模板状态：

- 有 `projectType: "edu-shortdrama"`
- 有 `skillId: "wenyan-skill"`
- 有 `phase`、`status`
- 有教辅专用状态字段，例如 `eduTextStatus`、`sceneMappingStatus`、`subtitleStatus`、`shotlistStatus`、`productionPackageStatus`
- 有 `lockedArtifacts`
- 没有旧真实项目校验要求的 `project`
- 没有旧真实项目校验要求的 `locked`

因此旧 project state 脚本会报 `missing project`、`missing locked` 或 `locked must be true or false`。如果模板目录内存在锁稿或生产稿包示例 / 占位文件，旧 projects 校验还会进一步触发 `final-review`、`SCRIPT-STATUS.md`、`RUN-LOG.md` 等真实项目状态检查。

## 6. 可选修复方案 A / B / C / D 对比

| 方案 | 内容 | 优点 | 缺点 | 判断 |
| ---- | ---- | ---- | ---- | ---- |
| A | 让旧项目校验脚本跳过 `_template-edu-shortdrama` | 快速消除误检；符合模板不是项目的边界 | 只能避免旧误检，不能验证教辅模板自身结构 | 可作为必要修复的一部分 |
| B | 为 `_template-edu-shortdrama` 新增专用模板校验脚本 | 能检查教辅模板自己的字段、目录和产物边界 | 如果不同时改旧脚本，旧项目校验仍会误检 | 单独做不够 |
| C | 同时做 A 和 B | 旧项目校验不再误检模板；教辅模板有独立校验规则；边界最清楚 | 需要同时设计跳过规则和专用模板规则 | 推荐 |
| D | 修改 `_template-edu-shortdrama` 迎合旧项目校验 | 可能让旧脚本暂时通过 | 会把模板伪装成真实项目，污染字段语义和运行状态 | 不推荐 |

## 7. 推荐方案

推荐方案 C：旧项目校验跳过教辅模板目录，同时为教辅模板保留或新增专用校验规则。

推荐落地为后续主任务：

`VALIDATE-002-FIX`：调整验证脚本识别模板目录，并为教辅模板校验留出专用规则。

建议该任务至少覆盖：

- 在 Bash / PowerShell 项目校验入口中统一识别模板目录。
- 让 `_template-edu-shortdrama` 不再进入真实项目校验。
- 保留 `_template` 的旧模板检查逻辑。
- 为 `_template-edu-shortdrama` 设计独立的模板结构 / 字段校验入口，或先预留明确的后续校验边界。
- 保证 `validate-shell.*` 不再通过 active projects 遍历或 delegated project state 校验误检教辅模板。

## 8. 不建议修改教辅模板的原因

不建议修改 `projects/_template-edu-shortdrama/` 来迎合旧项目校验。

原因：

- `_template-edu-shortdrama` 是模板，不是真实项目。
- 旧项目校验的 `project` 字段要求面向具体项目实例，不适合模板目录。
- 旧项目校验的 `locked` 字段是运行状态，不应强制模板声明为真实锁稿状态。
- `final-review.md`、`locked/FINAL-SCRIPT.md`、`SCRIPT-STATUS.md`、`RUN-LOG.md` 的一致性检查面向真实项目过程，不是模板结构检查。
- 为通过旧脚本而添加伪状态，会混淆模板、样例和真实项目三者边界。
- 教辅模板有自己的字段体系，例如 `projectType`、`skillId`、教辅状态字段和 `lockedArtifacts`，应由专用模板规则校验。

## 9. 后续任务建议

只推荐一个主任务：

`VALIDATE-002-FIX`：调整验证脚本识别模板目录，并为教辅模板校验留出专用规则。

该任务执行前应先限定修改范围。建议不要在 `VALIDATE-002-FIX` 里修改教辅模板内容，除非修复过程中发现模板字段本身存在与已确认方案冲突的问题，并由用户另行确认。
