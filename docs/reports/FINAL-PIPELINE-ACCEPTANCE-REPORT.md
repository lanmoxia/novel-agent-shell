# 壳子主流程闭环验收报告

- 验收时间：2026-05-12
- 测试项目：test-xianshi-demo
- 测试模式：完整跑通 Phase 0 → Phase 8
- 结论：主流程闭环通过

---

## 已跑通阶段

| Phase | 阶段名称 | 状态 | 关键输出 |
|-------|----------|------|----------|
| 0 | 项目初始化 | ✓ | PROJECT.md, 项目档案 |
| 1 | 题材 Skill 加载 | ✓ | GENRE-SKILL-LOCK.md |
| 2 | 故事企划 | ✓ | specs/STORY-SPEC.md |
| 3 | 大纲/节拍 | ✓ | outlines/OUTLINE.md |
| 4 | 正文写作 | ✓ | scripts/E01–E05（5 章） |
| 5 | 多维审查 | ✓ | reviews/final-review.md（四类审查） |
| 6 | 修订 | ✓ | revisions/revision-log.md（3 严重修复） |
| 7 | 锁稿 | ✓ | locked/FINAL-SCRIPT.md |
| 8 | 后置模块 | ✓ | shotlists/E01-shotlist.md（分镜测试） |

---

## 已验证的关键门禁

| 门禁 | 测试方式 | 结果 |
|------|----------|------|
| STORY-SPEC 未确认不得进入大纲 | Phase 2 → Phase 3 流程验证 | ✓ |
| OUTLINE 未确认不得进入正文 | Phase 3 → Phase 4 流程验证 | ✓ |
| 正文未完成不得生成 final-review.md | stop-gate 占位检查 | ✓ |
| Phase 5 审查完成后不得自动进入 Phase 6 | script-review SKILL.md 门禁规则 | ✓ |
| revision-fixer 不得越权修订范围 | SKILL.md 范围控制 + 注意事项 | ✓ |
| final-review.md 占位/不完整文件无效 | stop-gate 占位拦截 | ✓ |
| locked/FINAL-SCRIPT.md 检查优先级最高 | stop-gate 情况 1 优先 | ✓ |
| 未锁稿不得进入 Phase 8 | post-production-builder 前置条件 | ✓ |
| Seedance 默认关闭 | post-production-builder + CLAUDE.md | ✓ |
| 跨阶段自动推进被禁止 | CLAUDE.md 跨阶段禁止规则 | ✓ |

---

## 本轮发现并修复的问题

| # | 问题 | 修复方式 | 涉及文件 |
|---|------|----------|----------|
| 1 | 路径规范不统一，Bash/PowerShell 混用 | CLAUDE.md 新增命令环境规范 | CLAUDE.md |
| 2 | Phase 编号错误（SCRIPT-STATUS.md 中的状态表述不一致） | 统一为 Phase N 格式 | SCRIPT-STATUS.md |
| 3 | 状态字段混用（"锁稿"vs"Phase 7"表述不一致） | 统一关键状态关键词 | 多个文件 |
| 4 | stop-gate 对正文生成中的状态过度阻断 | 新增非阻断提醒路径 | stop-gate.sh |
| 5 | 模型伪造占位 final-review.md | stop-gate 新增占位/不完整检查 | stop-gate.sh |
| 6 | stop-gate 阻断提示可能诱导自动修订 | 改为明确阻断提示，不暗示自动进入 | stop-gate.sh + SKILL.md |
| 7 | revision-fixer 可越权修订超出用户选择范围 | 新增范围控制门禁 + 禁止越权条款 | revision-fixer/SKILL.md |
| 8 | Bash/PowerShell 命令混用导致脚本执行失败 | CLAUDE.md 命令环境规范 + 工具选择规范 | CLAUDE.md |
| 9 | Phase 8 分镜和 Seedance 未区分，后置模块无调度 Skill | 创建 post-production-builder，区分三类输出 | post-production-builder/SKILL.md + CLAUDE.md |
| 10 | Phase 5 → Phase 6 缺少用户确认门禁 | script-review 新增门禁规则 + stop-gate 新增 Phase 6 等待状态 | script-review/SKILL.md + stop-gate.sh |

---

## 当前剩余建议

1. **后续创建正式项目时，应复制壳子框架，不复制 test-xianshi-demo 正文。** test-xianshi-demo 保留为示例项目。
2. **xianshi-skill 和 gudai-skill 后续可升级为标准合约格式。** 当前 genre-reviewer 对 xianshi-skill 为降级审查模式。
3. **Seedance 模块需要单独设计。** 不应和小说分镜共用格式，提示词工程需要专门的模板和参数体系。
4. **可新增 clean-template 目录或创建空白示例项目模板。** 便于快速启动新项目。
5. **短剧分镜（short-drama-shotlists/）为预留接口，格式未定义。** 后续需要单独设计场次/集数分镜模板。

---

## 最终结论

**壳子主流程闭环通过。** Phase 0 → Phase 8 全链路跑通，各阶段门禁机制就位，跨阶段自动推进已封堵，审查→修订→锁稿→后置模块流程完整。可进入模板化整理阶段，开始创建正式项目。
