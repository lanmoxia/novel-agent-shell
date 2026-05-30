# 《司马光》文言文教辅真人古风短剧泛化测试

本文件用于 `WENYAN-GENERALIZE-001-RUN` 的 Phase 0-4 项目建档与边界记录。

## 基本信息

- 项目名称：《司马光》文言文教辅真人古风短剧泛化测试
- 项目目录：`projects/wenyan-generalize-sima-guang-001/`
- 项目类型：`edu-shortdrama`
- Skill：`wenyan-skill`
- Skill 版本：`0.1.0`
- 测试类型：第二篇文言文泛化测试
- 测试文本：《司马光》
- 当前阶段：Phase 4 烟测草案
- 当前状态：`phase4_smoke_draft`

## 测试目标

本项目用于验证 `wenyan-skill` 能否从《两小儿辩日》的争辩型 / 观点证据型结构，泛化到《司马光》的事件危机型 / 行动解困型结构。

本轮只验证剧本创作链路到 Phase 4 烟测草案，不验证分镜、Seedance2.0、视频生产、正式字幕或生产稿包。

## 本轮默认原文

```text
群儿戏于庭，一儿登瓮，足跌没水中。众皆弃去，光持石击瓮破之，水迸，儿得活。
```

说明：该文本作为本轮烟测默认文本使用。教材版本、目标年级、原文采用版本和正式出处仍为 P2 待确认项。

## 结构定位

《司马光》不应套用《两小儿辩日》的争辩型结构。

本轮采用事件危机型 / 行动解困型结构：

```text
入古境
→ 见孩童游戏
→ 突发坠瓮危机
→ 众人惊慌
→ 司马光判断
→ 击瓮救人
→ 回扣原文
→ 明方法与品质
```

## 当前边界

- 不锁稿。
- 不进入 Phase 5 教学与生产审查。
- 不进入 Phase 6 修订。
- 不进入 Phase 7 锁稿前审查。
- 不进入 Phase 8 锁稿。
- 不生成 `reviews/final-review.md`。
- 不生成 `locked/FINAL-SCRIPT.md`。
- 不生成锁稿 manifest。
- 不生成正式字幕。
- 不生成正式分镜。
- 不生成 Seedance prompts 或 Seedance2.0 prompt。
- 不生成视频提示词、图像提示词或生产稿包。
- 不修改《两小儿辩日》已锁稿资产。

## Phase 4 产物

本轮 Phase 4 产物包括：

- `materials/SOURCE-TEXT.md`
- `specs/STORY-SPEC.md`
- `planning/ENDING-LOCK.md`
- `outlines/OUTLINE.md`
- `scripts/SCRIPT-STATUS.md`
- `scripts/SMOKE-DRAFT.md`
- `PROJECT-MEMORY.md`
- `RUN-LOG.md`

## 用户确认状态

- 确认状态：用户已确认执行 `WENYAN-GENERALIZE-001-RUN`
- 确认范围：创建《司马光》泛化测试项目并推进到 Phase 4 烟测草案
- 确认时间：2026-05-29
- 备注：本项目当前不是正式生产项目，不代表 `wenyan-skill` 已完成全部泛化验证。
