# WENYAN-SMOKE-002-REVIEW：文言文教辅短剧烟测质量审查

- 任务编号：WENYAN-SMOKE-002-REVIEW
- 任务名称：审查烟测项目输出质量与是否符合 wenyan-skill
- 完成日期：2026-05-29
- 当前状态：已完成只读质量审查

## 1. 审查范围

本轮只审查 `projects/wenyan-smoke-liangxiaor-bianri-001/` 的 Phase 0-4 烟测输出质量，判断其是否符合：

- `wenyan-skill`
- T-WY001：情境复演型模板
- 《两小儿辩日》文言文教辅短剧烟测目标
- Phase 0-4 烟测边界

本轮不是修订任务，未修改烟测项目内容，未生成正式审查文件，未进入 Phase 5 / 6 / 7 / 8。

## 2. 读取文件列表

本轮按任务限定读取：

- `docs/AI-CONTEXT/README.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-001-PLAN.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-001-RUN.md`
- `docs/AI-CONTEXT/archive/VALIDATE-007-EDU-ACTIVE-PROJECT-COMPAT-FIX.md`
- `genre-skills/wenyan-skill/SKILL.md`
- `genre-skills/wenyan-skill/templates/T-WY001-qingjing-fuyan.md`
- `genre-skills/wenyan-skill/examples/liangxiaor-bianri-example.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-STATE.json`
- `projects/wenyan-smoke-liangxiaor-bianri-001/GENRE-SKILL-LOCK.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/specs/STORY-SPEC.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/planning/ENDING-LOCK.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`

未读取 Codex 全局 memory、`.claude/`、`workflow/settings*.json`、`workflow/`、`scripts/`、`projects/_template/`、`projects/_template-edu-shortdrama/`、`docs/GENRE-SKILL-CONTRACT.md`、`AGENTS.md`、`README.md` 或 `docs/README.md`。

## 3. 原文准确性审查

结论：基本合格。

通过点：

- 原文完整覆盖《两小儿辩日》的主要句段：孔子东游、两小儿辩斗、两方观点、两方证据、孔子不能决、两小儿反问。
- 白话释义总体准确，能解释人物、事件、观点、证据和结尾反问。
- 未把现代科学解释写成原文结论。
- 明确保留“孔子不能决也”，并多处提示不得让孔子给出现代科学标准答案。
- `STORY-SPEC.md` 已标记“知”通“智”的教学处理待确认，符合烟测阶段的不确定项记录方式。

风险点：

- `SMOKE-DRAFT.md` 中部分对白为了压缩 60 秒结构，把“观点”和“证据”提前混合，可能削弱原文中先立观点、再举证据的学习层次。

## 4. 教学目标审查

结论：方向合格，但草案呈现仍需加强。

通过点：

- `STORY-SPEC.md` 明确字词难点：去、及、探汤、孰、汝、知。
- 明确人物 / 事件链：孔子、两小儿、太阳观察对象。
- 明确“观点 + 证据”结构：视觉大小与冷热感受分别对应两方判断。
- 适合文言文入门教辅短剧，没有把重点转成纯剧情娱乐。
- 教学目标覆盖知识目标、能力目标、情感 / 审美目标和观看后掌握内容。

不足：

- `SMOKE-DRAFT.md` 结尾没有显式给出“孰为汝多知乎？”的白话释义，只用主题旁白收束，学习闭环不够完整。
- 关键词“车盖、盘盂、探汤”在 `STORY-SPEC.md` 有教学提示，但在草案对白中仍可能对低年级学生偏难。

## 5. Scene 映射审查

结论：结构合格。

通过点：

- `OUTLINE.md` 使用 5 个 Scene，符合 60 秒烟测结构。
- Scene 顺序符合原文事件链：遇争 -> 观点 -> 证据 -> 不能决 -> 回扣主题。
- 每个 Scene 都绑定原文或教学点。
- 主要互动角色控制在孔子和两个小儿，符合单镜头主要互动人物不超过 3 个的约束。
- 没有添加穿越、打斗、恋爱、权谋或玄幻剧情。
- 具备课堂学习闭环：观点冲突 -> 证据对照 -> 孔子不能决 -> 原文反问与主题。

不足：

- S03 同时承载两个证据和三个术语，16 秒内容密度偏高，后续正式生产前可能需要拆分或优化字幕节奏。
- T-WY001 的“题目钩子”在 `SMOKE-DRAFT.md` 中主要由文件标题和 S01 承担，正文内钩子不够鲜明。

## 6. `SMOKE-DRAFT.md` 草案质量审查

结论：烟测草案边界合格，但质量不建议直接进入 Phase 5。

通过点：

- 文件明确标注“烟测草案，不是最终生产稿”。
- Scene 数量为 5，符合本次 3-5 个 Scene 的边界。
- 每个 Scene 都绑定原文或教学点。
- 没有写成完整成片剧本，没有镜号、机位、正式字幕表或视频提示词。
- 没有生成正式分镜、字幕、视频提示词、Seedance prompts 或图像提示词。
- 对白没有明显现代网络梗，没有玄幻化、恋爱化、权谋化。

