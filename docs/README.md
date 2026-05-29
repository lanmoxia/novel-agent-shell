# 文档入口

本目录保存小说/剧本创作 Agent 壳子的架构说明、接口合约和维护路线。历史运行记录和验收报告已归档到 `reports/`。新贡献者应先阅读“核心文档”，再按需查看报告。

## 核心文档

- `AI-CONTEXT/README.md`：Codex / AI 新会话长期上下文入口，先读当前状态和长期优化清单。
- `AI-CONTEXT/CURRENT-STATE.md`：当前项目定位、迁移状态、暂停事项、主要问题、下一步建议和禁止事项。
- `AI-CONTEXT/BACKLOG.md`：长期优化清单，按编号记录任务，每次默认只执行一个任务。
- `AI-CONTEXT/LAST-TASK.md`：最近一次任务的短摘要，也是默认新会话读取文件。
- `AI-CONTEXT/archive/`：长审计报告和历史分析归档区，默认新会话不读取，只在任务明确需要时按需读取。
- `SHELL-SPEC.md`：壳子的总体职责、阶段流程和边界。
- `SHELL-BUILD-PLAN.md`：当前维护状态和后续优化路线图。
- `GENRE-SKILL-CONTRACT.md`：`genre-skills/` 题材 Skill 的文件结构与加载规则。
- `NEXT-PRODUCTION-STEPS.md`：新建正式项目时的操作顺序。
- `TOKEN-CONTROL.md`：上下文和 Token 使用约束。
- `OPEN-QUESTIONS.md`：仍未确定的设计问题。

## 历史参考

- `CODEX-HANDOFF-SUMMARY.md`：旧接力摘要，已不再作为默认新会话入口；仅在追溯历史迁移状态时按需读取。
- `SHELL-OPTIMIZATION-ROADMAP.md`：旧壳子优化路线图，已不再作为当前任务清单或新会话接力文件；当前任务以 `AI-CONTEXT/BACKLOG.md` 为准。

## 维护脚本

- `scripts/validate-shell.sh`：统一检查仓库结构、工作流资产、模板和题材 Skill。
- `scripts/validate-workflow-assets.sh`：检查 `workflow/` 下 Skill、Agent、Hook 和编排文件。
- `scripts/validate-genre-skills.sh`：检查 `genre-skills/` 题材 Skill 合约。
- `scripts/validate-projects.sh`：检查 `projects/` 下正式项目的关键阶段目录和文件。
- `scripts/new-project.sh`：从 `projects/_template/` 创建新项目目录。
- `scripts/validate-shell.ps1`：Windows PowerShell 统一验证入口。
- `scripts/new-project.ps1`：Windows PowerShell 新建项目入口。
- `scripts/update-lock-manifest.*`：为已锁稿项目生成锁稿哈希清单。

## 模板与打包

- `TEMPLATE-PACKAGING-GUIDE.md`：分发模板时应保留和排除的文件。

## 验证与报告

`reports/` 存放历史阶段验证记录、运行日志、修复报告和备份说明。新增报告时建议放入 `docs/reports/`，并使用：

```text
<SCOPE>-<PHASE-or-TOPIC>-REPORT.md
<SCOPE>-VALIDATION-RECORD.md
```

示例：`docs/reports/PHASE-5-SCRIPT-REVIEW-TEST-REPORT.md`、`docs/reports/HUANGHE-SKILL-V2-VALIDATION-RECORD.md`。

## 维护规则

- 修改 `workflow/hooks/`、`workflow/skills/` 或 `genre-skills/` 合约时，必须同步更新相关核心文档。
- 新增正式项目流程变化时，优先更新 `NEXT-PRODUCTION-STEPS.md`。
- 中文和中英混合文档必须保持 UTF-8 编码。
