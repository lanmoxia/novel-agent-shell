# Phase 8 剧本文本锁稿审查报告：《司马光》

- 任务编号：WENYAN-GENERALIZE-005-PHASE8-RUN
- 项目：`projects/wenyan-generalize-sima-guang-001`
- 日期：2026-05-30
- 阶段：Phase 8 剧本文本锁稿
- 结论：允许剧本文本锁稿
- 残留：P0=0，P1=0，P2=4

## 1. 审查对象

本轮审查对象为：

- `projects/wenyan-generalize-sima-guang-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-generalize-sima-guang-001/reviews/phase7-prelock-review.md`
- `projects/wenyan-generalize-sima-guang-001/revisions/phase6-light-revision-notes.md`
- `projects/wenyan-generalize-sima-guang-001/reviews/phase5-teaching-production-review.md`
- `projects/wenyan-generalize-sima-guang-001/materials/SOURCE-TEXT.md`
- `projects/wenyan-generalize-sima-guang-001/specs/STORY-SPEC.md`
- `projects/wenyan-generalize-sima-guang-001/outlines/OUTLINE.md`

本轮只审查并锁定剧本文本，不进入分镜、正式字幕、Seedance2.0 prompt、视频提示词或生产稿包链路。

## 2. 当前阶段

当前阶段为 Phase 8 剧本文本锁稿。Phase 7 锁稿前审查已通过，Phase 8 计划已完成，用户已确认执行 Phase 8 Run。

本轮允许生成 `reviews/final-review.md`、`locked/FINAL-SCRIPT.md`、`locked/LOCK-MANIFEST.sha256` 和 `locked/SKILL-LOCK-MANIFEST.sha256`。

## 3. 锁稿结论

结论：允许《司马光》剧本文本锁稿。

- P0=0。
- P1=0。
- P2=4。
- 剩余 P2 均为正式化前待确认项，不阻塞剧本文本锁稿。
- 本轮只锁定剧本文本。
- 本轮不进入视频链路。
- 本轮不生成分镜、Seedance prompt、视频提示词、正式字幕或生产稿包。

《司马光》作为第二篇泛化样本完成剧本文本锁稿，说明 `wenyan-skill` 已完成第二篇不同结构样本的剧本创作链路锁稿验证；不得表述为所有文言文类型已完全验证，也不得表述为完整短剧生产链路完成。

## 4. P0 问题

无。

未发现原文理解错误、事件链背离、结构失败、无关故事化、危险恐怖化、成人化表达、仙侠玄幻化、锁稿资产越界生成、视频链路启动或其他明显边界违规。

## 5. P1 问题

无。

Phase 6 修订稿已经真实处理 Phase 5 的非确认类 P2，Phase 7 审查结论为可进入 Phase 8。当前没有阻断剧本文本锁稿的问题。

## 6. P2 问题

剩余 P2：

1. 教材版本待确认。
2. 目标年级待确认。
3. 最终时长待确认。
4. 原文采用版本正式化前待确认。

这些 P2 不阻塞剧本文本锁稿，但正式教材化、正式字幕化或视频生产前必须继续保留并由用户确认。

## 7. 原文理解最终审查

通过。

锁稿文本保留完整原文事件链：

1. 群儿戏于庭。
2. 一儿登瓮。
3. 足跌没水中。
4. 众皆弃去。
5. 光持石击瓮破之。
6. 水迸，儿得活。

未改写落水、击瓮、水出人活的核心事实，也未新增反派、阴谋、怪物、追杀或无关支线。

## 8. 结构泛化最终审查

通过。

锁稿文本采用事件危机型 / 行动解困型结构：

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

未机械套用《两小儿辩日》的争辩型 / 观点证据型结构。当前样本能证明 `wenyan-skill` 已完成第二篇不同结构样本的剧本创作链路锁稿验证。

## 9. 教学目标最终审查

通过。

锁稿文本继续服务以下教学目标：

- 学生能按事件顺序复述原文。
- 文言句与白话释义绑定清楚。
- 能理解“众皆弃去”是儿童惊慌，不是恶意逃避。
- 能理解“光持石击瓮破之”是换方法救人，不是莽撞破坏。
- 能理解司马光的冷静、判断和行动力。

## 10. 剧作表达最终审查

通过。

锁稿文本保留 Phase 6 的轻量修订成果：

