# Token 消耗控制规则

> 本文档定义 Agent 壳子运行时的 token 消耗控制策略。

---

## 1. 核心原则

ORCHESTRATION.md 不放长篇题材内容。ORCHESTRATION.md 只放流程、门禁、调度规则。题材 Skill 内容按需读取。

---

## 2. 摘要优先策略

- 每个项目生成 `GENRE-SKILL-LOCK.md` 作为题材规则摘要和索引
- 后续阶段优先读取摘要文件，不重复读取长篇原始资料
- 每次只处理当前章节、当前集、当前场次
- 审查 Agent 只读取自己负责范围内的必要文件

---

## 3. 分阶段读取策略

| 阶段 | 读取文件 | 不读取 |
|------|---------|--------|
| Phase 0：项目初始化 | PROJECT.md | 所有题材文件 |
| Phase 1：题材加载 | 全部题材文件（一次性） | 具体创作内容 |
| Phase 2：故事企划 | GENRE-SKILL-LOCK.md（摘要）、genre-profile.md | examples/ |
| Phase 3：大纲 | structure-rules.md（摘要）、OUTLINE.md | examples/、templates/ |
| Phase 4：正文写作 | dialogue-rules.md、style-guide.md（按需） | 完整 structure-rules.md |
| Phase 5：审查 | 各 Agent 只读自己负责的文件 | 其他 Agent 的文件 |

---

## 4. 禁止行为

- 把教程全文塞进 ORCHESTRATION.md
- 把题材 Skill 全文塞进 ORCHESTRATION.md
- 每一轮都读取所有 examples
- 一次性生成完整长篇
- 审查时让一个 Agent 读取全部文件
- 在故事企划阶段就读取全量题材文件

---

## 5. 输出控制

- 每次 script-writer 调用只输出当前请求的章节/集数
- 不允许"一次性输出全剧"
- 大纲阶段输出节拍/章纲，不输出完整正文
- 审查报告汇总后只保留关键发现，不重复输出原始内容

---

## 6. 优化建议

- 对已稳定的题材 Skill，GENRE-SKILL-LOCK.md 的摘要可以持久化为缓存
- 如果某题材 Skill 的 examples/ 很大，可以在加载时跳过，标注为"按需查阅"
- 长期项目的中期审查可以只做增量审查（只查新增部分）
