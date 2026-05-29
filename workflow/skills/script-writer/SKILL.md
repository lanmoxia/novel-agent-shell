---
name: script-writer
description: 基于已确认的大纲、项目记忆和倒推规划写正文。必须读取 GENRE-SKILL-LOCK.md、PROJECT-MEMORY.md、planning 文件和相关题材风格文件。只能写当前请求的章节、集数或场次，不能一次性无控制生成全部内容。
---

# script-writer

## 职责

基于已确认的 OUTLINE.md 逐章/逐集/逐场生成正文。

## 前置条件

- `projects/<project-name>/outlines/OUTLINE.md` 存在且状态为"已确认"
- `projects/<project-name>/GENRE-SKILL-LOCK.md` 存在
- `projects/<project-name>/PROJECT-MEMORY.md` 存在
- `projects/<project-name>/planning/REVERSE-OUTLINE.md` 存在且状态为"已确认"

## 工作流程

1. 读取 OUTLINE.md，确认当前要写的章节/集数
2. 读取 PROJECT-MEMORY.md，确认稳定事实、人物状态、时间线、道具和伏笔
3. 读取 planning/REVERSE-OUTLINE.md、FORESHADOW-LEDGER.md、REVEAL-SCHEDULE.md，确认当前章节/集的功能和信息边界
4. 读取 GENRE-SKILL-LOCK.md，获取以下关键信息：
   - 加载模式（新格式 / 旧格式兼容模式）
   - 已读取文件列表和映射关系
   - 缺失文件和降级策略
5. 根据加载模式读取题材 Skill 文件：

   **新格式模式**（标准合约）：
   - style-guide.md（文风要求）
   - dialogue-rules.md（对白规则）
   - taboo.md（禁忌约束）
   - structure-rules.md（结构规则）
   - character-rules.md（人物规则）

   **旧格式兼容模式**（简化结构）：
   - genre-skills/<skill-name>/SKILL.md（题材总说明和触发条件）
   - genre-skills/<skill-name>/outline-method.md（结构、人物、节奏规则）
   - genre-skills/<skill-name>/output-style.md（文风、语言、对白规则）
   - 不得强行寻找 style-guide.md、dialogue-rules.md、taboo.md

6. 题材规则映射（旧格式兼容模式）：

   | 旧格式文件 | 提供规则 |
   |-----------|----------|
   | SKILL.md | 题材总说明、创作流程、触发条件 |
   | outline-method.md | 结构规则、人物规则、节奏规则、冲突设计、伏笔管理 |
   | output-style.md | 文风规则、语言风格、对白规则、句式要求 |

   taboo.md 缺失时：不执行题材专属禁忌审查，但仍执行通用安全、逻辑、连续性检查。

7. 读取上一章节/集的内容（如果是续写）
8. 按作品类型生成对应格式：
   - 小说 → 章节正文
   - 剧本 → 场次正文（含场景描述、对白、动作指示）
   - 短剧剧本 → 短场次正文（更紧凑）
9. 写入 `scripts/E##-标题.md`
10. 更新 SCRIPT-STATUS.md
11. 更新 PROJECT-MEMORY.md、FORESHADOW-LEDGER.md 和 REVEAL-SCHEDULE.md 中与当前章节/集有关的新增事实、信息释放和伏笔状态

## 输出

```
projects/<project-name>/scripts/E##-标题.md
projects/<project-name>/scripts/SCRIPT-STATUS.md（更新）
```

## 内容格式要求

- 剧本格式：场景标题 + 场景描述 + 人物动作 + 对白
- 小说格式：章节标题 + 叙述正文
- 必须遵守题材 Skill 的风格和禁忌
- 每章/每集完成后标记进度

## 注意事项

- 一次只写当前请求的章节/集数
- 不允许一次性输出全剧
- 写新章节前先读前文，确保连续性
- 写正文前必须遵守倒推大纲和信息释放表，不得提前暴露被锁定的信息
- 写完后必须记录新增稳定事实；未确认灵感不得写入稳定事实
- 遇到题材禁忌内容时自动修正
- 不确定的风格问题标注出来供审查阶段处理
- **不得因为缺少 style-guide.md、dialogue-rules.md、taboo.md 就自行编造题材规则。旧格式 Skill 必须以 GENRE-SKILL-LOCK.md 中的映射为准。**
- **正文生成只能写当前指定章节，不允许一次性写完整作品。**
- **script-writer 不得创建 reviews/final-review.md。该文件只能由 Phase 5 script-review 生成。**
- **只生成部分章节时，应将 SCRIPT-STATUS.md 标为"正文生成中"。**
- **当全部计划章节已生成，但用户尚未明确确认进入 Phase 5 时，SCRIPT-STATUS.md 应标记为"正文已完成，待用户确认进入 Phase 5"。**
- **不得自动把状态改为"待正式审查"，除非用户明确说"进入 Phase 5 / 开始审查 / 执行 script-review"。**
- **不得为了停止会话而回退状态或伪造状态。**
- **只有全部计划章节生成完成，或用户明确要求单章审查时，才提示进入 script-review。**
