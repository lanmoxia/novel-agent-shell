# 正片剧本状态

本文件用于记录短剧脚本草案、审查、修订和锁稿状态。不得用本文件绕过用户确认、阶段门禁或生产边界。

兼容锚点：本项目从 Phase 4 烟测草案推进而来；原始 `SMOKE-DRAFT.md` 仍是烟测草案来源记录。当前虽已完成 Phase 8 剧本文本锁稿，但烟测链路产物仍不是完整视频生产包；不是最终生产稿 不代表正式生产稿。

## 状态总览

| 项目 | 状态 | 备注 |
|---|---|---|
| 正片剧本状态 | Phase 8 剧本文本已锁定 | 锁稿文件为 `locked/FINAL-SCRIPT.md` |
| 原文映射表状态 | 已锁定为锁稿依据 | 依据 `outlines/OUTLINE.md`，未生成正式分镜 |
| 字幕方案状态 | 未生成正式字幕文件 | 当前不进入字幕生产 |
| 分镜草案状态 | 未生成正式分镜文件 | 当前不进入分镜或提示词测试 |
| 审查状态 | `reviews/final-review.md` 已生成 | P0=0，P1=0，P2=1 |
| 锁稿状态 | 已完成 Phase 8 锁稿 | 只锁定剧本文本资产 |
| 视频生产状态 | 未进入 | 不生成视频提示词、Seedance prompts、图像提示词或生产稿包 |

## 锁稿文件

- 锁稿审查报告：`reviews/final-review.md`
- 锁定剧本文本：`locked/FINAL-SCRIPT.md`
- 锁稿 manifest：`locked/LOCK-MANIFEST.sha256`
- Skill 锁定 manifest：`locked/SKILL-LOCK-MANIFEST.sha256`

## Phase 8 锁稿状态

- 状态：已完成 Phase 8 锁稿。
- 任务：`WENYAN-SMOKE-009-PHASE8-RUN`
- 锁稿范围：只锁定文言文教辅短剧剧本文本资产。
- 锁稿来源：`scripts/SMOKE-DRAFT.md`
- final-review 结论：允许锁稿。
- P0：0。
- P1：0。
- P2：1，教材版本、目标年级和最终时长仍需正式化前由用户确认。
- 剩余 P2：已接受为非阻塞项。

## 生产边界

- 未生成正式字幕文件。
- 未生成正式分镜文件。
- 未生成视频提示词。
- 未生成 Seedance prompts。
- 未生成 Seedance2.0 提示词。
- 未生成图像提示词。
- 未生成完整生产稿包。
- 未生成 `planning/REVERSE-OUTLINE.md`。
- 未生成 `planning/FORESHADOW-LEDGER.md`。
- 未生成 `planning/REVEAL-SCHEDULE.md`。

## 后续边界

当前主线剧本创作链路已完成锁稿。

后续如需测试分镜提示词、Seedance2.0 提示词或视频生产链路，应另开 Skill 或独立任务，不属于当前 `wenyan-skill` 剧本创作链路，不得自动进入。
