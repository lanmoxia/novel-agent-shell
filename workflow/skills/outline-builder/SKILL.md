---
name: outline-builder
description: 基于已确认的故事企划和结局锁定生成大纲、倒推大纲、伏笔表和信息释放表。根据作品类型决定输出结构，必须遵守题材 Skill 的结构规则，生成后等待用户确认。
---

# outline-builder

## 职责

基于已确认的 STORY-SPEC.md 和 ENDING-LOCK.md 生成结构化大纲，并从结局倒推章节/集功能。

## 前置条件

- `projects/<project-name>/specs/STORY-SPEC.md` 存在且状态为"已确认"
- `projects/<project-name>/planning/ENDING-LOCK.md` 存在且状态为"已确认"
- `projects/<project-name>/GENRE-SKILL-LOCK.md` 存在

## 工作流程

1. 读取 STORY-SPEC.md
2. 读取 planning/ENDING-LOCK.md，确认结局事实、核心真相和情绪落点
3. 读取 GENRE-SKILL-LOCK.md 中题材结构规则摘要
4. 按需读取题材 Skill 的 structure-rules.md
5. 根据作品类型决定输出结构：
   - 小说 → 章纲（每章标题 + 200-500 字梗概）
   - 剧本 → 集纲 / 场次节拍（每集标题 + 每场节拍）
   - 短剧剧本 → 集纲（节奏更快，每集 1-3 场）
6. 从终点倒推每章/集的表层事件、深层功能、信息释放和隐藏信息
7. 建立伏笔表和信息释放表
8. 更新 PROJECT-MEMORY.md 的倒推链、章节功能和伏笔状态
9. 生成 OUTLINE.md、REVERSE-OUTLINE.md、FORESHADOW-LEDGER.md、REVEAL-SCHEDULE.md
10. 等待用户确认

## 输出

```
projects/<project-name>/outlines/OUTLINE.md
projects/<project-name>/planning/REVERSE-OUTLINE.md
projects/<project-name>/planning/FORESHADOW-LEDGER.md
projects/<project-name>/planning/REVEAL-SCHEDULE.md
projects/<project-name>/PROJECT-MEMORY.md
```

## OUTLINE.md 模板

```markdown
# 大纲

- 项目名称：
- 作品类型：
- 总章/集数：
- 创建时间：
- 状态：待用户确认 / 已确认

## 整体结构

（三幕式/四幕式/章回体 等结构说明）

## 详细大纲

### 第一集/章：标题

- 核心事件：
- 人物出场：
- 冲突推进：
- 情感节点：
- 衔接点：

### 第二集/章：标题
...

## 关键节点检查

- [ ] 起承转合完整
- [ ] 冲突逐步升级
- [ ] 每集/章有独立闭环
- [ ] 人物弧线连贯
- [ ] 符合题材结构规则
```

## 注意事项

- 大纲阶段只输出节拍和梗概，不输出完整正文
- 大纲必须服务 ENDING-LOCK.md 中的结局、核心真相和情绪落点
- 每章/集必须说明表层事件和深层功能
- 必须记录哪些信息可以释放，哪些信息不可提前暴露
- 必须遵守题材 Skill 的结构规则
- 生成后必须等待用户确认
- 用户确认前不进入正文写作阶段
- **新生成的 OUTLINE.md 默认状态必须为待用户确认。用户明确确认后，才允许改为已确认。用户确认前不得进入 script-writer。**
