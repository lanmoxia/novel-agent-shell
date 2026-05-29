# WENYAN-SMOKE-001-PLAN：文言文教辅短剧烟测方案

- 任务编号：WENYAN-SMOKE-001-PLAN
- 任务名称：制定文言文教辅短剧烟测方案
- 完成日期：2026-05-29
- 当前状态：已完成

## 1. 烟测目标

本方案只定义烟测边界，不创建项目、不生成剧本、不运行 smoke test。

后续 `WENYAN-SMOKE-001-RUN` 的目标是用一个受控文言文样本验证：

- `wenyan-skill` 能否作为教辅短剧 Skill 被项目锁定。
- `projects/_template-edu-shortdrama/` 能否支撑真实烟测项目建档。
- Phase 0-4 的教辅语义是否能形成最小闭环。
- 原文拆解、教学目标、Scene 映射和短剧草案边界是否清晰。
- 现有校验链路在遇到真实教辅项目实例时是否暴露兼容风险。

本方案不把 `WENYAN-SMOKE-001` 标记为完成；它只是执行前的边界定义。

## 2. 推荐输入文本

推荐使用《两小儿辩日》。

原因：

- `wenyan-skill` 将《两小儿辩日》列为典型篇目。
- `genre-skills/wenyan-skill/examples/liangxiaor-bianri-example.md` 已提供结构拆解、Scene / 分镜 / 字幕示例，可作为烟测参照。
- 原文短、人物少、冲突明确，适合验证 Phase 2 原文拆解和 Phase 3 Scene 映射。
- 文本包含观点对立、证据表达和主题反转，能检验教辅短剧是否仍服务原文理解。

默认建议使用《两小儿辩日》，不建议本次烟测另选长篇或无事件文本。

## 3. 推荐项目目录

后续执行时建议创建真实烟测项目目录：

```text
projects/wenyan-smoke-liangxiaor-bianri-001
```

说明：

- 本轮不创建该目录。
- 该目录名不使用 `*-smoke-test` 后缀，因此会被视为真实项目实例，更适合暴露真实项目校验兼容问题。
- 如果用户希望完全避免 active project 校验影响，可在执行前另行确认改用 `projects/wenyan-liangxiaor-bianri-smoke-test`，但这会降低真实项目链路覆盖度。

## 4. 推荐执行阶段

推荐只推进到 Phase 4。

| Phase | 教辅短剧语义 | 本次烟测范围 |
|---|---|---|
| Phase 0 | 项目建档 | 填写项目名、篇目、原文、年级、时长、输出范围 |
| Phase 1 | 教辅 Skill 加载 | 锁定 `wenyan-skill`，记录 capabilities、fallbackRules、shellBoundary |
| Phase 2 | 原文拆解 / 教学目标 | 生成原文拆解、白话释义、人物事件链、教学目标、不可改写事实 |
| Phase 3 | Scene 映射 | 生成情境复演结构、Scene 与原文映射、字幕要点和视频风险提示 |
| Phase 4 | 短剧脚本草案 | 只允许一个极短烟测草案，且必须标明不是最终生产稿 |

不进入：

- Phase 5 审查
- Phase 6 修订
- Phase 7 锁稿
- Phase 8 后置模块

## 5. 允许生成文件

默认允许后续执行任务生成以下文件：

- `PROJECT.md`
- `PROJECT-STATE.json`
- `GENRE-SKILL-LOCK.md`
- `specs/STORY-SPEC.md`
- `planning/ENDING-LOCK.md`
- `outlines/OUTLINE.md`
- `scripts/SCRIPT-STATUS.md`
- `RUN-LOG.md`
- `PROJECT-MEMORY.md`

如用户确认要覆盖 Phase 4 的最小正文能力，可额外允许：

- `scripts/SMOKE-DRAFT.md`

`scripts/SMOKE-DRAFT.md` 必须满足：

- 极短，只用于烟测。
- 明确标注“烟测草案，不是最终生产稿”。
- 不得写成完整成片剧本。
- 每个 Scene 必须绑定原文或教学点。
- 不得包含正式锁稿、审查通过或生产稿包声明。

## 6. 禁止生成文件

后续烟测默认禁止生成：

- `locked/FINAL-SCRIPT.md`
- `locked/LOCK-MANIFEST.sha256`
- `locked/SKILL-LOCK-MANIFEST.sha256`
- `reviews/final-review.md`
- `revisions/` 下的实际修订稿或快照
- `short-drama-shotlists/` 下的非 README 分镜文件
- `seedance-prompts/` 下的非 README 提示词文件
- 独立字幕成片稿
- 长篇分镜
- 视频提示词
- Seedance prompts
- 图像提示词
- 完整生产稿包

