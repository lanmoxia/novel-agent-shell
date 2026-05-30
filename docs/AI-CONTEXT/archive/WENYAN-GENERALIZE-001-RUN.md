# WENYAN-GENERALIZE-001-RUN：《司马光》第二篇文言文泛化测试执行记录

- 任务编号：WENYAN-GENERALIZE-001-RUN
- 任务名称：《司马光》第二篇文言文泛化测试执行，推进到 Phase 4 烟测草案
- 完成日期：2026-05-29
- 状态：已完成 Phase 4 烟测草案，未进入 Phase 5/6/7/8

## 1. 本轮任务背景

本轮基于 `WENYAN-GENERALIZE-001-PLAN` 执行第二篇文言文泛化测试。第一篇《两小儿辩日》已经完成 Phase 8 剧本文本锁稿，并通过 `WENYAN-SMOKE-010-SCRIPT-CREATION-BOUNDARY-FREEZE` 冻结边界。

本轮目标不是继续第一篇锁稿项目，也不是进入视频生产链路，而是创建《司马光》泛化测试项目，并推进到 Phase 4 烟测草案。

## 2. 为什么执行《司马光》泛化测试

《两小儿辩日》验证的是争辩型 / 观点证据型文言文结构。《司马光》属于事件危机型 / 行动解困型文言文。

本轮执行《司马光》测试，是为了验证 `wenyan-skill` 是否能从：

```text
入古境
→ 见事件
→ 起争辩
→ 摆观点
→ 举证据
→ 难判断
→ 回原文
→ 明主题
```

泛化到：

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

## 3. 创建的项目目录

本轮创建：

```text
projects/wenyan-generalize-sima-guang-001/
```

该目录是《司马光》第二篇文言文泛化测试项目，不是正式生产项目。

## 4. 创建的项目文件

本轮新增项目文件：

- `projects/wenyan-generalize-sima-guang-001/PROJECT.md`
- `projects/wenyan-generalize-sima-guang-001/PROJECT-STATE.json`
- `projects/wenyan-generalize-sima-guang-001/GENRE-SKILL-LOCK.md`
- `projects/wenyan-generalize-sima-guang-001/materials/SOURCE-TEXT.md`
- `projects/wenyan-generalize-sima-guang-001/specs/STORY-SPEC.md`
- `projects/wenyan-generalize-sima-guang-001/planning/ENDING-LOCK.md`
- `projects/wenyan-generalize-sima-guang-001/outlines/OUTLINE.md`
- `projects/wenyan-generalize-sima-guang-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-generalize-sima-guang-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-generalize-sima-guang-001/PROJECT-MEMORY.md`
- `projects/wenyan-generalize-sima-guang-001/RUN-LOG.md`
- `projects/wenyan-generalize-sima-guang-001/drafts/README.md`
- `projects/wenyan-generalize-sima-guang-001/locked/README.md`
- `projects/wenyan-generalize-sima-guang-001/reviews/README.md`
- `projects/wenyan-generalize-sima-guang-001/revisions/README.md`
- `projects/wenyan-generalize-sima-guang-001/short-drama-shotlists/README.md`
- `projects/wenyan-generalize-sima-guang-001/seedance-prompts/README.md`

## 5. Phase 4 结果

`PROJECT-STATE.json` 当前记录：

- `phase: 4`
- `status: phase4_smoke_draft`
- `locked: false`
- `scriptStatus: phase4_smoke_draft`
- `reviewStatus: not_started`
- `productionPackageStatus: not_generated`
- `videoStatus: not_started`
- `seedancePromptStatus: not_started`
- `shotlistStatus: not_generated`

`scripts/SMOKE-DRAFT.md` 已生成 Phase 4 烟测草案。草案采用 5 个 Scene：

1. S01 庭中游戏：绑定“群儿戏于庭”。
2. S02 失足坠瓮：绑定“一儿登瓮，足跌没水中”。
3. S03 众人惊慌：绑定“众皆弃去”。
4. S04 击瓮救人：绑定“光持石击瓮破之”。
5. S05 水出人活：绑定“水迸，儿得活”。

该草案体现事件危机型 / 行动解困型结构，没有机械套用《两小儿辩日》的争辩型 / 观点证据型结构。

## 6. 本轮没有进入的阶段

本轮没有进入：

- Phase 5 教学与生产审查。
- Phase 6 修订。
- Phase 7 锁稿前审查。
- Phase 8 锁稿。

本轮未生成 `reviews/final-review.md`。

## 7. 本轮没有生成的视频链路内容

本轮没有生成：

- `locked/FINAL-SCRIPT.md`
- `locked/LOCK-MANIFEST.sha256`
- `locked/SKILL-LOCK-MANIFEST.sha256`
- 正式字幕文件
- 正式分镜文件
- Seedance prompts
- Seedance2.0 prompt
- 视频提示词
- 图像提示词
- 完整生产稿包

`short-drama-shotlists/` 和 `seedance-prompts/` 仅包含 README 边界说明，不包含正式后置生产内容。

## 8. 当前剩余 P2

当前剩余 P2：

1. 教材版本待确认。
2. 目标年级待确认。
3. 最终时长待确认。
4. 原文采用版本正式化前待确认。
5. 是否使用统编版常见文本待确认。
6. 真人古风短剧风格强度待确认。
7. 输出侧重点待确认：课堂导入、故事演绎，或记忆辅助。

这些 P2 不阻塞本轮 Phase 4 烟测草案，但会影响后续审查、修订和正式化。

## 9. 本轮边界自检

- 已创建《司马光》项目目录。
- 已推进到 Phase 4 烟测草案。
- 未进入 Phase 5/6/7/8。
- 未锁稿。
- 未生成 manifest。
- 未生成分镜、Seedance prompt、视频提示词、字幕或生产稿包。
- 未修改《两小儿辩日》锁稿资产。
- 未修改 `wenyan-skill`、workflow、scripts 或模板。
- 已记录原文、白话释义、教学点、学习闭环和剩余 P2。

## 10. 校验结果

本轮校验结果：

- `git diff --check`：通过。
- `git status --short`：仅包含本轮允许新增 / 修改文件。
- `bash scripts/validate-edu-shortdrama-project.sh projects/wenyan-generalize-sima-guang-001`：首轮因 `specs/STORY-SPEC.md` 缺少“不可改写事实”语义锚点失败；已在本轮新增文件内修复，复跑通过，0 error / 0 warning。
- `bash scripts/validate-shell.sh`：通过，0 error / 0 warning。

## 11. 下一步建议

下一步候选：

```text
WENYAN-GENERALIZE-002-PHASE5-REVIEW：对《司马光》Phase 4 烟测草案进行教学与生产审查
```

不得自动进入下一步，必须等待用户明确确认。

其他候选方向：

- `WENYAN-GENERALIZE-001-REVISION`：如 Phase 4 草案存在明显问题，先做轻量修订。
- `VIDEO-SKILL-001-PLAN`：规划分镜 / Seedance2.0 后置 Skill。
- `CLEANUP-001-AUDIT`：只读仓库清理审计。
