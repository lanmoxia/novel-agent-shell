# stop-gate 锁稿优先级修复报告

- 修复时间：2026-05-12
- 修复类型：判断顺序修正
- 修复范围：`.claude/hooks/stop-gate.sh`
- 修复状态：**已完成**

---

## 一、问题

修复前 stop-gate.sh 的判断顺序为：

```
1. 正文生成中 → 只提醒，continue（跳过后续所有检查）
2. 已锁稿但无 final-review.md → 阻断
3. ...
```

如果 `locked/FINAL-SCRIPT.md` 存在但 `SCRIPT-STATUS.md` 仍标记为"正文生成中"，锁稿检查永不执行——因为它被第 1 步的 `continue` 跳过了。可以伪造一个"正文生成中"的 SCRIPT-STATUS.md 来绕过锁稿门禁。

---

## 二、修复后判断顺序

```
1. locked/FINAL-SCRIPT.md 存在？（最高优先级，先于任何 SCRIPT-STATUS.md 判断）
   ├─ 无 final-review.md → 阻断
   └─ final-review.md 是占位/不完整 → 阻断

2. scripts/ 有内容？
   ├─ SCRIPT-STATUS.md 含"正文生成中" → 只提醒，不阻断
   ├─ 无 SCRIPT-STATUS.md → 只提醒，不阻断
   ├─ SCRIPT-STATUS.md 含"待正式审查"/"全部章节已完成"/"待审查"
   │   ├─ 无 final-review.md → 阻断
   │   ├─ final-review.md 占位/不完整 → 阻断
   │   └─ 有效且最新 → 放行
   └─ final-review.md 含"不通过"且无 revision-log.md → 阻断
```

---

## 三、关键变更

| 变更 | 说明 |
|------|------|
| 锁稿检查移到最前 | 先于 scripts/ 检查，先于"正文生成中"跳过 |
| 锁稿也检查占位 | locked/FINAL-SCRIPT.md 存在时，final-review.md 的占位关键词也会触发阻断 |
| "正文生成中"降级为第 2 优先 | 仅在确认无锁稿异常后才生效 |

---

## 四、约束校验

| # | 约束项 | 状态 |
|---|--------|------|
| 1 | 仅修改 stop-gate.sh | ✓ |
| 2 | 未修改 SCRIPT-STATUS.md | ✓ |
| 3 | 未生成 E02 | ✓ |
| 4 | 未生成审查报告 | ✓ |
| 5 | 未进入 script-review | ✓ |
| 6 | 未修改 STORY-SPEC.md / OUTLINE.md / E01-名单.md | ✓ |
