# CONTRACT-001：Skill 合约教辅能力扩展记录

- 完成日期：2026-05-28
- 任务类型：Skill 合约扩展
- 业务 Skill 修改：无
- 模板文件修改：无
- 测试运行：无

## 1. 修改范围

实际修改文件：

- `docs/GENRE-SKILL-CONTRACT.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`

实际新增文件：

- `docs/AI-CONTEXT/archive/CONTRACT-001-SKILL-CONTRACT-EXTENSION.md`

未修改：

- `genre-skills/`
- `projects/`
- `projects/_template/`
- `projects/_template-edu-shortdrama/`
- `workflow/`
- `scripts/`

## 2. 修改目的

`SKILL-001` 审计已经确认：`wenyan-skill` 实际具备文言文原文拆解、白话释义、Scene 映射、字幕、分镜、视频风险和教学审查等教辅生产能力，但原有 `docs/GENRE-SKILL-CONTRACT.md` 只能表达普通小说 / 剧本 / 短剧能力，无法机器可读地声明这些教辅能力。

本次修改的目的：

- 保持旧题材 Skill 向后兼容。
- 把教辅能力作为可选扩展，而不是所有 Skill 的必填要求。
- 让 `GENRE-SKILL-LOCK.md` 能区分 `declaredCapabilities`、`inferredCapabilities` 和 `missingCapabilities`。
- 明确教辅类 Skill 的 fallback 和 shellBoundary。
- 为后续补强 `wenyan-skill` 元数据、同步 workflow 文档和运行验证基线提供合约依据。

## 3. 新增或调整的合约能力

| 能力字段 | 含义 | 是否必填 | 适用对象 | 备注 |
| ---- | -- | ---- | ---- | -- |
| `supports_edu_shortdrama` | 是否支持教辅短剧生产 | 否 | 教辅类 Skill | 为 `true` 时应声明相关教辅能力 |
| `supports_original_text_analysis` | 是否支持原文拆解 | 否 | 文言文 / 原文改编类 Skill | 包括原文句子、结构和事实拆解 |
| `supports_plain_translation` | 是否支持白话释义 | 否 | 文言文 / 古文类 Skill | 不等于自由改写 |
| `supports_teaching_objectives` | 是否支持教学目标设计 | 否 | 教辅类 Skill | 应服务学习目标和知识闭环 |
| `supports_character_event_chain` | 是否支持人物 / 事件链提取 | 否 | 情境复演类 Skill | 用于把原文事实转为可视化结构 |
| `supports_scene_original_mapping` | 是否支持 Scene 与原文映射 | 否 | 教辅短剧 Skill | 每个 Scene 应能追溯到原文或教学点 |
| `supports_subtitle_plan` | 是否支持字幕方案 | 否 | 短剧 / 视频类 Skill | 可包含原文字幕、白话字幕和知识点字幕 |
| `supports_shotlist` | 是否支持分镜 / 镜头表 | 否 | 视频生产类 Skill | 只表示能提供分镜规则或模板 |
| `supports_video_risk_notes` | 是否支持视频生成风险说明 | 否 | 视频生产类 Skill | 包括不可生成、易误解或高成本镜头风险 |
| `supports_teaching_review` | 是否支持教学准确性审查 | 否 | 教辅类 Skill | 应覆盖原文准确性、释义准确性和教学目标达成 |
| `supports_production_package` | 是否支持生产稿包输出 | 否 | 完整生产链路类 Skill | 不等于 Skill 可以锁稿或生成视频 |

## 4. 新增教辅类 Skill 字段

| 字段 | 含义 | 是否必填 | 示例 |
| -- | -- | ---- | -- |
| `eduProfile` | 教辅定位、目标学生、学习目标范围 | 教辅类 Skill 推荐 | 文言文教辅真人古风短剧 |
| `applicableTextTypes` | 适用文本类型 | 教辅类 Skill 最小合格要求 | 文言文、古代寓言、古代人物故事 |
| `unsupportedTextTypes` | 不适用文本类型 | 教辅类 Skill 最小合格要求 | 纯抒情诗、现代散文、无事件文本 |
| `inputRequirements` | 输入要求 | 教辅类 Skill 最小合格要求 | 篇目标题、原文、年级、时长、输出目标 |
| `outputRequirements` | 输出要求 | 教辅类 Skill 最小合格要求 | 原文拆解、剧本、映射表、字幕、分镜、审查结果 |
| `originalTextRules` | 原文拆解和事实边界规则 | 教辅类 Skill 最小合格要求 | 必须先拆原文，再进入剧情结构 |
| `plainTranslationRules` | 白话释义规则 | 推荐 | 每个关键文言句必须有对应释义 |
| `teachingObjectiveRules` | 教学目标规则 | 推荐 | 明确知识目标和学习闭环 |
| `sceneMappingRules` | Scene 与原文映射规则 | 教辅类 Skill 最小合格要求 | 每个 Scene 绑定原文句子或教学点 |
| `subtitleRules` | 字幕规则 | 推荐 | 原文字幕、白话字幕、知识点字幕边界 |
| `shotlistRules` | 分镜 / 镜头表规则 | 推荐 | 镜头字段、可生产性、人物数量 |
| `videoRiskRules` | 视频生成风险规则 | 推荐 | 标记高风险镜头和不可生成画面 |
| `teachingReviewRules` | 教学审查规则 | 教辅类 Skill 最小合格要求 | 原文准确性、释义准确性、Scene 映射 |
| `productionPackageRules` | 生产稿包规则 | 推荐 | 声明最终稿包应包含哪些产物 |
| `fallbackRules` | 降级 / 缺失输入处理规则 | 教辅类 Skill 最小合格要求 | 缺原文时暂停，缺年级时请求确认 |
| `shellBoundary` | Skill 与 shell 的权限边界 | 教辅类 Skill 最小合格要求 | Skill 不创建项目、不绕过 Phase |

