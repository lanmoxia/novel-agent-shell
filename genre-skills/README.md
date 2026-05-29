# 题材 Skill 插件目录

此目录用于放置题材 Skill 插件。

## 放置方式

每个题材 Skill 是一个独立的子目录：

```
genre-skills/<skill-name>/
├── SKILL.md                 # 必需
├── genre-profile.md         # 推荐
├── style-guide.md           # 推荐
├── structure-rules.md       # 推荐
├── character-rules.md       # 推荐
├── dialogue-rules.md        # 推荐
├── taboo.md                 # 推荐
├── review-rubric.md         # 推荐
├── templates/               # 可选
└── examples/                # 可选
```

## 兼容旧格式

也支持简化格式：

```
genre-skills/<skill-name>/
├── SKILL.md
├── outline-method.md
└── output-style.md
```

## 合约说明

详细接口合约见 `docs/GENRE-SKILL-CONTRACT.md`。

## 当前可用的题材 Skill

（用户放入题材 Skill 后，此列表由 genre-loader 自动识别）

## 创建新题材 Skill

1. 在 `genre-skills/` 下创建新目录
2. 至少创建 SKILL.md（包含 YAML frontmatter 的 name 和 description）
3. 按合约逐步添加推荐文件
4. 参考 `_contract-example/` 了解标准格式
