# Phase 4 完成后等待审查状态修复报告

- 修复时间：2026-05-12
- 修复类型：状态字段新增 + stop-gate 匹配规则
- 修复状态：**已完成**

---

## 一、问题

E01-E05 已全部生成，此时 SCRIPT-STATUS.md 只有两种旧状态可用：

- "正文生成中" — 不符合实际（正文已写完）
- "待正式审查" — 会被 stop-gate 阻断（要求已有 final-review.md）

缺少一种中间状态：正文写完了，但用户还没说"进入 Phase 5"。

---

## 二、新增状态

| 状态值 | 含义 | stop-gate 行为 |
|--------|------|---------------|
| `正文已完成，待用户确认进入 Phase 5` | 全部章节已生成，等待用户确认进入审查 | **仅提醒，不阻断（exit 0）** |

---

## 三、修改清单

| # | 文件 | 修改内容 |
|---|------|----------|
| 1 | `scripts/SCRIPT-STATUS.md` | 状态：→ `正文已完成，待用户确认进入 Phase 5` |
| 2 | `scripts/SCRIPT-STATUS.md` | 门禁提示：替换为 8 条精确规则 |
| 3 | `.claude/hooks/stop-gate.sh` | 新增情况 2：`待用户确认进入 Phase 5` → 提醒不阻断 |
| 4 | `.claude/hooks/stop-gate.sh` | 情况编号重排（1→6，其中 2 是新增） |
| 5 | `.claude/skills/script-writer/SKILL.md` | 新增 4 条注意事项，细化状态标记规则 |

---

## 四、stop-gate 新判断顺序

```
1. locked/FINAL-SCRIPT.md 存在？→ 优先校验锁稿（阻断 or not）
2. "待用户确认进入 Phase 5" → 仅提醒，continue
3. "正文生成中"              → 仅提醒，continue
4. 无 SCRIPT-STATUS.md        → 仅提醒，continue
5. "待正式审查"/"待审查"        → 无有效 final-review.md → 阻断
6. final-review.md 含"不通过"  → 无 revision-log.md → 阻断
```

---

## 五、script-writer 新增规则

1. 全部章节生成但用户未确认 → 标为 `正文已完成，待用户确认进入 Phase 5`
2. 不得自动改为"待正式审查"
3. 不得为停止回退或伪造状态

---

## 六、约束校验

| # | 约束项 | 状态 |
|---|--------|------|
| 1 | 未修改 E01-E05 正文 | ✓ |
| 2 | 未生成审查报告 | ✓ |
| 3 | 未进入 script-review | ✓ |
| 4 | 未生成 final-review.md | ✓ |
| 5 | 未修改 STORY-SPEC.md | ✓ |
| 6 | 未修改 OUTLINE.md | ✓ |
| 7 | 未修改 genre-skills/ | ✓ |

---

## 七、状态流转全图

```
生成中（部分章节）
  │
  ▼
正文已完成，待用户确认进入 Phase 5  ← 当前 test-xianshi-demo
  │  （用户说"进入 Phase 5"）
  ▼
待正式审查
  │  （script-review 完成）
  ▼
final-review.md 生成 → 通过 / 不通过
```