## 5. fallback 规则

本次合约新增的 fallback 要求：

- 原文缺失时：不得编造原文，应暂停并请求用户提供原文。
- 出处 / 年级缺失时：不得假定教材版本或学生层级，应标记为待补或请求用户确认。
- 文本不适合情境复演时：应说明不适配原因，并建议降级为讲解、注释、字幕或其他输出。
- 用户只要求部分产物时：只输出用户请求范围，并记录未生成产物。
- 能力未声明但模板中存在时：不得把模板字段当成 `declaredCapabilities`，应记录为 `inferredCapabilities` 或 `missingCapabilities`。
- 原文与用户创意冲突时：以原文事实和教学准确性优先，创意只能作为表现方式，不得覆盖原文事实。

## 6. shellBoundary 规则

本次合约新增的边界要求：

- Skill 只提供规则、模板、示例和审查标准。
- Skill 不创建项目。
- Skill 不修改 workflow。
- Skill 不绕过 Phase 门禁。
- Skill 不自动进入审查、修订、锁稿。
- Skill 不自动生成视频、图片或后置提示词。
- Skill 不替代用户确认。

## 7. 向后兼容说明

- 旧 Skill 如果没有教辅扩展字段，仍可按旧合约读取。
- 缺少教辅扩展字段不阻断普通 Skill 加载。
- 旧 Skill 不能因为文件中存在模板或示例，就声明自己支持教辅短剧完整生产。
- loader 或人工审计应把缺失字段记录到 `GENRE-SKILL-LOCK.md`。
- 不得用推断能力冒充 `declaredCapabilities`。
- 推断得到的能力应记录为 `inferredCapabilities`，并与 `declaredCapabilities` 分开。

## 8. 对 wenyan-skill 的影响

本轮不修改 `genre-skills/wenyan-skill/`。

后续 `wenyan-skill` 可以按新合约补强：

- 增加 `version`。
- 增加 `capabilities`，声明 `supports_edu_shortdrama`、原文拆解、白话释义、Scene 映射、字幕、分镜、视频风险、教学审查和生产稿包能力。
- 增加或整理 `fallbackRules`，明确缺原文、缺年级、文本不适配、用户只要部分产物时的处理。
- 增加 `shellBoundary`，明确 Skill 不创建项目、不修改 workflow、不绕过 Phase、不自动生成视频或图片。

判断：`wenyan-skill` 的内容层已经能支撑第一版教辅生产，但元数据和边界声明仍建议后续补强。

## 9. 对 projects/_template-edu-shortdrama 的影响

本轮不修改 `projects/_template-edu-shortdrama/`。

新合约能帮助该模板中的 `GENRE-SKILL-LOCK.md` 更清楚地记录：

- `declaredCapabilities`
- `inferredCapabilities`
- `missingCapabilities`
- `fallbackRules`
- `shellBoundary`

影响判断：模板当前已经预留这些记录位置；合约扩展后，后续项目创建或人工锁定 Skill 时，可以按新字段判断 `wenyan-skill` 的能力声明是否完整。

## 10. 后续任务建议

主任务建议：**WORKFLOW-DOC-001：同步 workflow 文档中的教辅 Phase 语义**。

理由：

- Skill 内容层已有 `wenyan-skill`。
- 模板层已有 `projects/_template-edu-shortdrama/`。
- 合约层已能表达教辅能力。
- 当前仍未同步的是 workflow 文档对 Phase 0-8 的教辅语义解释。

后续排序：

1. `WORKFLOW-DOC-001`：同步 workflow 文档中的教辅 Phase 语义。
2. `SKILL-002`：按新合约补强 `wenyan-skill` 元数据。
3. `VALIDATE-001`：运行现有校验基线。
4. `WENYAN-SMOKE-001`：在用户确认后用 `wenyan-skill` 做一次创作冒烟测试。

本轮不执行后续任务。

## 11. 明确结论

- `CONTRACT-001` 已完成的是 Skill 合约扩展。
- 本轮没有修改 `genre-skills/`。
- 本轮没有修改 `projects/_template-edu-shortdrama/`。
- 本轮没有修改 `workflow/`。
- 本轮没有修改 `scripts/`。
- 本轮没有运行测试。
- 本轮没有创建项目。
- 下一步建议是 `WORKFLOW-DOC-001`：同步 workflow 文档中的教辅 Phase 语义。
