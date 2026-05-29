# ARCH-002：旧 Phase 与教辅短剧 Phase 映射表

- 完成日期：2026-05-28
- 任务类型：文档层 Phase 映射设计
- 业务文件修改：无

本文件基于 `docs/AI-CONTEXT/archive/ARCH-001-AUDIT.md`、`workflow/ORCHESTRATION.md`、`docs/SHELL-SPEC.md`、`docs/SHELL-BOUNDARY.md`、`docs/GENRE-SKILL-CONTRACT.md` 和 `projects/_template/` 的只读结果整理。本文只设计语义映射，不修改 `workflow/`、`scripts/`、`genre-skills/`、`projects/` 或 `projects/_template/`。

## 1. 设计原则

- 不立即重构代码，不把本映射视为已完成的 workflow 迁移。
- 不把教辅逻辑硬编码到 shell 主流程；shell 继续负责阶段、门禁、状态和调度。
- 保留旧 Phase 0-8 编号的兼容性，避免破坏现有状态文件、模板、脚本和历史项目。
- 先通过文档语义映射解决“同一 Phase 在新方向下该如何理解”的问题。
- 后续再根据 `SKILL-001`、`TEMPLATE-001` 和验证结果，决定是否调整 workflow 文档或 `projects/_template/`。
- 题材 / 教辅生产规则优先沉淀在 Skill、模板和项目文档中，不上升为壳子硬规则。

## 2. 旧 Phase 0-8 当前语义

- Phase 0：项目初始化。
- Phase 1：题材 Skill 加载。
- Phase 2：故事企划。
- Phase 3：大纲 / 节拍。
- Phase 4：剧本正文。
- Phase 5：多维审查。
- Phase 6：修订。
- Phase 7：锁稿。
- Phase 8：后置模块。

## 3. 教辅短剧 Phase 建议语义

| Phase | 建议语义 | 关键内容 |
|---|---|---|
| Phase 0 | 项目建档 | 篇目、原文、出处、年级、时长、输出目标、生产边界 |
| Phase 1 | 教辅 Skill 加载 | 锁定 `wenyan-skill`，确认适用范围、能力声明和降级边界 |
| Phase 2 | 原文拆解 / 教学目标 | 原文、白话释义、人物事件、学习难点、教学目标、知识闭环 |
| Phase 3 | 情境复演结构设计 | Scene、时间结构、原文映射、知识功能、叙事顺序 |
| Phase 4 | 正片剧本生成 | 对白、旁白、字幕初稿、教学闭环、可拍摄文本 |
| Phase 5 | 教学与生产审查 | 准确性、原文映射、字幕可读性、可生产性、禁忌与风险 |
| Phase 6 | 修订与校正 | 修正教学错误、映射错误、字幕问题、生产风险和文本问题 |
| Phase 7 | 最终生产稿包锁定 | 锁定剧本、原文映射、字幕方案、审查结论和生产稿包范围 |
| Phase 8 | 分镜 / 字幕 / 视频说明 | 在锁稿和用户确认后输出镜头表、视频说明、可选生成提示词 |

说明：短期内不改变 Phase 8 的“锁稿后才启用”门禁。字幕初稿可以在 Phase 4 随正片文本生成，字幕审查可在 Phase 5 进行；完整分镜、视频说明和生成提示词仍应保持 Phase 8 后置属性。

## 4. Phase 映射表

