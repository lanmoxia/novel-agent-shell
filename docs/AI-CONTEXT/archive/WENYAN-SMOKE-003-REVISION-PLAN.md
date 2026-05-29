# WENYAN-SMOKE-003-REVISION-PLAN：烟测项目修订计划

- 任务编号：WENYAN-SMOKE-003-REVISION-PLAN-RECOVERY
- 任务名称：恢复烟测项目修订计划制定
- 完成日期：2026-05-29
- 当前状态：已完成修订计划制定，未执行修订

## 1. recovery 说明

上一轮 `WENYAN-SMOKE-003-REVISION-PLAN` 因 `504 Gateway Timeout` 中断。

本轮是 recovery：继续完成修订计划归档和 AI-CONTEXT 状态更新，不重新定义任务，不修改烟测项目内容。

本轮仍然只制定 Phase 4 烟测草案修订计划，不进入 Phase 5 / 6 / 7 / 8。

## 2. 制定计划的依据

本计划依据以下文件和结论制定：

- `docs/AI-CONTEXT/README.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-002-REVIEW.md`
- `docs/AI-CONTEXT/archive/WENYAN-SMOKE-001-RUN.md`
- `docs/AI-CONTEXT/archive/VALIDATE-007-EDU-ACTIVE-PROJECT-COMPAT-FIX.md`
- `genre-skills/wenyan-skill/SKILL.md`
- `genre-skills/wenyan-skill/templates/T-WY001-qingjing-fuyan.md`
- `genre-skills/wenyan-skill/examples/liangxiaor-bianri-example.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-STATE.json`
- `projects/wenyan-smoke-liangxiaor-bianri-001/specs/STORY-SPEC.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`

未读取 Codex 全局 memory、`.claude/`、`workflow/settings*.json`。

## 3. 审查结论摘要

`WENYAN-SMOKE-002-REVIEW` 的结论是：

- Phase 0-4 文件结构、原文准确性和生产边界合格。
- 未发现 P0 阻塞问题。
- 存在 4 个 P1 和 3 个 P2。
- 不建议直接进入 Phase 5。
- 应先制定并确认 Phase 4 烟测草案修订计划。

本轮修订目标不是正式生产修订，而是 Phase 4 烟测草案质量修订准备。

## 4. P1 修订方案

### P1-1：观点层与证据层分离

问题：

`SMOKE-DRAFT.md` 的 S02 已提前把“日初出大 / 日中热”等证据说出，削弱了 T-WY001 要求的“摆观点 -> 举证据”层次。

后续修订建议：

S02 只呈现两个观点：

- 小儿甲：日出近，日中远
- 小儿乙：日出远，日中近

S03 再呈现两个证据：

- 小儿甲：日初出大如车盖，日中如盘盂
- 小儿乙：日初出沧沧凉凉，日中如探汤

执行边界：

- 不要在 S02 提前讲完“日初出大 / 日中热”。
- 保持两个观点成对出现、两个证据成对出现。
- 不加入现代天文学解释，不让孔子给标准答案。

### P1-2：补白话释义

问题：

S05 只回扣了原文“孰为汝多知乎？”，缺少白话释义，学习闭环不够完整。

后续修订建议：

在 S05 补充：

```text
孰为汝多知乎？白话：谁说你很有智慧呢？
```

执行边界：

- 该句应作为原文反问和白话理解的学习回扣。
- 不能处理成嘲讽羞辱孔子。
- 应保持“两小儿发问”而非“恶意取笑”的语气。

### P1-3：降低口号化 / PPT 味

问题：

S05 旁白“敢问，敢想，也要知道学无止境”略直白，容易像口号或 PPT 总结。

后续修订建议：

- 减少类似“敢问，敢想，也要知道学无止境”的直白口号。
- 改为更贴近情境、从原文自然生出的收束。
- 可参考方向：

```text
原来，能提出问题，也要承认自己还有不懂之处。
```

执行边界：

- 本轮不把该句写入项目文件。
- 后续实际修订时，应结合 S05 现有对白和白话释义一起调整。
- 保留“敢于质疑 / 学无止境 / 观察角度不同”的教学主题，但降低说教感。

