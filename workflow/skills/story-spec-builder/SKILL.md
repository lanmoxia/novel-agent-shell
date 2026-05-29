---
name: story-spec-builder
description: 基于项目档案和题材 Skill 锁定记录，生成故事企划文档，并锁定结局、核心真相、情绪落点和项目长期记忆。只读取必要题材文件，避免一次性塞入全部内容。
---

# story-spec-builder

## 职责

生成故事企划文档，将用户需求转化为结构化的创作蓝图，并为后续倒推大纲建立终点。

## 前置条件

- `projects/<project-name>/PROJECT.md` 存在
- `projects/<project-name>/GENRE-SKILL-LOCK.md` 存在且状态为"已锁定"

## 工作流程

1. 读取 PROJECT.md，了解项目基础信息
2. 读取 GENRE-SKILL-LOCK.md，了解题材约束摘要
3. 按需读取题材 Skill 的 genre-profile.md（题材定位和调性）
4. 与用户讨论以下内容：
   - 核心创意和一句话梗概
   - 主要人物和人物关系
   - 核心冲突和冲突升级路径
   - 故事调性和整体氛围
   - 结局方向和情绪落点
   - 核心真相、最终结局事实和不可提前暴露的信息
   - 题材特殊限制
5. 生成 STORY-SPEC.md 初稿
6. 生成 `planning/ENDING-LOCK.md` 初稿
7. 更新 `PROJECT-MEMORY.md` 的稳定事实、人物初始设定、结局、核心真相和题材禁忌
8. 等待用户确认
9. 根据反馈修改直到用户确认

## 输出

```
projects/<project-name>/specs/STORY-SPEC.md
projects/<project-name>/planning/ENDING-LOCK.md
projects/<project-name>/PROJECT-MEMORY.md
```

## STORY-SPEC.md 模板

```markdown
# 故事企划

- 项目名称：
- 题材：
- 创建时间：
- 状态：待用户确认 / 已确认

## 一句话梗概

（一句话说清故事的独特价值）

## 核心创意

（创意的独特之处，为何不同于同类作品）

## 主要人物

### 人物 A
- 姓名 / 身份：
- 性格特征：
- 核心欲望：
- 人物弧线：

### 人物 B
...

## 核心冲突

- 主要冲突：
- 冲突升级路径：
- 内在冲突 vs 外在冲突：

## 调性与氛围

- 整体调性：
- 叙事视角：
- 节奏预期：

## 结局方向

- 结局类型：
- 情感落点：
- 未解之谜（如有）：

## 终点锁定摘要

- 最终结局事实：
- 核心真相：
- 主角最终面对的问题：
- 不可提前暴露的信息：

## 题材限制

- 必须遵守的规则：
- 必须避免的禁忌：
```

## 注意事项

- 只读取必要的题材文件（优先读取 GENRE-SKILL-LOCK.md 摘要）
- 不要在企划阶段就要求完整大纲
- 短篇也必须锁定结局事实、核心真相和情绪落点
- 未确认的灵感不得写入 PROJECT-MEMORY.md 的稳定事实区
- 企划确认前不要进入大纲阶段
- **不得因测试项目而默认确认 STORY-SPEC.md。必须等待用户明确确认后，才能把状态改为已确认。**
