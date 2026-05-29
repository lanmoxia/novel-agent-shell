---
name: script-locker
description: 检查是否满足锁稿条件，确认所有审查通过，确认用户已明确同意锁稿，生成 FINAL-SCRIPT.md。用户说锁稿、定稿、锁定剧本、完成创作时使用。
---

# script-locker

## 职责

执行剧本锁定流程。

## 前置条件

- `projects/<project-name>/reviews/final-review.md` 存在且结论为"通过"
- `projects/<project-name>/revisions/revision-log.md` 存在（如有修订）
- `projects/<project-name>/PROJECT-MEMORY.md` 存在且已记录最终稳定事实
- 所有严重问题已修复

## 工作流程

1. 检查锁稿条件：
   - final-review.md 存在且结论为"通过"
   - 四类审查评分均不低于 3 分
   - 四类审查报告均存在
   - 如有修订，revision-log.md 完好
   - PROJECT-MEMORY.md 已更新到锁稿状态
2. 汇总所有正文文件（scripts/ 下的所有内容）
3. 生成 FINAL-SCRIPT.md（全剧合并版本）
4. 生成或提示生成 LOCK-MANIFEST.sha256
5. 标记后置模块状态为 locked=true
6. 等待用户明确确认"同意锁稿"
7. 锁定完成

## 输出

```
projects/<project-name>/locked/FINAL-SCRIPT.md
```

## FINAL-SCRIPT.md 模板

```markdown
# 最终剧本（已锁定）

- 项目名称：
- 题材：
- 锁稿时间：
- 总集/章数：
- 审查状态：全部通过

## 审查确认

- [ ] 结构审查通过
- [ ] 连续性审查通过
- [ ] 对白审查通过
- [ ] 题材符合度审查通过

---

（以下为全剧正文）
```

## 锁稿后的限制

- 锁稿后正文不可再修改
- 如需修改，必须新建修订版本
- 锁稿后 PROJECT-MEMORY.md 只能追加锁稿状态和后置模块事实，不得改写正文稳定事实
- 锁稿后才允许访问后置模块（分镜、Seedance 提示词）

## 注意事项

- 不要在没有用户明确确认的情况下锁稿
- 锁稿前必须确认所有审查通过
- 锁稿后告知用户后置模块可用
