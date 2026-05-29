# 壳子维护路线图

> 本文档记录当前 Codex 维护状态和后续优化优先级。历史阶段验收记录仍保留在各类 `*-REPORT.md` 文件中。

---

## 当前状态

`novel-agent-shell-demo` 已从 Claude Code 运行目录迁移为中立的 `workflow/` 结构。当前主流程、模板、题材 Skill 合约、审查 Agent、阶段门禁和维护脚本均已具备基础可用性。

当前验证入口：

```bash
bash scripts/validate-shell.sh
```

该命令会串联检查：
- 仓库结构
- `workflow/` 流程资产
- `projects/_template/` 空白模板
- `projects/` 正式项目结构
- `genre-skills/` 题材 Skill 合约

---

## 已完成

### 1. 流程资产迁移

- `workflow/ORCHESTRATION.md`
- `workflow/skills/`
- `workflow/agents/`
- `workflow/hooks/`
- `workflow/feedback/`

`.claude/` 已不再作为项目结构使用。

### 2. 项目模板标准化

- `projects/_template/PROJECT.md`
- `projects/_template/GENRE-SKILL-LOCK.md`
- `projects/_template/specs/STORY-SPEC.md`
- `projects/_template/outlines/OUTLINE.md`
- `projects/_template/scripts/SCRIPT-STATUS.md`
- `projects/_template/revisions/revision-log.md`
- `projects/_template/locked/FINAL-SCRIPT.md`
- 后置目录：`shotlists/`、`short-drama-shotlists/`、`seedance-prompts/`

### 3. 维护脚本

- `scripts/new-project.sh`
- `scripts/validate-shell.sh`
- `scripts/validate-workflow-assets.sh`
- `scripts/validate-genre-skills.sh`
- `scripts/validate-projects.sh`
- `scripts/new-project.ps1`
- `scripts/validate-shell.ps1`

### 4. 题材 Skill 版本字段

- 标准题材 Skill 推荐 `version`
- 现有题材 Skill 已补 `version: 1.0.0`
- `GENRE-SKILL-LOCK.md` 模板已增加 Skill 版本字段
- `validate-genre-skills.sh` 对缺失 version 给 warning，不阻断

### 5. PowerShell 维护入口

- `scripts/new-project.ps1`
- `scripts/validate-shell.ps1`
- PowerShell 脚本按 UTF-8 读取 Markdown / Skill 文件
- Windows 可不依赖 Git Bash 完成主体结构验证和项目创建

### 6. 报告归档

- 历史报告、运行日志、验证记录已移动到 `docs/reports/`
- `docs/` 根目录只保留核心说明、合约、路线图和操作指南
- 新增报告默认写入 `docs/reports/`

---

## 后续优先级

### P1：项目级状态校验增强

目标：让 `validate-projects.sh` 不只检查文件存在，还能识别 Phase 状态是否自洽。

建议检查：
- `PROJECT.md` 当前阶段与实际文件是否匹配
- `GENRE-SKILL-LOCK.md` 状态是否为已锁定
- `SCRIPT-STATUS.md` 当前状态与 `reviews/`、`locked/` 是否一致

### P2：项目状态语义校验

目标：继续增强 `validate-projects.sh`，让它能识别更多阶段状态不一致问题。

已完成：
- 检查已锁定项目的 `GENRE-SKILL-LOCK.md` 是否记录 Skill 版本
- 检查锁稿项目的 `SCRIPT-STATUS.md` 和 `PROJECT.md` 是否匹配
- 检查后置目录有非 README 输出时是否满足锁稿和 Phase 8 语义
- 通过 `locked/LOCK-MANIFEST.sha256` 检查锁稿后正文和最终稿是否发生变化

后续可继续增强：
- 检查 `GENRE-SKILL-LOCK.md` 中的 Skill 版本是否与当前题材 Skill 版本一致

---

## 维护规则

- 修改 `workflow/`、`genre-skills/`、`projects/_template/` 后必须运行 `bash scripts/validate-shell.sh`。
- 不恢复 `.claude/` 作为运行目录。
- 不把具体题材规则写入 `workflow/ORCHESTRATION.md`。
- 题材规则放入 `genre-skills/`，项目产物放入 `projects/<project-name>/`。
