# Phase 5 → Phase 6 用户确认门禁修复报告

- 修复时间：2026-05-12
- 涉及项目：test-xianshi-demo
- 触发原因：Phase 5 审查完成后，系统缺少用户确认门禁，存在自动跳入 Phase 6 修订的风险

---

## 发现的问题

### 问题 1：stop-gate.sh 缺少 Phase 6 非阻断等待状态

stop-gate.sh 已有 Phase 5 等待状态（"待用户确认进入 Phase 5"）和"正文生成中"的非阻断处理，但没有针对 Phase 6 等待用户决策状态的对应处理。

当 SCRIPT-STATUS.md 状态为"Phase 6 修订 #1 已完成，待用户决定继续修订或进入 Phase 7"时，该状态会滑过所有匹配条件，不会发出任何提醒。

### 问题 2：script-review 可自动调用 revision-fixer

script-review/SKILL.md 没有规定审查完成后必须等待用户确认才能进入修订。存在 script-review 完成后自动触发 revision-fixer 的风险。

### 问题 3：revision-fixer 可自动选择修订范围

revision-fixer/SKILL.md 写的是"按优先级排序修订顺序：严重 > 中等 > 轻微"，即默认全量修订。没有要求用户明确选择修订范围的门禁步骤。存在用户只想修严重问题、但系统自动修了全部问题的风险。

### 问题 4：为什么不能让 stop-gate 推动自动修订

stop-gate 的阻断机制是在会话**停止时**触发的，目的是提醒用户未完成的工作。如果因为 stop-gate 阻断而自动进入 revision-fixer，会导致：
- 用户在不知情的情况下进入修订
- 用户失去对修订范围的选择权
- 可能在用户不想修订时强制修订

stop-gate 的正确用途是**提醒和阻断**，修订必须由用户主动发起。

---

## 修改的文件

### 1. `.claude/hooks/stop-gate.sh`

- 新增情况 4：Phase 6 等待用户决策 → 仅提醒，不阻断
- 匹配模式：`待用户确认进入 Phase 6` 或 `待用户决定继续修订或进入 Phase 7`
- 原情况 4/5/6 重新编号为 5/6/7
- 保留所有原有阻断逻辑

### 2. `.claude/skills/script-review/SKILL.md`

- 新增 "Phase 5 → Phase 6 门禁规则" 章节
- 规定审查完成后 SCRIPT-STATUS.md 必须写为"审查完成，待用户确认进入 Phase 6"
- 规定不得自动调用 revision-fixer、不得自动修改正文
- 规定必须提供 A/B/C 修订范围选项，但不能代替用户选择

### 3. `.claude/skills/revision-fixer/SKILL.md`

- 新增 "Phase 6 入口门禁规则" 章节
- 规定只能在用户明确确认进入 Phase 6 且明确选择修订范围后才能启动
- 规定不得因 stop-gate 阻断而自动修订
- 新增 "修订完成后规则" 章节：必须写入 revision-log.md、不得自动锁稿、更新 SCRIPT-STATUS.md

### 4. `projects/test-xianshi-demo/scripts/SCRIPT-STATUS.md`

- 当前状态更新为：`Phase 6 修订 #1 已完成，待用户决定继续修订或进入 Phase 7`
- 下一步更新为：`用户选择 → 继续修复中等问题（Phase 6 修订 #2），或确认进入 Phase 7 锁稿`
- 保留所有审查结果摘要和门禁提示

### 5. `projects/test-xianshi-demo/reviews/final-review.md`

- 在文件末尾追加"修订后状态更新"章节
- 记录严重问题 #1/#2/#3 已修复、continuity-reviewer 复查通过
- 记录剩余 10 个中等问题和 16 个轻微问题
- 明确是否允许锁稿需用户确认

### 6. `docs/PHASE-5-TO-PHASE-6-GATE-FIX-REPORT.md`（本文件）

- 新建，记录本次门禁修复的完整信息

---

## 当前真实状态

- Phase：**Phase 6（修订中）**
- 修订次数：1 次
- 严重问题：0（已全部修复）
- 中等问题：10（未修复）
- 轻微问题：16（未修复）
- 审查报告：reviews/final-review.md（已追加修订后状态更新）
- 修订日志：revisions/revision-log.md（已记录修订 #1）

---

## 后续应由用户选择

当前项目 test-xianshi-demo 处于 Phase 6，3 个严重问题已修复，等待用户选择：

- **选项 A**：确认进入 Phase 7 锁稿（接受中等/轻微问题为非阻塞项）
- **选项 B**：继续 Phase 6 修订 #2，修复中等问题
- **选项 C**：继续 Phase 6 修订 #2，修复全部剩余问题

不得自动锁稿，不得自动修订。