| 旧 Phase | 旧语义 | 教辅短剧对应语义 | 是否保留编号 | 是否需要改名 | 影响范围 | 风险 |
|---|---|---|---|---|---|---|
| Phase 0 | 项目初始化 | 项目建档：篇目、原文、出处、年级、时长、输出目标 | 是 | 建议文档显示名改为“项目建档” | `PROJECT.md`、`PROJECT-STATE.json`、README 类说明 | 中 |
| Phase 1 | 题材 Skill 加载 | 教辅 Skill 加载：锁定 `wenyan-skill` 与适用边界 | 是 | 建议文档解释“题材 Skill”可包含教辅生产 Skill | `GENRE-SKILL-LOCK.md`、Skill 合约、loader 说明 | 中 |
| Phase 2 | 故事企划 | 原文拆解 / 教学目标：原文、释义、人物事件、学习难点 | 是 | 需要改显示名和模板语义 | `STORY-SPEC.md`、`ENDING-LOCK.md`、`PROJECT-MEMORY.md` | 高 |
| Phase 3 | 大纲 / 节拍 | 情境复演结构设计：Scene、时间结构、原文映射 | 是 | 需要改显示名和模板语义 | `OUTLINE.md`、倒推 / 伏笔类 planning 文件 | 高 |
| Phase 4 | 剧本正文 | 正片剧本生成：对白、旁白、字幕初稿、教学闭环 | 是 | 可改为“正片剧本”或“生产稿正文” | `scripts/`、`SCRIPT-STATUS.md`、剧本模板 | 中 |
| Phase 5 | 多维审查 | 教学与生产审查：准确性、映射、字幕、可生产性 | 是 | 需要扩展审查语义 | `reviews/`、审查 agent 文档、Skill review rubric | 高 |
| Phase 6 | 修订 | 修订与校正：教学错误、映射错误、字幕和生产风险修正 | 是 | 可保留“修订”，补充教辅校正语义 | `revisions/`、`revision-log.md`、项目记忆 | 中 |
| Phase 7 | 锁稿 | 最终生产稿包锁定：剧本、映射、字幕、审查结论 | 是 | 建议改文档语义为“生产稿包锁定” | `locked/FINAL-SCRIPT.md`、锁稿清单、manifest | 中 |
| Phase 8 | 后置模块 | 分镜 / 字幕 / 视频说明：镜头表、视频生成风险、可选提示词 | 是 | 可保留“后置模块”，但需说明边界 | `shotlists/`、`short-drama-shotlists/`、`seedance-prompts/` | 高 |

## 5. 需要重命名但暂不改文件的概念

| 旧概念 | 建议语义 | 类型 | 说明 |
|---|---|---|---|
| 故事企划 | 原文拆解 / 教学目标 | 不只是命名冲突 | 未来会影响 `STORY-SPEC.md` 和 Phase 2 输出结构 |
| 大纲 | 情境复演结构 / Scene 映射 | 不只是命名冲突 | 未来会影响 `OUTLINE.md`、planning 文件和模板字段 |
| 正文 | 正片剧本 / 可拍摄文本 | 主要是显示名 + 产物边界 | 可短期复用 `scripts/`，但需写清字幕和旁白是否属于正文 |
| 锁稿 | 生产稿包锁定 | 产物范围冲突 | 未来可能不只锁 `FINAL-SCRIPT.md`，还要锁映射表、字幕和分镜状态 |
| 后置模块 | 分镜 / 视频生产说明 | 流程边界冲突 | 分镜和视频说明在教辅短剧中更核心，但短期仍应保持锁稿后启用 |
| 题材 Skill | 教辅生产 Skill / 题材规则 Skill | 合约命名冲突 | 短期可继续使用目录名，后续通过 Skill 合约扩展解释能力 |

## 6. 对 workflow 的影响

本轮只做文档判断，不修改 workflow。

未来可能需要 workflow 文档调整的部分：

- Phase 2：从“原创故事企划”调整为“原文拆解、教学目标、适用性判断”。
- Phase 3：从“大纲 / 倒推 / 伏笔 / 信息释放”调整为“Scene 结构、时间结构、原文映射、知识功能”。
- Phase 5：审查维度需要加入教学准确性、原文映射、字幕闭环和视频可生产性。
- Phase 7：锁稿范围需要从单一最终稿扩展为生产稿包边界。
- Phase 8：需要重新说明字幕、分镜、视频说明和生成提示词的边界。

当前可以通过 Skill 和模板解释解决的部分：

- Phase 编号继续保留，避免破坏状态机和项目恢复机制。
- `scripts/` 仍可作为正片文本输出目录。
- `short-drama-shotlists/`、`shotlists/`、`seedance-prompts/` 继续作为后置输出目录。
- 教辅规则不进入 shell 主流程，先由 `wenyan-skill` 和项目文档承载。

暂时不应动的部分：

- 不调整跨阶段门禁。
- 不修改 Hook、validate 脚本或项目创建脚本。
- 不改变 Phase 8 必须锁稿后并由用户确认才启用的原则。
- 不把 `wenyan-skill` 的具体篇目、教学法或视频规则写入 `workflow/ORCHESTRATION.md`。

