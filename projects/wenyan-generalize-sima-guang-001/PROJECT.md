# 《司马光》文言文教辅真人古风短剧泛化测试

本文件最初用于 `WENYAN-GENERALIZE-001-RUN` 的 Phase 0-4 项目建档与边界记录。本轮按 `WENYAN-GENERALIZE-005-PHASE8-RUN` 做最小一致性修正，仅更新阶段、锁稿边界和剩余 P2 说明，不改剧情结构。

## 基本信息

- 项目名称：《司马光》文言文教辅真人古风短剧泛化测试
- 项目目录：`projects/wenyan-generalize-sima-guang-001/`
- 项目类型：`edu-shortdrama`
- Skill：`wenyan-skill`
- Skill 版本：`0.1.0`
- 测试类型：第二篇文言文泛化测试
- 测试文本：《司马光》
- 当前阶段：Phase 8 剧本文本锁稿
- 当前状态：`phase8_locked`
- 锁稿资产：`locked/FINAL-SCRIPT.md`

## 测试目标

本项目用于验证 `wenyan-skill` 能否从《两小儿辩日》的争辩型 / 观点证据型结构，泛化到《司马光》的事件危机型 / 行动解困型结构。

本项目已完成第二篇不同结构样本的剧本文本锁稿验证；仍不验证分镜、Seedance2.0、视频生产、正式字幕或生产稿包。

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

- 已完成 Phase 8 剧本文本锁稿。
- 已生成 `reviews/final-review.md`。
- 已生成 `locked/FINAL-SCRIPT.md`。
- 已生成锁稿 manifest。
- 不生成正式字幕。
- 不生成正式分镜。
- 不生成 Seedance prompts 或 Seedance2.0 prompt。
- 不生成视频提示词、图像提示词或生产稿包。
- 不修改《两小儿辩日》已锁稿资产。

## Phase 8 锁稿资产

本轮 Phase 8 锁稿资产包括：

- `reviews/final-review.md`
- `locked/FINAL-SCRIPT.md`
- `locked/LOCK-MANIFEST.sha256`
- `locked/SKILL-LOCK-MANIFEST.sha256`

## Phase 4 基础产物

Phase 4 基础产物包括：

- `materials/SOURCE-TEXT.md`
- `specs/STORY-SPEC.md`
- `planning/ENDING-LOCK.md`
- `outlines/OUTLINE.md`
- `scripts/SCRIPT-STATUS.md`
- `scripts/SMOKE-DRAFT.md`
- `PROJECT-MEMORY.md`
- `RUN-LOG.md`

## 用户确认状态

- 确认状态：用户已确认执行 `WENYAN-GENERALIZE-005-PHASE8-RUN`
- 确认范围：执行《司马光》剧本文本锁稿，生成 final-review、FINAL-SCRIPT 和 manifest
- 确认时间：2026-05-30
- 备注：本项目已完成第二篇泛化样本剧本文本锁稿，不代表 `wenyan-skill` 已完成全部文言文类型泛化验证，也不代表视频生产链路启动。

## 剩余 P2

- 教材版本待确认。
- 目标年级待确认。
- 最终时长待确认。
- 原文采用版本正式化前待确认。
