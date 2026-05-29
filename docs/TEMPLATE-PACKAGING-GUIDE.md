# 模板打包与分发指南

本文件说明如何从当前壳子仓库打包可复用的模板，以及哪些内容属于模板、哪些属于本地痕迹。

---

## 打包模板时应包含

| 路径 | 说明 |
|------|------|
| `workflow/ORCHESTRATION.md` | 顶层调度规则（核心文件） |
| `workflow/skills/` | 通用流程 Skill（project-intake-builder, genre-loader, story-spec-builder, outline-builder, script-writer, script-review, revision-fixer, script-locker, post-production-builder） |
| `workflow/agents/` | 审查 Agent 和反馈 Agent（structure-reviewer, continuity-reviewer, dialogue-reviewer, genre-reviewer, feedback-observer, evolution-runner） |
| `workflow/hooks/` | 阶段门禁 Hook 脚本（stop-gate.sh 等） |
| `workflow/feedback/` | 反馈记录系统框架 |
| `docs/` | 架构文档和流程指南 |
| `genre-skills/` | 题材 Skill 插件和合约定义 |
| `projects/README.md` | 项目目录说明 |
| `projects/_template/` | 空白项目模板（干净起点） |
| `.gitignore` | 排除本地文件的规则 |
| `README.md` | 项目总览 |

## 打包模板时不应包含

| 路径 | 原因 |
|------|------|
| `.claude/` | Claude Code 运行目录，Codex 维护模式下不需要 |
| `workflow/settings.local.json` | 本地运行权限缓存，如临时生成则不打包 |
| `workflow/settings.json` | 运行配置兼容文件，Codex 维护模式下不需要 |
| 个人本地权限文件 | 每个用户的权限设置不同 |
| `node_modules/` | 第三方依赖（如有） |
| `dist/` | 构建产物 |
| `*.log` | 运行日志 |
| `*.tmp` | 临时文件 |
| `.DS_Store` | macOS 系统文件 |
| `projects/test-xianshi-demo/` | 示例项目正文，不是模板内容。可选择保留作为参考或打包时排除 |

## 锁稿清单

正式项目锁稿后建议保留 `locked/LOCK-MANIFEST.sha256`。该文件只记录相对路径和 SHA-256，用于检测锁稿后 `locked/FINAL-SCRIPT.md` 和章节正文是否被改动。

## test-xianshi-demo 说明

`projects/test-xianshi-demo/` 是本轮主流程闭环测试的示例项目。它展示了 Phase 0 → Phase 8 完整流程的输出结构，**但不是空白模板**。

分发模板时建议：
- 如果要发给别人当**干净模板**：保留 `_template/`，删除 `test-xianshi-demo/`
- 如果要展示**完整示例**：保留 `test-xianshi-demo/` 目录结构（可保留正文作为参考），同时保留 `_template/`

## 创建干净模板建议

`projects/_template/` 已创建，是正式的空白项目模板。新建项目时应复制 `_template`，而不是复制 `test-xianshi-demo`。

## 分发时建议清理的测试报告

历史测试产物已统一归档到 `docs/reports/`。分发干净模板时可删除整个目录，或仅保留需要展示的验收记录。

示例：

```text
docs/reports/
```

建议保留的通用文档：
- `docs/SHELL-SPEC.md`
- `docs/GENRE-SKILL-CONTRACT.md`
- `docs/SHELL-BUILD-PLAN.md`
- `docs/TOKEN-CONTROL.md`
- `docs/OPEN-QUESTIONS.md`
- `docs/NEXT-PRODUCTION-STEPS.md`
- `docs/TEMPLATE-PACKAGING-GUIDE.md`（本文件）
- `docs/README.md`