主要问题：

- S02 已用“太阳初出时大”“太阳中午更热”表达证据，S03 又展开证据，观点层和证据层不够清晰。
- S05 的主题旁白“敢问，敢想，也要知道学无止境”有轻微口号化 / PPT 味，缺少白话释义的自然承接。
- 孔子对白“二子所据不同，此事我不能决”方向正确，但偏书面解释，可在后续修订中更自然地兼顾古风口吻和学生可理解性。

## 7. 生产边界审查

结论：合格。

通过点：

- `PROJECT-STATE.json` 停留在 Phase 4，`locked` 为 false。
- `SCRIPT-STATUS.md` 明确未进入 Phase 5 / 6 / 7。
- `SMOKE-DRAFT.md` 明确不得视为正式剧本、锁稿稿、生产稿包、字幕文件、分镜文件或视频提示词。
- 文件检查未发现以下禁止产物：
  - `reviews/final-review.md`
  - `locked/FINAL-SCRIPT.md`
  - `locked/LOCK-MANIFEST.sha256`
  - `locked/SKILL-LOCK-MANIFEST.sha256`
  - 正式字幕文件
  - 正式分镜文件
  - 视频提示词
  - Seedance prompts
  - 图像提示词
  - 完整生产稿包

注意项：

- `RUN-LOG.md` 仍记录 `VALIDATE-007` 前的旧校验失败状态。由于本轮禁止修改烟测项目，本次只记录该状态滞后问题，后续应在修订计划中决定是否同步项目内运行记录。

## 8. 与 `wenyan-skill` 一致性审查

结论：基本一致，但需要修订加强白话回扣和表达质量。

符合点：

- 使用 T-WY001 情境复演型模板，适合《两小儿辩日》这种有争辩、证据和反转的文本。
- 大体符合结构：入古境 -> 见事件 -> 起争辩 -> 摆观点 -> 举证据 -> 难判断 -> 回原文 -> 明主题。
- 避免玄幻、权谋、恋爱化。
- 服务理解、记忆、释义和主题，没有转成纯短剧娱乐。
- 保留“孔子不能决”，没有让孔子给出现代科学解释。
- `OUTLINE.md` 有原文、白话、字幕要点和视频风险。

不足：

- `SMOKE-DRAFT.md` 对“原文逐句回扣 + 白话强化”的落实偏弱，尤其结尾反问句没有同步白话解释。
- `SMOKE-DRAFT.md` 的主题收束偏口号，需要更自然地从原文反问过渡到“学无止境 / 敢于质疑 / 观察角度不同”。

## 9. 问题清单

### P0：必须修复，否则不能继续

无。

### P1：建议修复，影响质量

1. `SMOKE-DRAFT.md` 中观点层与证据层分离不够清楚：S02 已提前使用“日初出大 / 日中热”等证据表达，削弱 T-WY001 的“摆观点 -> 举证据”层次。
2. `SMOKE-DRAFT.md` 结尾缺少“孰为汝多知乎？”的白话释义，原文回扣和学习闭环不够完整。
3. `SMOKE-DRAFT.md` 结尾旁白有轻微口号化 / PPT 味，需要降低说教感。
4. `RUN-LOG.md` 仍停留在 `VALIDATE-007` 前的旧校验失败记录，与当前顶层校验已通过的事实不同步。

### P2：可优化，不阻塞

1. 教材版本、目标年级和 60 秒时长仍为待确认 / 烟测设定，正式化前应收敛。
2. S03 证据对照信息密度偏高，后续可优化节奏或字幕承载方式。
3. `SMOKE-DRAFT.md` 正文内题目钩子不够鲜明，后续可补一个更自然的问题式开场。

## 10. 是否通过烟测质量审查

结论：暂不通过进入下一阶段前的质量审查。

说明：

- Phase 0-4 文件结构、原文准确性和生产边界合格。
- 未发现 P0 阻塞问题。
- 但存在 4 个 P1 质量问题，会影响文言文教辅短剧的学习闭环和表达质感。
- 因此不建议直接进入 Phase 5。

## 11. 是否建议进入 Phase 5

不建议直接进入 Phase 5。

原因：

- 当前草案仍是烟测草案，不是正式审查对象。
- 应先明确修订范围，优化观点 / 证据层次、结尾白话回扣和表达质感。
- 本轮不生成 `reviews/final-review.md`，也不进入正式教学与生产审查。

## 12. 后续任务建议

下一步只推荐一个任务：

```text
WENYAN-SMOKE-003-REVISION-PLAN：制定烟测项目修订计划
```

建议该任务只制定修订范围和修订目标，不直接改项目；重点覆盖：

- 如何分离观点层与证据层。
- 如何补强原文回扣和白话释义。
- 如何降低结尾说教感。
- 是否需要同步 `RUN-LOG.md` 中 `VALIDATE-007` 后的校验通过事实。
- 是否继续停留在 Phase 4，等待用户确认后再执行实际修订。

本轮未修改烟测项目，未生成正式产物，未进入 Phase 5。
