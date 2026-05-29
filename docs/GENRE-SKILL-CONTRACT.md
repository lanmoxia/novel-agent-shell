# 题材 Skill 合约

> 本文档定义题材 Skill 插件的标准接口。任何放入 `genre-skills/` 的题材包，只要满足本合约，即可被 `genre-loader` 正确加载和校验。

---

## 1. 标准目录结构

```
genre-skills/<skill-name>/
├── SKILL.md                 # 必需：入口说明（至少包含 name 和 description；推荐 version）
├── genre-profile.md         # 推荐：题材定位、世界观、调性
├── style-guide.md           # 推荐：文风、叙事视角、语言风格
├── structure-rules.md       # 推荐：结构规则、节拍、起承转合要求
├── character-rules.md       # 推荐：人物塑造规则、人物关系要求
├── dialogue-rules.md        # 推荐：对白风格、口吻一致性要求
├── taboo.md                 # 推荐：禁忌和反向约束（不能出现的内容）
├── review-rubric.md         # 推荐：审查标准和通过条件
├── templates/               # 可选：输出模板
└── examples/                # 可选：示例片段
```

---

## 2. 文件职责与必需性

| 文件 | 必需性 | 内容要求 |
|------|--------|----------|
| SKILL.md | **必需** | YAML frontmatter（name, description；推荐 version 和 capabilities）+ 题材总说明 |
| genre-profile.md | 推荐 | 题材定位、目标读者、世界观约束、调性说明 |
| style-guide.md | 推荐 | 文风、叙事视角、句式偏好、节奏要求 |
| structure-rules.md | 推荐 | 结构模式、节拍规则、长度约束 |
| character-rules.md | 推荐 | 人物数量、命名规则、成长弧线要求 |
| dialogue-rules.md | 推荐 | 对白风格、口吻一致性、格式要求 |
| taboo.md | 推荐 | 禁止出现的词汇、情节、人物类型、表达方式 |
| review-rubric.md | 推荐 | 审查维度、评分标准、通过条件 |
| templates/ | 可选 | 输出格式模板 |
| examples/ | 可选 | 优秀范例句 |

---

## 3. 兼容旧格式 Skill

部分已有题材 Skill 采用简化结构：

```
<skill-name>/
├── SKILL.md
├── outline-method.md
└── output-style.md
```

兼容映射规则：

| 旧文件 | 映射到新合约 |
|--------|-------------|
| SKILL.md | 题材总说明（直接读取） |
| outline-method.md | structure-rules + character-rules（合并读取） |
| output-style.md | style-guide + dialogue-rules（合并读取） |
| examples/ 缺失 | 记录缺失，不阻断加载 |
| templates/ 缺失 | 记录缺失，不阻断加载 |
| taboo.md 缺失 | 降级为不设禁忌限制 |
| review-rubric.md 缺失 | 根据 SKILL.md + outline-method.md + output-style.md 降级审查 |

---

## 3.5 能力声明（推荐）

题材 Skill 推荐在 `SKILL.md` frontmatter 中声明 `capabilities`。这是壳子识别、降级和兜底的机器可读依据。

示例：

```yaml
---
name: example-skill
version: 1.0.0
description: 示例题材 Skill。
capabilities:
  supports_novel: true
  supports_script: true
  supports_short_drama: false
  provides_style: true
  provides_structure: true
  provides_character_rules: true
  provides_dialogue_rules: true
  provides_review_rubric: true
  provides_taboo: true
  provides_examples: true
---
```

推荐字段：

| 字段 | 含义 |
|------|------|
| supports_novel | 是否支持小说 |
| supports_script | 是否支持剧本 |
| supports_short_drama | 是否支持短剧剧本 |
| provides_style | 是否提供文风规则 |
| provides_structure | 是否提供结构规则 |
| provides_character_rules | 是否提供人物规则 |
| provides_dialogue_rules | 是否提供对白规则 |
| provides_review_rubric | 是否提供审查标准 |
| provides_taboo | 是否提供禁忌约束 |
| provides_examples | 是否提供示例 |

