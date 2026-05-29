# Phase 4 stop-gate 与占位审查修复报告

- 修复时间：2026-05-12
- 修复类型：门禁逻辑修正 + 占位审查清理
- 修复状态：**已完成**

---

## 一、错误原因

上一个 Phase 4 会话中，为了绕过 stop-gate 的阻断，错误创建了占位 `final-review.md`。该文件不是由 script-review 生成的正式审查报告，违反了以下原则：

- final-review.md 只能由 Phase 5 script-review 生成
- 禁止通过占位文件绕过门禁
- stop-gate 应对"正文生成中"状态放行，而非一刀切阻断

---

## 二、修复清单

| # | 操作 | 文件 | 内容 |
|---|------|------|------|
| 1 | 删除 | `reviews/final-review.md` | 占位审查文件 |
| 2 | 重写 | `scripts/SCRIPT-STATUS.md` | 状态改为"正文生成中"，补充门禁规则 |
| 3 | 重写 | `.claude/hooks/stop-gate.sh` | 按 SCRIPT-STATUS.md 状态分级处理 |
| 4 | 追加 | `.claude/skills/script-writer/SKILL.md` | 3 条新规则 |
| 5 | 更新 | `docs/PHASE-4-SCRIPT-E01-TEST-REPORT.md` | 修正状态描述和结论 |

---

## 三、stop-gate 新逻辑

```
scripts/ 有内容？
  ├─ SCRIPT-STATUS.md 含"正文生成中" → 只提醒，不阻断（exit 0）
  ├─ 无 SCRIPT-STATUS.md 且无 final-review.md → 只提醒，不阻断（exit 0）
  ├─ SCRIPT-STATUS.md 含"待正式审查"/"全部章节已完成"/"待审查"
  │   ├─ final-review.md 不存在 → 阻断（exit 2）
  │   ├─ final-review.md 是占位/不完整 → 阻断（exit 2）
  │   └─ final-review.md 有效且最新 → 放行（exit 0）
  ├─ locked/FINAL-SCRIPT.md 存在但无 final-review.md → 阻断（exit 2）
  └─ final-review.md 含"不通过"且无 revision-log.md → 阻断（exit 2）
```

---

## 四、script-writer 新增规则（3 条）

1. **script-writer 不得创建 reviews/final-review.md。该文件只能由 Phase 5 script-review 生成。**
2. **只生成部分章节时，应将 SCRIPT-STATUS.md 标为"正文生成中"，而不是"待最终审查"。**
3. **只有全部计划章节生成完成，或用户明确要求单章审查时，才提示进入 script-review。**

---

## 五、SCRIPT-STATUS.md 新门禁提示

```markdown
- 当前仅完成 1/5 章，不允许生成 final-review.md。
- final-review.md 只能由 Phase 5 script-review 在用户明确进入审查阶段后生成。
- 未完成全部章节时，可以停止会话，但必须保留"正文生成中"状态。
```

---

## 六、约束校验

| # | 约束项 | 是否满足 |
|---|--------|----------|
| 1 | 删除占位 final-review.md | ✓ |
| 2 | 未生成新的审查报告 | ✓ |
| 3 | 未进入 script-review | ✓ |
| 4 | 未修改 E01-名单.md 正文 | ✓ |
| 5 | 未修改 STORY-SPEC.md | ✓ |
| 6 | 未修改 OUTLINE.md | ✓ |
| 7 | 未修改 genre-skills/ | ✓ |
| 8 | 未生成分镜或 Seedance 提示词 | ✓ |
