# AI-CONTEXT 新会话上下文入口

本目录用于给 Codex / AI 新会话读取长期上下文，避免每次重新手写接力包。

## 文件职责

- `README.md`：本目录入口，说明新会话读取顺序和维护规则。
- `CURRENT-STATE.md`：当前项目定位、状态、暂停事项、主要问题、下一步建议和禁止事项。
- `BACKLOG.md`：长期优化清单，所有任务必须有编号、状态、目标、修改范围、禁止范围和验收标准。
- `LAST-TASK.md`：最近一次任务的短摘要，只记录本轮结果、下一步建议和按需读取的归档文件。
- `archive/`：长审计报告、历史分析和归档结论。默认新会话不读取，只在任务需要时按需读取。

## 新会话读取顺序

每次新会话进入本仓库时，默认只读取：

1. `docs/AI-CONTEXT/README.md`
2. `docs/AI-CONTEXT/CURRENT-STATE.md`
3. `docs/AI-CONTEXT/BACKLOG.md`
4. `docs/AI-CONTEXT/LAST-TASK.md`

## 按任务动态读取

- 做 `ARCH-002` 时，读取 `docs/AI-CONTEXT/archive/ARCH-001-AUDIT.md`。
- 做 `SKILL-001` 时，读取 `docs/GENRE-SKILL-CONTRACT.md` 和 `genre-skills/wenyan-skill/`。
- 做 `TEMPLATE-001` 时，读取 `projects/_template/`。
- 做 `CLEAN-001` 时，扫描 `docs/`、`workflow/`、`projects/`、`docs/AI-CONTEXT/`。
- 如果任务涉及架构、workflow、Skill 合约或生成流程，再按需读取 `docs/GENRE-SKILL-CONTRACT.md`、`workflow/ORCHESTRATION.md` 和相关文件。

`archive/` 不是默认上下文，只是归档证据区。不要在新会话启动时全文读取 `archive/`，除非当前任务明确依赖其中某份归档文件。

## 维护规则

- 每次只执行 `BACKLOG.md` 中一个明确编号的任务，除非用户明确授权多个任务。
- 任务完成后，如项目状态、暂停事项、下一步或禁止事项发生变化，必须更新 `CURRENT-STATE.md`。
- 任务完成后，必须更新 `BACKLOG.md` 中对应任务状态，并补充必要备注。
- 任务完成后，必须更新 `LAST-TASK.md`，保持短摘要，不写长报告。
- 不得把长篇项目背景塞进 `AGENTS.md`；`AGENTS.md` 只保留启动规则和硬约束。
- 不得未经用户确认大范围修改 `workflow/`、`scripts/`、`genre-skills/`、`projects/_template/` 或测试项目。