兼容规则：

- 缺少 `capabilities` 不阻断加载，但必须记录为“能力声明缺失”。
- 壳子可根据实际文件存在情况推断能力。
- 推断能力必须记录到 `GENRE-SKILL-LOCK.md`。
- 若某项能力缺失，可按 `docs/KNOWLEDGE-LAYERING.md` 使用全局兜底。

---

## 3.6 教辅类 Skill 扩展字段（可选）

教辅类 Skill 是题材 Skill 的可选扩展，不是所有 Skill 的强制要求。普通小说、剧本或短剧 Skill 即使没有本节字段，仍可按旧合约读取和加载；但不能声明自己支持教辅短剧完整生产。

本节只定义能力表达方式，不写具体篇目模板、不写具体教学法、不写具体剧本结构，也不把某个 Skill 的业务规则硬编码进合约。

### capabilities 扩展

教辅类 Skill 推荐在 `SKILL.md` frontmatter 的 `capabilities` 中声明以下字段：

```yaml
capabilities:
  supports_short_drama: true
  supports_edu_shortdrama: true
  supports_original_text_analysis: true
  supports_plain_translation: true
  supports_teaching_objectives: true
  supports_character_event_chain: true
  supports_scene_original_mapping: true
  supports_subtitle_plan: true
  supports_shotlist: true
  supports_video_risk_notes: true
  supports_teaching_review: true
  supports_production_package: true
```

字段说明：

| 字段 | 含义 | 是否必填 | 适用对象 | 备注 |
|---|---|---|---|---|
| `supports_edu_shortdrama` | 是否支持教辅短剧生产 | 否 | 教辅类 Skill | 为 `true` 时应同时声明相关教辅能力 |
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

### 教辅类 Skill 专项字段

教辅类 Skill 可以在 `SKILL.md` 或配套规则文件中声明以下字段或等价小节：

| 字段 | 含义 | 是否必填 | 示例 |
|---|---|---|---|
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

### fallback 规则要求

教辅类 Skill 应声明以下 fallback 行为：

- 原文缺失时：不得编造原文，应暂停并请求用户提供原文。
- 出处 / 年级缺失时：不得假定教材版本或学生层级，应标记为待补或请求用户确认。
- 文本不适合情境复演时：应说明不适配原因，并建议降级为讲解、注释、字幕或其他输出。
- 用户只要求部分产物时：只输出用户请求范围，并记录未生成产物。
- 能力未声明但模板中存在时：不得把模板字段当成 declaredCapabilities，应记录为 inferredCapabilities 或 missingCapabilities。
- 原文与用户创意冲突时：以原文事实和教学准确性优先，创意只能作为表现方式，不得覆盖原文事实。

### shellBoundary 规则要求

教辅类 Skill 必须明确 Skill 与 shell 的边界：

- Skill 只提供规则、模板、示例和审查标准。
- Skill 不创建项目。
- Skill 不修改 workflow。
- Skill 不绕过 Phase 门禁。
- Skill 不自动进入审查、修订、锁稿。
- Skill 不自动生成视频、图片或后置提示词。
- Skill 不替代用户确认。

### 教辅类 Skill 最小合格标准

一个教辅类 Skill 至少应具备：

- 明确适用文本类型。
- 明确不适用文本类型。
- 明确输入要求。
- 明确输出要求。
- 原文拆解规则。
- 原文与剧情 / Scene 映射规则。
- 禁忌规则。
- 审查标准。
- fallback 规则。
- shellBoundary。

如果缺少上述最小项，Skill 仍可作为普通题材 Skill 使用，但不应声明 `supports_edu_shortdrama: true` 或支持教辅短剧完整生产。

### 示例片段

以下是教辅类 Skill 的 frontmatter 示例片段，仅展示能力表达方式，不代表完整 Skill：