### P1-4：同步 RUN-LOG 状态

问题：

`RUN-LOG.md` 仍停留在 `VALIDATE-007` 前的旧校验失败记录，与当前 Bash / PowerShell 顶层校验已通过的事实不同步。

后续修订建议：

后续执行修订时，应在 `RUN-LOG.md` 中补记：

- `VALIDATE-007` 已完成
- Bash / PowerShell 顶层校验已通过
- `WENYAN-SMOKE-002-REVIEW` 已完成
- 当前进入修订计划阶段，但仍未进入 Phase 5

执行边界：

- 只同步真实历史，不删除旧失败记录。
- 应说明旧失败已由 `VALIDATE-007` 的 projectType 分流和教辅项目实例专用校验解决。
- 不得为通过校验补旧小说规划文件。

## 5. P2 优化建议

### P2-1：教材版本、目标年级和 60 秒时长后续收敛

建议在正式化前由用户确认：

- 使用的具体教材版本。
- 目标年级是小学高年级还是初中文言文入门。
- 是否继续采用 60 秒结构，或调整为 90 秒以降低解释密度。

本项不阻塞 Phase 4 草案修订，但会影响后续 Phase 5 审查标准。

### P2-2：降低 S03 证据对照信息密度

建议后续修订时：

- 保留两个证据成对出现。
- 减少同一句内的术语堆叠。
- 将“车盖 / 盘盂 / 探汤”的解释控制为短句，不在草案阶段生成正式字幕表。
- 若用户后续确认扩展时长，可把证据解释拆到更宽松的节奏中。

### P2-3：增强题目钩子

建议在不脱离原文的前提下，增强正文开场问题感，例如围绕：

```text
太阳早晨近，还是中午近？
```

执行边界：

- 题目钩子只能服务《两小儿辩日》的核心问题。
- 不加入穿越、悬疑、玄幻或现代网络梗。
- 不把题目钩子扩写成脱离原文的剧情。

## 6. 文件级修订范围

如果用户后续确认执行修订，最多建议允许修改：

- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SMOKE-DRAFT.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/scripts/SCRIPT-STATUS.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/outlines/OUTLINE.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/RUN-LOG.md`
- `projects/wenyan-smoke-liangxiaor-bianri-001/PROJECT-MEMORY.md`

默认不改：

- `PROJECT-STATE.json`
- `GENRE-SKILL-LOCK.md`
- `specs/STORY-SPEC.md`
- `planning/ENDING-LOCK.md`

除非用户后续明确确认，不应修改默认不改文件。

## 7. 禁止生成内容

后续修订仍不得生成：

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

后续修订也不得补旧小说 / 剧本规划文件来迎合旧校验：

- `planning/REVERSE-OUTLINE.md`
- `planning/FORESHADOW-LEDGER.md`
- `planning/REVEAL-SCHEDULE.md`

## 8. 是否进入 Phase 5

不进入 Phase 5。

本轮只是制定 Phase 4 草案修订计划。

后续即使执行 `WENYAN-SMOKE-003-REVISION-RUN`，也应仍停留在 Phase 4，除非用户另行确认进入 Phase 5。

## 9. 用户确认项

执行后续修订前，需要用户确认：

1. 是否执行 `WENYAN-SMOKE-003-REVISION-RUN`。
2. 是否同意按本计划限定的文件级范围修改烟测项目。
3. 是否确认本次修订仍停留在 Phase 4，不进入 Phase 5。
4. 是否允许同步 `RUN-LOG.md` 和 `PROJECT-MEMORY.md` 中的状态滞后记录。
5. 是否需要在本次修订中处理 P2，或只处理 4 个 P1。

## 10. 后续任务建议

后续只推荐一个任务：

```text
WENYAN-SMOKE-003-REVISION-RUN：按用户确认范围修订 Phase 4 烟测草案
```

该任务必须等待用户确认后执行。

建议默认执行边界：

- 处理 4 个 P1。
- 可轻量处理 3 个 P2，但不扩大到正式生产稿。
- 不进入 Phase 5。
- 不生成正式审查、锁稿、字幕、分镜、视频提示词或生产稿包。

