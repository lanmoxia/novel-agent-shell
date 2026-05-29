# ARCH-001：小说流程与教辅短剧流程语义冲突审计

- 审计日期：2026-05-28
- 审计类型：只读审计
- 业务文件修改：无

本次审计只读取项目文档、流程说明、项目模板和 `wenyan-skill` 相关文件，用于判断旧小说 / 剧本流程与教辅类 AI 真人古风短剧生产方向之间的语义冲突。未修改 `workflow/`、`scripts/`、`genre-skills/`、`projects/`、`projects/_template/`，未运行测试，未创建项目。

## 读取范围

- `docs/AI-CONTEXT/README.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/GENRE-SKILL-CONTRACT.md`
- `workflow/ORCHESTRATION.md`
- `docs/SHELL-SPEC.md`
- `docs/SHELL-BOUNDARY.md`
- `docs/SHELL-OPTIMIZATION-ROADMAP.md`
- `projects/_template/` 文件清单与代表性模板文件
- `genre-skills/wenyan-skill/` 文件清单、`SKILL.md`、规则文件、模板文件和示例文件

## 旧小说 / 剧本流程关键 Phase

| Phase | 当前语义 | 关键产物 |
|---|---|---|
| Phase 0 | 项目初始化 | `PROJECT.md`、`PROJECT-STATE.json` |
| Phase 1 | 题材 Skill 加载 | `GENRE-SKILL-LOCK.md` |
| Phase 2 | 故事企划 | `STORY-SPEC.md`、`ENDING-LOCK.md`、`PROJECT-MEMORY.md` |
| Phase 3 | 大纲 / 节拍 | `OUTLINE.md`、倒推、伏笔、信息释放 |
| Phase 4 | 剧本正文 | `scripts/E##-标题.md` |
| Phase 5 | 多维审查 | 结构、连续性、对白、题材审查 |
| Phase 6 | 修订 | `revision-log.md`、快照、候选重写 |
| Phase 7 | 锁稿 | `locked/FINAL-SCRIPT.md` |
| Phase 8 | 后置模块 | 分镜、短剧分镜、Seedance 提示词 |

## 教辅短剧生产需要的关键 Phase

| 建议语义 | 关键动作 |
|---|---|
| 项目建档 | 明确篇目、原文、出处、年级、视频时长、输出目标 |
| 教辅 Skill 加载 | 锁定 `wenyan-skill`，确认适用篇目和生成边界 |
| 原文拆解 / 教学目标 | 拆原文、白话释义、人物事件、学习难点、教学目标 |
| 情境复演结构设计 | 选择 60 / 90 / 180 秒结构，建立 Scene 与原文映射 |
| 正片剧本生成 | 输出 Scene 剧本、对白、旁白、字幕 |
| 分镜 / 字幕 / 视频说明 | 生成镜头表、字幕方案、视频生成风险 |
| 教学与生产审查 | 教学准确性、原文映射、字幕闭环、视频可生产性 |
| 修订与锁定 | 修正错误，锁定最终生产稿包 |

## 主要语义冲突

| 冲突点 | 类型 | 影响 | 风险 |
|---|---|---|---|
| “故事企划”强调原创核心创意、主角、冲突、结局；教辅短剧强调原文拆解、教学目标、句意准确 | 流程冲突 | Phase 2 语义不匹配 | 高 |
| `ENDING-LOCK.md` 的“结局 / 真相 / 情绪落点”不适合文言文教辅，应对应原文结果、主题、学习闭环 | 模板冲突 | planning 文件语义偏小说 | 中 |
| `OUTLINE.md` 与倒推 / 伏笔 / 信息释放偏叙事设计；教辅需要 Scene 时间结构、原文映射、知识功能 | 模板 + 流程冲突 | Phase 3 产物不匹配 | 高 |
| Phase 8 把分镜、短剧分镜、Seedance 视为锁稿后可选；`wenyan-skill` 把分镜、字幕、视频注意事项视为核心输出 | 流程冲突 | 后置模块边界需要重判 | 高 |
| 当前审查是结构 / 连续性 / 对白 / 题材；教辅审查需要教学准确性、原文映射、字幕闭环、视频可生产性 | 流程 + Skill 合约冲突 | 审查可能放过教学错误 | 高 |
| `PROJECT-MEMORY.md` 记录结局、真相、伏笔、人物状态；教辅更需要原文事实、句意、教学点、角色一致性 | 模板冲突 | 长期记忆字段不贴合 | 中 |
| `GENRE-SKILL-CONTRACT.md` 的 capabilities 只表达小说 / 剧本 / 短剧与写作能力，无法表达教辅、原文映射、字幕、分镜、视频生产 | Skill 合约冲突 | loader 难以判断能力缺口 | 中高 |
| “题材 Skill”概念偏故事类型；`wenyan-skill` 实际是教辅生产 Skill，包含生产链路 | 命名 + 合约冲突 | 容易被误当普通题材规则 | 中 |
| “正文 / 锁稿”偏文本最终稿；教辅短剧可能需要锁定生产稿包：剧本、映射表、字幕、分镜、视频说明 | 流程冲突 | 锁定范围不清 | 中 |

