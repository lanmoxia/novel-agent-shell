# WORKFLOW-DOC-001：workflow 文档教辅 Phase 语义同步

- 完成日期：2026-05-28
- 任务类型：workflow 文档语义同步
- 脚本修改：无
- Hook 修改：无
- Skill 修改：无
- 模板修改：无
- 项目创建：无
- 测试运行：无

## 1. 本轮修改范围

实际修改：

- `workflow/ORCHESTRATION.md`
- `docs/SHELL-SPEC.md`
- `docs/SHELL-BOUNDARY.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`

实际新增：

- `docs/AI-CONTEXT/archive/WORKFLOW-DOC-001-PHASE-SEMANTIC-SYNC.md`

## 2. 修改目的

本轮目标是把旧小说 / 剧本 Phase 0-8 的 workflow 文档说明，同步为兼容教辅短剧项目的双语义说明。

本轮只同步文档语义，不改变执行逻辑：

- 不删除旧小说 / 剧本语义。
- 不改变 Phase 编号。
- 不修改 Hook、脚本或验证逻辑。
- 不把教辅逻辑硬编码进 shell。
- 不修改 `genre-skills/`。
- 不修改 `projects/_template/` 或 `projects/_template-edu-shortdrama/`。

## 3. Phase 0-8 同步表

| Phase | 旧小说 / 剧本语义 | 教辅短剧语义 | 本轮同步结果 |
|---|---|---|---|
| Phase 0 | 项目初始化 | 项目建档：篇目、原文、出处、年级、时长、输出范围 | 已同步到 `workflow/ORCHESTRATION.md` 和 `docs/SHELL-SPEC.md` |
| Phase 1 | 题材 Skill 加载 | 教辅 Skill 加载：锁定 `wenyan-skill`，记录 declared / inferred / missing capabilities | 已同步 |
| Phase 2 | 故事企划 | 原文拆解与教学目标规格，不是原创故事企划 | 已同步 |
| Phase 3 | 大纲 / 节拍 | 情境复演结构与 Scene 原文映射 | 已同步 |
| Phase 4 | 剧本正文 | 正片剧本、原文映射表、字幕方案草案、分镜草案状态 | 已同步 |
| Phase 5 | 多维审查 | 教学与生产审查：原文准确性、白话释义、Scene 映射、字幕可读性、镜头可生产性 | 已同步 |
| Phase 6 | 修订 | 修订教学错误、映射错误、字幕问题、分镜问题和视频风险 | 已同步 |
| Phase 7 | 锁稿 | 生产稿包锁定；`FINAL-SCRIPT.md` 不代表完整生产稿包 | 已同步 |
| Phase 8 | 后置模块 | 短剧分镜、字幕、视频风险说明、可选视频提示词，默认关闭且需用户确认 | 已同步 |

## 4. workflow 文档变更摘要

`workflow/ORCHESTRATION.md` 变更摘要：

- 在 Agent 身份部分补充：壳子保留旧小说 / 剧本语义，同时允许教辅短剧语义。
- 新增“教辅短剧项目 Phase 语义兼容说明”。
- 增加 Phase 0-8 双语义表。
- 补充教辅短剧项目的门禁解释：原文拆解、Scene 映射、教学与生产审查、生产稿包锁定。
- 补充教辅项目中的 `PROJECT-MEMORY.md` 和 `ENDING-LOCK.md` 语义。
- 补充教辅 Skill 边界：Skill 可以声明教辅能力，但不接管 workflow。
- 补充教辅 Phase 5 审查维度。
- 补充教辅 Phase 8 后置输出边界。

## 5. SHELL-SPEC 变更摘要

`docs/SHELL-SPEC.md` 变更摘要：

- 增加 shell 支持多业务语义的说明。
- 增加项目类型表：旧小说 / 剧本项目使用 `projects/_template/`，教辅短剧项目使用 `projects/_template-edu-shortdrama/`。
- 补充 `_template-edu-shortdrama` 的存在意义：承载篇目、原文、出处、年级、教学目标、Scene 原文映射、字幕、分镜、视频风险和生产稿包边界。
- 增加 Phase 0-8 教辅语义表。
- 补充教辅短剧项目的目录语义。
- 明确 shell 不负责具体教学规则。

## 6. SHELL-BOUNDARY 变更摘要

`docs/SHELL-BOUNDARY.md` 变更摘要：

- 明确 shell 可以承载不同业务语义，但边界不变。
- 明确 shell 不负责文言文解释正确性。
- 明确原文事实、白话释义、教学目标、Scene 映射、字幕规则、分镜规则和视频风险由 Skill / 模板 / 审查承担。
- 明确 shell 不自动生成视频、图片或后置提示词。
- 明确 shell 不绕过用户确认。
- 新增教辅短剧边界表，拆分 shell、Skill、项目模板、审查产物职责。
- 明确 `projects/_template-edu-shortdrama/` 不影响旧 `projects/_template/`。

## 7. 未修改范围

本轮未修改：

- `scripts/`
- `workflow/hooks/`
- `genre-skills/`
- `projects/`
- `projects/_template/`
- `projects/_template-edu-shortdrama/`
- `docs/GENRE-SKILL-CONTRACT.md`
- `AGENTS.md`
- `README.md`
- `docs/README.md`

本轮未运行测试，未创建项目，未执行 `VALIDATE-001`、`SKILL-002` 或创作测试。

## 8. 后续任务建议

主任务建议：**SKILL-002：按新合约补强 `wenyan-skill` 元数据**。

理由：

- Skill 内容层已有 `wenyan-skill`。
- 模板层已有 `projects/_template-edu-shortdrama/`。
- 合约层已完成 `CONTRACT-001`。
- workflow 文档已完成 Phase 0-8 教辅语义同步。
- 当前剩余主要缺口是 `wenyan-skill` 尚未按新合约声明 `version`、`capabilities`、`fallbackRules` 和 `shellBoundary`。

不建议现在直接执行：

- `VALIDATE-001`：当前应先补强 Skill 元数据，再记录验证基线。
- 创作测试：当前尚未补齐 `wenyan-skill` 的机器可读能力声明和边界。

## 9. 明确结论

- `WORKFLOW-DOC-001` 已完成的是文档层 Phase 语义同步。
- 本轮没有修改脚本。
- 本轮没有修改 Hook。
- 本轮没有修改 Skill。
- 本轮没有修改项目模板。
- 本轮没有修改任何项目。
- 本轮没有运行测试。
- 下一步建议是 `SKILL-002`：按新合约补强 `wenyan-skill` 元数据。
