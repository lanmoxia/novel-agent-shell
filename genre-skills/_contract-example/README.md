# 题材 Skill 合约示例

此目录展示一个标准题材 Skill 应包含的文件结构。

## 示例：example-skill

```
example-skill/
├── SKILL.md              → "这是一个示例题材 Skill，用于演示标准接口"
├── genre-profile.md      → 题材定位、世界观说明
├── style-guide.md        → 文风规则
├── structure-rules.md    → 结构规则
├── character-rules.md    → 人物规则
├── dialogue-rules.md     → 对白规则
├── taboo.md              → 禁忌约束
├── review-rubric.md      → 审查评分标准
├── templates/            → 输出模板（可选）
└── examples/             → 示例（可选）
```

## 最简 Skill

最低要求只有一个 SKILL.md：

```markdown
---
name: my-skill
description: 我的题材说明
---

# 题材总说明

（题材的定位、核心规则、风格要求等）
```

genre-loader 会识别这个 Skill，并标注所有缺失的推荐文件。

## 参考

- 完整合约见 `docs/GENRE-SKILL-CONTRACT.md`
- 旧格式兼容见合约第 3 节