## 只是命名冲突的部分

- “小说 / 剧本 Agent 壳子”：可以先在文档中标注为历史定位，不必立即改目录或文件名。
- “题材 Skill”：短期可继续沿用，但需解释 `wenyan-skill` 是“教辅题材 / 生产型 Skill”。
- “故事企划”“大纲”“正文”：可短期保留 Phase 编号，但文档中需要写清教辅语义映射。
- `scripts/` 目录名：可继续作为“剧本文本输出目录”，暂不必改。

## 会影响 workflow 的冲突

- Phase 2 必须从“原创故事企划”迁移为“原文拆解 + 教学目标 + 适用性判断”。
- Phase 3 必须从“大纲 / 伏笔 / 倒推”迁移为“Scene 结构 + 时间结构 + 原文映射”。
- Phase 5 审查维度必须适配教辅准确性和视频可生产性。
- Phase 8 的分镜 / 字幕 / 视频说明是否仍后置，需要重新定义。

## 会影响 projects/_template 的冲突

- `PROJECT.md` 缺少篇目、原文、出处、年级、视频时长、生成目标。
- `STORY-SPEC.md` 缺少原文结构拆解、白话释义、教学目标、学习难点。
- `OUTLINE.md` 缺少 Scene、时长、对应原文、知识功能。
- `PROJECT-MEMORY.md` 偏故事稳定事实，不适合记录原文句意、教学点、字幕规则。
- `short-drama-shotlists/README.md` 明确短剧分镜格式尚未定义。

## 会影响 Skill 合约的冲突

- 当前 capabilities 缺少教辅类字段。
- 合约没有表达“原文映射”“字幕方案”“分镜输出”“视频生成风险”“教学审查”。
- `wenyan-skill` 虽然已有标准文件结构，但其生产目标超出现有“题材写作规则”定义。
- 后续需要文档层面区分“题材规则 Skill”和“教辅生产 Skill”的合约扩展。

## 风险等级

| 风险等级 | 内容 |
|---|---|
| 高 | Phase 2、Phase 3、Phase 5、Phase 8 的核心语义与教辅短剧生产不完全匹配 |
| 中高 | Skill capabilities 无法表达教辅生产能力，影响加载、降级和审查判断 |
| 中 | 项目模板字段与教辅短剧生产稿包不贴合，容易导致新项目记录不完整 |
| 低 | 根目录或部分术语仍叫小说 / 剧本壳子，短期可通过文档说明缓冲 |

## 推荐处理顺序

1. 先做 `ARCH-002`：建立旧 Phase 与教辅短剧 Phase 的映射表，只做文档方案。
2. 再定义“教辅短剧生产稿包”的文档边界：哪些是核心产物，哪些是后置可选。
3. 再做 `SKILL-001`：只读检查 `wenyan-skill` 与现有合约差距。
4. 再做 `TEMPLATE-001`：评估是否新增教辅短剧模板，或扩展 `_template`。
5. 最后再考虑验证脚本和 workflow 文档调整，不直接改业务逻辑。

## 明确结论

- 短期不重构代码，不修改 `workflow/`、`scripts/`、`genre-skills/`、`projects/` 或 `projects/_template/`。
- 先做 Phase 语义映射文档，明确旧小说 / 剧本 Phase 与教辅短剧生产 Phase 的关系。
- 再做 Skill 合约检查，判断 `wenyan-skill` 与现有合约的差距。
- 再评估项目模板，决定是否需要教辅短剧专用模板或在现有模板上扩展。