## 7. 对 projects/_template 的影响

本轮只做文档判断，不修改模板。

未来可能需要新增的字段：

- `PROJECT.md`：篇目、原文出处、教材 / 年级、视频时长、输出目标、是否需要分镜 / 字幕 / 视频说明。
- `STORY-SPEC.md`：原文拆解、白话释义、人物事件、学习难点、教学目标、情境复演边界。
- `OUTLINE.md`：Scene 编号、时长、对应原文、知识功能、字幕要点、拍摄提示。
- `PROJECT-MEMORY.md`：原文事实、句意、教学点、角色映射、字幕规则、不可改写的知识结论。
- `reviews/`：教学准确性、原文映射、字幕可读性、生产可行性的审查记录。
- `locked/`：生产稿包锁定清单，而不只是最终剧本。

可以复用的旧字段和目录：

- `PROJECT-STATE.json` 的 `phase`、`status`、`confirmedArtifacts` 可继续作为机器状态基础。
- `GENRE-SKILL-LOCK.md` 可继续记录 Skill 路径、版本、能力声明和缺失能力。
- `materials/` 可存放原文、注释、教材来源或用户提供资料。
- `scripts/` 可继续承载正片剧本文本。
- `reviews/`、`revisions/`、`locked/` 可继续承载审查、修订和锁定结果。
- `shotlists/`、`short-drama-shotlists/`、`seedance-prompts/` 可继续作为后置输出区。

语义冲突较大的模板文件：

- `specs/STORY-SPEC.md`：当前以核心创意、主角、冲突、结局方向为中心，与教辅拆解不匹配。
- `planning/ENDING-LOCK.md`：当前偏结局、真相和情绪落点，需要判断如何对应原文结果、主题和学习闭环。
- `outlines/OUTLINE.md`：当前偏章节 / 集数、冲突推进和章末钩子，与 Scene 原文映射不完全匹配。
- `PROJECT-MEMORY.md`：当前偏人物、伏笔、道具和倒推链，需要补充原文事实和教学点。

## 8. 对 Skill 合约的影响

这些映射依赖后续 Skill capabilities 扩展：

- 是否支持教辅类短剧。
- 是否提供原文拆解规则。
- 是否提供白话释义 / 教学目标输出规则。
- 是否提供 Scene 与原文映射规则。
- 是否提供字幕方案和分镜说明。
- 是否提供教学准确性审查标准。
- 是否提供视频生成风险或生产注意事项。

属于 `SKILL-001` 后续检查范围的事项：

- `wenyan-skill` 当前文件结构是否符合 `docs/GENRE-SKILL-CONTRACT.md`。
- `wenyan-skill` 是否已经声明或实际提供上述教辅生产能力。
- 当前合约是否只支持小说 / 剧本 / 短剧写作能力，无法表达教辅生产能力。
- 是否需要区分“题材规则 Skill”和“教辅生产 Skill”的合约扩展。

本轮不修改 Skill 合约，不修改 `genre-skills/wenyan-skill/`。

## 9. 推荐后续任务顺序

1. 先执行 `SKILL-001`：检查 `wenyan-skill` 与现有 Skill 合约的差距。原因是模板字段和 workflow 语义应先知道 Skill 实际能提供什么。
2. 再执行 `TEMPLATE-001`：评估 `projects/_template` 是否需要教辅短剧版本，或只在现有模板上增加教辅字段。
3. 如 `SKILL-001` 和 `TEMPLATE-001` 都确认需要，再新增 workflow 文档更新任务，范围应限于文档说明和 Phase 显示语义，不直接改 Hook 或脚本。
4. 最后在用户确认后执行 `VALIDATE-001`，记录当前 validate 基线；不要为了通过验证而修改业务逻辑。

## 10. 明确结论

- `ARCH-002` 已完成的是文档层 Phase 映射设计。
- 本轮没有修改 `workflow/`、`scripts/`、`genre-skills/`、`projects/` 或 `projects/_template/`。
- 旧 Phase 0-8 编号短期应保留，优先通过文档语义映射和后续 Skill / 模板审计降低迁移理解成本。
- 下一步建议执行 `SKILL-001`：检查 `wenyan-skill` 与现有 Skill 合约的差距。
