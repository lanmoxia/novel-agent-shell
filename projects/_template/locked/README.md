# locked/

此目录由 Phase 7 script-locker 生成锁稿文件。

## 预期文件

- `FINAL-SCRIPT.md` — 锁定剧本（含正文合集 + 审查修订摘要）
- `LOCK-MANIFEST.sha256` — 锁稿清单，用于检测锁稿后正文和最终稿是否变化
- `SKILL-LOCK-MANIFEST.sha256` — 题材 Skill 指纹清单，用于检测项目锁定后 Skill 是否漂移

## 门禁规则

- 未通过审查（final-review.md 不存在或存在严重问题未修复），不得锁稿。
- 如发生过修订，需 revision-log.md 存在且复查通过。
- 锁稿需用户明确确认，不得自动执行。
- 锁稿完成后运行 `scripts/update-lock-manifest.*` 生成清单。
- 题材 Skill 锁定后运行 `scripts/update-skill-lock-manifest.*` 生成 Skill 指纹清单。
