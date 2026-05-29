# 题材 Skill 锁定记录

- 项目名：test-xianshi-demo
- 题材 Skill：xianshi-skill
- Skill 路径：genre-skills/xianshi-skill/
- 加载时间：2026-05-12
- 加载模式：**旧格式兼容模式**
- 当前状态：**已锁定**

---

## 已读取文件

| 文件 | 映射目标 | 状态 |
|------|----------|------|
| SKILL.md | 题材总说明 | 已读取 |
| outline-method.md | 结构规则 + 人物规则（合并读取） | 已读取 |
| output-style.md | 风格规则 + 对白规则（合并读取） | 已读取 |
| templates/outline-template.md | 大纲模板 | 可用 |
| templates/character-template.md | 人物模板 | 可用 |
| templates/chapter-index-template.md | 章节目录模板 | 可用 |
| templates/chapter-template.md | 章节模板 | 可用 |
| examples/outline-example.md | 大纲示例 | 可用 |
| examples/character-example.md | 人物示例 | 可用 |
| examples/chapter-example.md | 章节示例 | 可用 |

---

## 映射关系

```
旧格式文件                   →  合约接口
─────────────────────────────────────────────
SKILL.md                     →  题材总说明（直接读取）
outline-method.md            →  structure-rules   （结构规则）
                             →  character-rules   （人物规则）
output-style.md              →  style-guide        （风格规则）
                             →  dialogue-rules     （对白规则）
templates/                   →  templates/          （输出模板）
examples/                    →  examples/           （示例参考）
```

---

## 缺失文件

以下 7 个推荐标准文件在当前 Skill 中不存在：

| # | 缺失文件 | 影响 |
|---|----------|------|
| 1 | genre-profile.md | 题材定位信息从 SKILL.md 提取 |
| 2 | style-guide.md | 由 output-style.md 合并覆盖 |
| 3 | structure-rules.md | 由 outline-method.md 合并覆盖 |
| 4 | character-rules.md | 由 outline-method.md 合并覆盖 |
| 5 | dialogue-rules.md | 由 output-style.md 合并覆盖 |
| 6 | taboo.md | 不执行题材专属禁忌审查 |
| 7 | review-rubric.md | 题材审查使用降级模式 |

---

## 降级策略

1. **taboo.md 缺失**：不执行题材专属禁忌审查，但仍执行通用安全、逻辑、连续性审查。
2. **review-rubric.md 缺失**：题材审查时，genre-reviewer 基于 SKILL.md、outline-method.md、output-style.md 推断审查标准，标注"降级审查"。
3. **genre-profile.md 缺失**：从 SKILL.md 的 YAML frontmatter（name + description）和正文提取题材定位信息。
4. **style-guide / structure-rules / character-rules / dialogue-rules 缺失**：由旧格式文件合并覆盖，不视为功能缺口。

---

## 锁定声明

- 本项目已锁定题材为 **xianshi-skill**。
- 同一项目不允许中途切换题材 Skill。
- 如需切换题材，必须新建项目或用户明确确认放弃当前项目。
