# 重写执行协议

## 适用范围

Phase 6 修订时，如果问题影响结构、连续性、人物动机、题材符合度或章节功能，应使用本协议。

## 执行步骤

1. 读取 `reviews/final-review.md` 和对应单项审查报告
2. 读取 `PROJECT-MEMORY.md`
3. 读取 `planning/ENDING-LOCK.md`、`planning/REVERSE-OUTLINE.md`、`planning/FORESHADOW-LEDGER.md`、`planning/REVEAL-SCHEDULE.md`
4. 判断处理方式：局部修补 / 重写候选 / 回到大纲
5. 修改正式正文前，保存受影响文件快照到 `revisions/snapshots/`
6. 对中等或严重问题，先生成候选稿到 `drafts/rewrite-candidates/`
7. 候选稿必须说明保留项、废弃项和重写目标
8. 用户确认后，才允许替换 `scripts/` 正式正文
9. 更新 `revisions/revision-log.md` 和 `PROJECT-MEMORY.md`
10. 对受影响范围复查

## 候选稿格式

```markdown
# 重写候选

- 项目名：
- 对应章节/集：
- 对应审查问题：
- 生成时间：
- 状态：候选 / 已采用 / 已废弃

## 保留项

## 废弃项

## 重写目标

## 候选正文

## 自检
```