```yaml
---
name: wenyan-skill
version: 0.1.0
description: 文言文教辅真人古风短剧 Skill
capabilities:
  supports_short_drama: true
  supports_edu_shortdrama: true
  supports_original_text_analysis: true
  supports_plain_translation: true
  supports_teaching_objectives: true
  supports_character_event_chain: true
  supports_scene_original_mapping: true
  supports_subtitle_plan: true
  supports_shotlist: true
  supports_video_risk_notes: true
  supports_teaching_review: true
  supports_production_package: true
---
```

### 向后兼容说明

- 旧 Skill 如果没有教辅扩展字段，仍可按旧合约读取。
- 缺少教辅扩展字段不阻断普通 Skill 加载。
- 旧 Skill 不能因为文件中存在模板或示例，就声明自己支持教辅短剧完整生产。
- loader 或人工审计应把缺失字段记录到 `GENRE-SKILL-LOCK.md`。
- 不得用推断能力冒充 `declaredCapabilities`。
- 推断得到的能力应记录为 `inferredCapabilities`，并与 `declaredCapabilities` 分开。

---

## 4. Genre-Loader 加载流程

```
1. 扫描 genre-skills/ 目录
2. 列出所有可用题材 Skill（有 SKILL.md 的目录）
3. 用户选择题材
4. 检查文件完整性（SKILL.md 必须存在）
5. 读取 capabilities；如缺失则根据文件存在情况推断能力
6. 记录缺失文件和缺失能力列表
7. 如果缺失文件 → 告知用户并询问是否继续
8. 读取所有可用文件，生成 GENRE-SKILL-LOCK.md
9. 生成或提示生成 SKILL-LOCK-MANIFEST.sha256
10. 锁定题材（同一项目不允许中途切换题材）
```

---

## 5. 题材 Skill 的权限边界

题材 Skill **可以**：
- 提供题材写作规则
- 提供结构规则
- 提供人物规则
- 提供对白规则
- 提供风格规则
- 提供禁忌规则
- 提供模板和示例
- 提供审查标准

题材 Skill **不可以**：
- 直接创建项目目录
- 直接锁稿
- 直接调用后置模块
- 绕过审查阶段
- 自动进入审查、修订或锁稿
- 自动生成视频、图片或后置提示词
- 替代用户确认
- 修改 workflow/ORCHESTRATION.md
- 修改 hooks
- 修改其他题材 Skill
- 写入项目目录

---

## 6. GENRE-SKILL-LOCK.md 格式

```markdown
# 题材 Skill 锁定记录

- 项目名：
- 题材 Skill：
- Skill 版本：
- Skill 路径：
- 加载时间：
- 已读取文件：
- 能力声明：
- declaredCapabilities：
- inferredCapabilities：
- 缺失能力：
- 缺失文件：
- 降级策略：
- fallbackRules：
- shellBoundary：
- 当前状态：已锁定 / 未锁定
```

锁定后推荐同时生成：

```text
projects/<project-name>/locked/SKILL-LOCK-MANIFEST.sha256
```

该文件记录题材 Skill 文件的 sha256，用于检测项目锁定后 Skill 是否发生漂移。

锁定后状态对应的行为：
- **未锁定** → 禁止进入 Phase 2（故事企划）
- **已锁定** → 允许进入后续阶段

---

## 7. 题材切换规则

- 同一项目**不允许**中途切换题材 Skill
- 如需切换题材，必须新建项目
- 或者用户明确确认「放弃当前项目、重新锁定新题材」

---

## 8. 无题材 Skill 时的行为

如果 `genre-skills/` 下没有可用题材 Skill：
- genre-loader 提示用户放入题材 Skill
- 或询问用户是否使用"通用占位模式"（仅基础规则，无题材约束）
- 通用占位模式下，题材审查 agent 仅做基础逻辑审查

---

## 9. 不确定项

见 [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md)。
