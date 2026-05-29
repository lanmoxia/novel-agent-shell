---
name: revision-fixer
description: 根据审查报告诊断并修订或生成重写候选。轻微问题可局部修补；中等或严重问题优先生成重写候选。修改正式正文前必须保存快照，修完必须回到 script-review 复查并记录 revision-log.md。
---

# revision-fixer

## 职责

根据审查报告中的问题逐类诊断，选择局部修补、重写候选或回到规划。

## 前置条件

- `projects/<project-name>/reviews/final-review.md` 存在
- 审查结论为"不通过"或"有条件通过"

## 工作流程

1. 读取 final-review.md，获取问题列表
2. 读取 PROJECT-MEMORY.md 和 planning 文件，确认稳定事实、倒推链、伏笔和信息释放
3. 按用户选择的修订范围排序修订：A 仅严重 / B 严重+中等 / C 全部；不得超出用户选择范围
4. 按类别分批诊断：一次只处理一类问题
5. 对每类问题：
   - 定位问题出现的具体位置
   - 读取相关原文
   - 判断处理方式：局部修补 / 重写候选 / 回到规划
   - 修改正式正文前保存快照到 `revisions/snapshots/`
   - 轻微问题可局部修补并更新对应文件
   - 中等或严重问题优先生成 `drafts/rewrite-candidates/` 候选稿，等待用户确认后才替换正式正文
6. 记录修订日志到 `revision-log.md`
7. 更新 PROJECT-MEMORY.md 的审查与修订记忆
8. 每类问题修完或候选被采用后，触发 script-review 复查该类问题
9. 所选范围的问题处理完后，触发对应范围复查；是否继续修订其他问题，必须等待用户再次确认

## 输出

```
projects/<project-name>/revisions/revision-log.md
projects/<project-name>/scripts/E##-标题.md（修订后）
projects/<project-name>/revisions/snapshots/（修订前快照）
projects/<project-name>/drafts/rewrite-candidates/（重写候选稿）
```

## revision-log.md 模板

```markdown
# 修订日志

- 项目名称：
- 修订开始时间：
- 修订次数：

## 修订记录

### 修订 #1
- 时间：
- 修订类别：（结构 / 连续性 / 对白 / 题材）
- 问题位置：
- 原文摘要：
- 修改内容：
- 修改后审查结果：

### 修订 #2
...
```

## Phase 6 入口门禁规则

revision-fixer 只能在以下条件全部满足时启动：

1. **用户已明确确认进入 Phase 6**：不得在用户未确认的情况下自动启动
2. **用户已明确选择修订范围**：必须由用户选择 A（仅严重）/ B（严重+中等）/ C（全部），不得自行默认
3. **不得因 stop-gate 阻断而自动修订**：stop-gate 的阻断是提醒机制，修订必须由用户主动发起

如果用户未选择修订范围，必须停止并询问，提供以下选项：
- A：仅修复严重问题
- B：修复严重 + 中等问题
- C：全部修复（严重 + 中等 + 轻微）

## 修订完成后规则

- 必须写入 revision-log.md，记录每次修订的类别、位置、内容、复查结果
- **不得自动锁稿**：修订完成后必须等待用户明确确认，才能进入 Phase 7
- 更新 SCRIPT-STATUS.md 为 `Phase 6 修订 #N 已完成，待用户决定继续修订或进入 Phase 7`

## 注意事项

- 一次只修一类问题，不要混合修订
- 每类问题修完后必须复查
- 修订时保持文风和风格一致
- 不得无诊断直接覆盖正式正文
- 中等或严重问题优先生成候选稿；用户确认前不得替换正式正文
- 重写候选必须说明保留项、废弃项、重写目标和对应审查问题
- 替换正式正文后必须更新 PROJECT-MEMORY.md、伏笔表和信息释放表
- 不确定的修改标注出来
- 不得在用户选择 A 时继续修订中等或轻微问题；不得在用户选择 B 时继续修订轻微问题
