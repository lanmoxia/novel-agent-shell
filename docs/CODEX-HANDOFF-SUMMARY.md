# Codex 交接摘要

> 历史参考说明：本文件已不再作为默认新会话接力入口。当前默认入口是 `docs/AI-CONTEXT/README.md`，并按该目录说明读取 `CURRENT-STATE.md`、`BACKLOG.md` 和 `LAST-TASK.md`。本文件仅作为历史接力摘要保留；新任务不要优先读取本文件，除非需要追溯早期迁移历史。

> 用途：清空对话后，新会话可先读取本文件，快速接上当前项目状态。

## 当前项目状态

本项目已从 Claude Code 运行目录迁移为 Codex 维护结构。`.claude/` 已清理，不再作为流程资产目录。当前核心目录：

- `workflow/`：流程规则资产，含 `ORCHESTRATION.md`、`skills/`、`agents/`、`hooks/`、`feedback/`
- `scripts/`：维护脚本，提供 Bash 和 PowerShell 双入口
- `genre-skills/`：题材 Skill 插件
- `projects/_template/`：新项目空白模板
- `docs/`：核心文档
- `docs/reports/`：历史报告、验证记录和运行日志归档

## 已完成的核心优化

1. 清理 Claude Code 运行配置：删除 `.claude/settings*.json`，随后将 `.claude/` 流程资产整体迁移到 `workflow/`。
2. 标准化项目模板：补齐 `revision-log.md`、`FINAL-SCRIPT.md`、后置目录说明和 `GENRE-SKILL-LOCK.md` 字段。
3. 新增维护脚本：
   - `scripts/new-project.sh`
   - `scripts/new-project.ps1`
   - `scripts/validate-shell.sh`
   - `scripts/validate-shell.ps1`
   - `scripts/validate-workflow-assets.sh`
   - `scripts/validate-genre-skills.sh`
   - `scripts/validate-projects.sh`
   - `scripts/validate-project-state.sh`
   - `scripts/validate-project-state.ps1`
   - `scripts/project-status.sh`
   - `scripts/project-status.ps1`
   - `scripts/new-proposal.sh`
   - `scripts/new-proposal.ps1`
   - `scripts/update-lock-manifest.sh`
   - `scripts/update-lock-manifest.ps1`
4. 题材 Skill 增加 `version: 1.0.0`，并在 `GENRE-SKILL-LOCK.md` 中记录 Skill 版本。
5. `docs/` 根目录清理：历史报告已移动到 `docs/reports/`。
6. 为正式锁稿项目 `projects/huanghe-minsu-horror-001/` 生成 `locked/LOCK-MANIFEST.sha256`，用于检测锁稿后正文和最终稿是否变化。
7. 增强恢复/校验联动：新增 `validate-project-state` 双入口，并让 `project-status` 支持联动校验。
8. 增强进化系统分层提案机制：新增 `workflow/feedback/proposals/` 和提案模板，反馈记录增加层级与优先级。

## 当前验证命令

Windows PowerShell：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/validate-shell.ps1
```

Bash：

```bash
bash scripts/validate-shell.sh
```

最近验证结果：两套入口均为 `0 error(s), 0 warning(s)`。

## 常用维护命令

新建项目：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/new-project.ps1 <project-name>
```

```bash
bash scripts/new-project.sh <project-name>
```

锁稿后生成哈希清单：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/update-lock-manifest.ps1 <project-name>
```

```bash
bash scripts/update-lock-manifest.sh <project-name>
```

查看并校验项目恢复状态：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/project-status.ps1 <project-name> -Validate
powershell -ExecutionPolicy Bypass -File scripts/validate-project-state.ps1 <project-name>
```

```bash
bash scripts/project-status.sh --validate <project-name>
bash scripts/validate-project-state.sh <project-name>
```

新建空白进化提案：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/new-proposal.ps1 <YYYYMMDD-HHMMSS-proposal.md>
```

```bash
bash scripts/new-proposal.sh <YYYYMMDD-HHMMSS-proposal.md>
```

## 当前注意事项

- `gudai-skill-smoke-test` 和 `test-xianshi-demo` 是测试/示例项目，不要作为正式模板复制。
- 正式新项目必须从 `projects/_template/` 创建，推荐使用 `scripts/new-project.*`。
- `workflow/settings*.json` 和 `.claude/` 不是当前必需结构，不要恢复为流程入口。
- PowerShell 脚本避免在逻辑判断中直接依赖中文字符串，以兼容 Windows PowerShell 5.1 编码行为。
- 修改中文文件时继续保持 UTF-8。
- 进化提案只能写入 `workflow/feedback/proposals/`，不得自动修改 ORCHESTRATION、Skill、Agent、Hook 或项目记忆。

## 建议下一步

1. 进一步把状态校验结果接入阶段门禁提示，或补充一个生成空白进化提案的维护脚本。
2. 视需要把 PowerShell 验证拆成更细的 `validate-projects.ps1`、`validate-genre-skills.ps1`。
3. 如果要分发干净模板，可按 `docs/TEMPLATE-PACKAGING-GUIDE.md` 删除 `docs/reports/` 和示例项目。
