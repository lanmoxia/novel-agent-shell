# 题材 Skill 锁定记录

- 项目名：huanghe-minsu-horror-001
- 题材 Skill：huanghe-minsu-suspense-skill
- Skill 版本：1.0.0
- Skill 路径：genre-skills/huanghe-minsu-suspense-skill/
- 加载模式：新格式标准合约模式
- 是否需要旧格式降级：否
- 是否缺失文件：否
- 能力声明：SKILL.md 未显式声明 capabilities；根据标准合约文件推断能力
- 缺失能力：无（按文件存在情况推断）
- Skill 验收状态：已通过 Phase 0 → Phase 7 主流程验收（VALIDATION.md）
- 状态：已锁定
- 锁定时间：2026-05-14

---

## 已读取核心规则文件（12 个）

| 文件 | 用途 |
|------|------|
| SKILL.md | 入口文件，Skill 定位与调度规则 |
| genre-profile.md | 题材定位、核心气质、旧物均衡原则 |
| style-guide.md | 文风规则：写实、克制、土腥、压抑 |
| structure-rules.md | 结构规则：七阶段递进链 |
| character-rules.md | 人物规则：知情老人、河工、村民群像 |
| dialogue-rules.md | 对白规则：土、短、硬、避讳、沉默 |
| setting-rules.md | 场景规则：黄河故道、旧村、清淤现场等 |
| folklore-rules.md | 民俗规则：六类禁忌、禁止法术化 |
| suspense-rules.md | 悬疑规则：四层揭露、旧物递进 |
| props-rules.md | 道具规则：七类旧物库、四要素、去同质化 |
| taboo.md | 禁止项：十三类反向约束 |
| review-rubric.md | 审查标准：三级别审查、道具独特性判断 |

## 推断能力

| 能力 | 状态 | 依据 |
|------|------|------|
| supports_novel | true | SKILL.md 说明支持小说 |
| supports_script | true | SKILL.md 说明支持剧本 |
| supports_short_drama | true | SKILL.md 说明支持短剧剧本 |
| provides_style | true | style-guide.md |
| provides_structure | true | structure-rules.md |
| provides_character_rules | true | character-rules.md |
| provides_dialogue_rules | true | dialogue-rules.md |
| provides_review_rubric | true | review-rubric.md |
| provides_taboo | true | taboo.md |
| provides_examples | true | examples/ |

## references（6 个）

writing-style-reference.md / dialogue-reference.md / atmosphere-reference.md / folklore-reference.md / props-reference.md / pacing-reference.md

## templates（4 个）

story-spec-template.md / outline-template.md / script-template.md / character-template.md

## examples（3 个）

story-spec-example.md / outline-example.md / script-style-example.md

---

## 核心题材公式

旧地貌记忆 + 村庄禁忌 + 被污染的旧物 + 老人不敢明说的旧事 + 诅咒式后果 + 现实质感下的不可解释感

## 旧物原则

不把任何单一旧物或固定组合设为默认核心。每个新项目必须根据主题、旧事、人物关系和场景来源重新选择核心旧物。

## 结构递进链

日常旧村 → 异常旧物 → 村民避讳 → 旧事露头 → 禁忌被破 → 后果渗出 → 不可逆收束

---

## 下一步门禁

- 当前阶段：Phase 1（题材 Skill 加载）
- 当前状态：已锁定
- 下一步：**等待用户确认后进入 Phase 2 故事企划**
- 未确认前：不得生成 STORY-SPEC.md、大纲、正文、审查报告