- S01 用大瓮在侧和湿滑提示增强观看性。
- S02 危机触发清楚但不惊悚。
- S03 使用短促判断“水出去了，人就能出来。”
- S04 使用“砸瓮，让水走！”呈现儿童化临场行动。
- S05 从事件复述自然回扣原文和白话释义。

文本未新增新场次、新角色、新支线或新剧情结构。

## 11. 生产边界最终审查

通过。

本轮只锁定剧本文本。锁稿文本不是正式字幕文件、正式分镜文件、视频提示词、Seedance prompt、图像提示词或完整生产稿包。

生产约束继续保留：

- 单镜头主要互动人物不超过 3 个。
- 坠瓮、击瓮、水迸表达必须安全化。
- 不渲染血腥、恐怖、长时间溺水或危险模仿。
- 后续视频化风险必须交给独立视频 Skill 或后置任务处理。

## 12. 视频链路边界审查

通过。

本轮未生成：

- 正式字幕。
- 正式分镜。
- Seedance prompts。
- Seedance2.0 prompt。
- 视频提示词。
- 图像提示词。
- 生产稿包。

`short-drama-shotlists/` 和 `seedance-prompts/` 未新增正式内容。后续若进入视频方向，必须另开 `VIDEO-SKILL-001-PLAN` 或独立后置 Skill。

## 13. 锁稿资产清单

本轮生成的锁稿资产：

- `projects/wenyan-generalize-sima-guang-001/reviews/final-review.md`
- `projects/wenyan-generalize-sima-guang-001/locked/FINAL-SCRIPT.md`
- `projects/wenyan-generalize-sima-guang-001/locked/LOCK-MANIFEST.sha256`
- `projects/wenyan-generalize-sima-guang-001/locked/SKILL-LOCK-MANIFEST.sha256`

## 14. 剩余 P2

- 教材版本待确认。
- 目标年级待确认。
- 最终时长待确认。
- 原文采用版本正式化前待确认。

这些 P2 已接受为非阻塞项，仅对后续正式教材适配、字幕化或视频化产生影响。

## 15. 问题记录

1. remote compact 504 Gateway Timeout：上一轮 `WENYAN-GENERALIZE-005-PHASE8-RUN` 在生成 Phase 8 锁稿资产过程中因远程 compact / 网络超时中断，留下半成品。处理方式：本轮 `WENYAN-GENERALIZE-005-PHASE8-RUN-RECOVER` 检查工作区、确认 dirty 文件范围、补齐缺失文件并完成校验和提交；是否遗留：无业务遗留。
2. safe.directory / dubious ownership：直接运行普通 Git 命令时可能触发 safe.directory 阻断。影响：普通 `git` 命令需显式声明安全目录；处理方式：使用 `git -c safe.directory=C:/Users/Administrator/Desktop/novel-agent-shell-demo ...` 复跑；是否遗留：仅环境配置提示。
3. LF/CRLF：Windows Git 可能提示 LF 将被替换为 CRLF。影响：不影响内容和校验；处理方式：通过 `git diff --check` 确认无 whitespace error；是否遗留：仅环境提示。
4. 状态文档矛盾：`PROJECT.md`、`STORY-SPEC.md`、`OUTLINE.md` 原有早期阶段表述已在本轮做最小一致性修正；是否遗留：无影响锁稿判断的旧阶段表述。
5. 质量风险：儿童角色一致性、击瓮水流等视频化风险仍存在，但不属于剧本文本锁稿范围；是否遗留：有，留给后置 `VIDEO-SKILL` 控制。
6. 潜在越界风险：本轮允许生成锁稿资产，但禁止进入视频链路；处理方式：只生成 final-review、FINAL-SCRIPT 和 manifest；是否遗留：无。

## 16. 后续禁止事项

- 不得自动进入分镜链路。
- 不得自动进入 Seedance2.0 prompt 链路。
- 不得自动进入视频生产链路。
- 不得自动生成正式字幕、正式分镜、视频提示词、图像提示词或生产稿包。
- 不得把《司马光》写成完整短剧生产链路已完成。
- 不得把 `wenyan-skill` 写成所有文言文类型已完全验证。

## 17. 下一步建议

下一步候选：

```text
WENYAN-GENERALIZE-006-SCRIPT-CREATION-BOUNDARY-FREEZE：冻结《司马光》剧本创作链路完成状态
```

其他候选：

- `VIDEO-SKILL-001-PLAN`：规划分镜 / Seedance2.0 后置 Skill。
- `CLEANUP-001-AUDIT`：只读仓库清理审计。