允许模板目录中已有 README 或空目录存在，但不得填充正式生产内容。

## 7. 字幕 / 分镜 / 视频提示词边界

本次烟测不生成正式字幕文件、正式分镜文件或视频提示词。

允许在 `outlines/OUTLINE.md` 或 `scripts/SCRIPT-STATUS.md` 中记录：

- 字幕要点
- 分镜草案状态
- 视频生成风险提示

但这些只能作为 Phase 3-4 的边界说明，不得升级为 Phase 8 后置产物。

## 8. 成功标准

`WENYAN-SMOKE-001-RUN` 成功标准建议为：

- 用户已确认创建烟测项目目录。
- 项目目录从教辅短剧模板出发，未复用旧 smoke test 内容。
- `PROJECT.md` 明确篇目、原文、年级、时长、输出范围和 Phase 0 确认状态。
- `GENRE-SKILL-LOCK.md` 记录 `wenyan-skill`、版本、declaredCapabilities、fallbackRules 和 shellBoundary。
- `STORY-SPEC.md` 覆盖原文、白话释义、人物 / 事件链、教学目标和不可改写事实。
- `ENDING-LOCK.md` 锁定原文结果和学习闭环，不写成小说结局。
- `OUTLINE.md` 给出 Scene 与原文映射，并包含字幕要点和视频风险提示。
- `SCRIPT-STATUS.md` 明确 Phase 4 只是烟测草案状态，不允许审查、修订或锁稿。
- `PROJECT-STATE.json` 与 Markdown 状态一致。
- `RUN-LOG.md` 记录输入、输出、当前阶段、下一步和未生成产物。
- 未生成锁稿、正式生产稿包、视频提示词或后置产物。

如果运行校验时发现 active project 校验仍套用旧小说 / 剧本字段，应记录为兼容风险，不在同一任务中修改脚本或模板。

## 9. 风险点

主要风险：

- 真实烟测项目可能触发现有 active project 校验的旧小说 / 剧本字段要求，例如旧 planning 文件或锁稿状态要求。
- Phase 4 一旦生成草案，容易被误认为正式剧本，需要在文件标题、状态和 RUN-LOG 中明确“烟测草案”。
- 《两小儿辩日》已有示例包含分镜和字幕，执行时不能直接复制示例当作完整生产稿。
- 如果创建真实项目后不清理，仓库会长期保留一个烟测目录。
- 如果立即清理，后续复盘证据可能不足。

处理原则：

- 烟测发现的问题先记录，不顺手修脚本、模板或 Skill。
- 不用占位文件伪造审查、修订、锁稿或生产稿包状态。
- 不把烟测成果写成正式项目成果。

## 10. 用户确认项

执行 `WENYAN-SMOKE-001-RUN` 前必须等待用户确认：

1. 是否创建真实项目目录。
2. 项目目录是否使用 `projects/wenyan-smoke-liangxiaor-bianri-001`。
3. 是否默认使用《两小儿辩日》。
4. 是否推进到 Phase 4。
5. 是否允许生成 `scripts/SMOKE-DRAFT.md` 极短脚本草案。
6. 是否禁止生成字幕文件、分镜文件、视频提示词和生产稿包。
7. 烟测后项目是短期保留待验收，还是验收后清理。
8. 如校验失败，是否只记录失败并暂停，不在同一任务中修脚本。

默认建议：

- 创建真实烟测项目目录。
- 使用《两小儿辩日》。
- 推进到 Phase 4。
- 允许一个极短 `scripts/SMOKE-DRAFT.md` 烟测草案。
- 不生成正式字幕、分镜、视频提示词或生产稿包。
- 烟测项目先保留，用户验收后再决定是否清理。

## 11. 失败记录与回滚策略

失败时应：

- 在 `RUN-LOG.md` 记录失败点、当前阶段、已生成文件和下一步建议。
- 在后续归档报告中记录失败命令、错误摘要和影响范围。
- 不自动删除烟测项目目录。
- 不在同一任务中修改 `workflow/`、`scripts/`、`genre-skills/` 或模板来修复失败。

如用户要求回滚：

- 只允许删除本次创建的烟测项目目录。
- 删除前列出将删除的路径。
- 删除后保留归档报告和状态记录。

## 12. 下一步执行任务建议

下一步只推荐一个任务：

`WENYAN-SMOKE-001-RUN`：按用户确认范围创建文言文教辅短剧烟测项目。

该任务必须在用户明确确认后执行，不得自动开始。
