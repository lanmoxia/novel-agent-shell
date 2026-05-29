# 题材 Skill 锁定记录

- 项目名：gudai-skill-smoke-test
- 题材 Skill：gudai-skill
- Skill 路径：genre-skills/gudai-skill/
- 加载模式：**旧格式兼容模式**
- 状态：**已锁定**

---

## 已读取文件

| 文件 | 类型 | 内容概述 |
|------|------|----------|
| `SKILL.md` | 核心配置 | 题材总说明、创作流程、触发条件、执行流程、创作原则 |
| `outline-method.md` | 创作方法论 | 结构规则（起承转合）、人物规则、节奏规则、冲突设计、伏笔管理 |
| `output-style.md` | 写作风格 | 文风规则（文白相济）、语言风格、对白规则、句式要求 |
| `templates/` | 模板（4 个） | outline-template.md, character-template.md, chapter-index-template.md, chapter-template.md |
| `examples/` | 示例（3 个） | outline-example.md, character-example.md, chapter-example.md |

---

## 映射关系

| 题材功能 | 来源文件 |
|----------|----------|
| 题材总说明、创作能力定义、执行流程、触发条件 | SKILL.md |
| 大纲结构规则（起承转合）、人物塑造方法、爽点设计、冲突递进、伏笔管理 | outline-method.md |
| 文风规则（文白相济）、对白规则（含锋/礼称）、句式要求、意象复现 | output-style.md |
| 大纲文档格式 | templates/outline-template.md |
| 人物小传格式 | templates/character-template.md |
| 章节目录格式 | templates/chapter-index-template.md |
| 章节正文格式 | templates/chapter-template.md |
| 大纲参考示例 | examples/outline-example.md |
| 人物参考示例 | examples/character-example.md |
| 章节参考示例 | examples/chapter-example.md |

---

## 缺失标准合约文件

以下为标准合约接口文件，gudai-skill 当前未提供：

| 缺失文件 | 对应功能 | 影响 |
|----------|----------|------|
| `genre-profile.md` | 题材身份声明 | genre-loader 无法自动识别题材类型 |
| `style-guide.md` | 正式风格指南 | 风格规则分散在 output-style.md 和 outline-method.md 中 |
| `structure-rules.md` | 正式结构规则 | 结构规则在 outline-method.md 中，未独立 |
| `character-rules.md` | 正式人物规则 | 人物规则在 outline-method.md 中，未独立 |
| `dialogue-rules.md` | 正式对白规则 | 对白规则在 output-style.md 中，未独立 |
| `taboo.md` | 禁忌列表 | 禁忌散见于各文件，未集中定义 |
| `review-rubric.md` | 审查评分标准 | 题材符合度审查无专用评分标准 |

---

## 降级策略

由于 gudai-skill 为旧格式兼容模式，以下降级策略生效：

1. **不执行题材专属 taboo.md 禁忌审查**（文件不存在）
2. **仍执行通用安全、逻辑、连续性、题材符合度审查**
3. **题材审查基于现有文件推断**：genre-reviewer 将基于 SKILL.md、outline-method.md、output-style.md 中的规则进行审查
4. **无 review-rubric.md** 时，genre-reviewer 以降级模式运行，不执行精确评分

---

## 核心规则摘要（供后续 Phase 使用）

### 结构约束
- 短篇小说固定 5 章，起承转合结构
- 第 1 章（起）：权局与困境
- 第 2-3 章（承）：谋局与试探、拆局受阻
- 第 4 章（转）：证物翻盘
- 第 5 章（合）：成局与代价
- 每章 2000-3000 字

### 风格强制
- 文白相济：叙述端庄、对白简练含锋
- 礼制称谓准确
- 回目感章节标题

### 核心创作公式
```
古代权谋短篇 = 权力棋局 + 信息不对称 + 谋略与人心博弈 + 有代价的成局
```

### 关键禁止项（从各文件汇总）
- 现代口语对话
- 过度心理描写
- 忽略礼制逻辑
- 用巧合翻盘
- 突然的武力解决
- 空洞的忠义宣言
- 大团圆结局
- 悬空设定（神秘高手/天降异象）
- 过度解释动机

---

## 下一步门禁

用户确认 GENRE-SKILL-LOCK.md 后，才允许进入 Phase 2 故事企划。
