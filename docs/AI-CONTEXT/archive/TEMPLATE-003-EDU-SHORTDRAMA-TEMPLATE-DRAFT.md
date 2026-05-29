# TEMPLATE-003：教辅短剧项目模板草案

- 完成日期：2026-05-28
- 任务类型：模板草案设计
- 模板文件修改：无
- 项目创建：无

本草案基于 `TEMPLATE-002` 字段方案、`TEMPLATE-001` 模板审计、`ARCH-002` Phase 映射、`SKILL-001` Skill 合约差距审计，以及对 `genre-skills/wenyan-skill/` 和 `projects/_template/` 的只读结果整理。本文档只是把字段方案转成可审阅的候选模板文本，不是实际模板落地。

## 1. 草案目标

本草案用于审阅文言文教辅真人古风短剧项目模板，不用于直接生成项目。

必须明确：

- 不修改 `projects/_template/`。
- 不创建专用模板目录。
- 不创建项目。
- 只是把 `TEMPLATE-002` 字段方案转成可审阅的模板文件草案。
- 本草案不替代后续用户确认、模板落地任务或验证任务。

## 2. 推荐模板形态

| 选项 | 判断 | 理由 |
|---|---|---|
| A. 扩展现有 `projects/_template` | 不推荐作为未来主路径 | 会把小说 / 剧本旧模板与教辅短剧模板耦合，容易影响现有验证预期和旧项目兼容性。 |
| B. 新增 `projects/_template-edu-shortdrama` | **主推荐方案** | 命名清晰，能隔离教辅短剧语义，保留 shell 状态 / 恢复 / 门禁机制，同时不破坏旧 `_template`。 |
| C. 新增 `projects/_edu-template` | 不推荐 | 命名不如 `_template-edu-shortdrama` 精确，后续可能和其他教辅模板混淆。 |
| D. 继续只保留文档方案 | 当前已经完成字段方案，不能作为长期主路径 | 可作为设计阶段过渡，但无法支撑后续创建教辅短剧项目。 |

推荐未来落地形态：**B. 新增 `projects/_template-edu-shortdrama`**。

本轮不创建该目录。推荐理由是：教辅短剧模板的文件显示语义、字段、审查维度和生产稿包边界已经明显区别于旧小说 / 剧本模板，独立模板可以降低破坏旧模板的风险。

## 3. 建议目录结构草案

未来候选模板目录结构：

```text
projects/_template-edu-shortdrama/
├── PROJECT.md
├── PROJECT-STATE.json
├── GENRE-SKILL-LOCK.md
├── PROJECT-MEMORY.md
├── RUN-LOG.md
├── materials/
│   └── README.md
├── specs/
│   └── STORY-SPEC.md
├── planning/
│   └── ENDING-LOCK.md
├── outlines/
│   └── OUTLINE.md
├── scripts/
│   └── SCRIPT-STATUS.md
├── reviews/
│   └── README.md
├── revisions/
│   ├── README.md
│   └── revision-log.md
├── locked/
│   ├── README.md
│   └── FINAL-SCRIPT.md
├── short-drama-shotlists/
│   └── README.md
├── seedance-prompts/
│   └── README.md
└── drafts/
    └── README.md
```

沿用旧目录：

- `PROJECT.md`、`PROJECT-STATE.json`、`GENRE-SKILL-LOCK.md`、`PROJECT-MEMORY.md`、`RUN-LOG.md`。
- `materials/`、`specs/`、`planning/`、`outlines/`、`scripts/`、`reviews/`、`revisions/`、`locked/`、`drafts/`。
- `short-drama-shotlists/` 和 `seedance-prompts/` 继续作为 Phase 8 后置输出接口。

改变显示语义：

- `specs/STORY-SPEC.md` 显示为“原文拆解与教学目标规格”。
- `planning/ENDING-LOCK.md` 显示为“原文结果与学习闭环锁定”。
- `outlines/OUTLINE.md` 显示为“情境复演结构与 Scene 映射”。
- `PROJECT-MEMORY.md` 显示为“项目长期记忆 / 教辅事实连续性”。
- `locked/` 显示为“生产稿包锁定区”。

未来可新增但本草案不强制新增：

- `ORIGINAL-MAPPING.md`
- `SUBTITLE-PLAN.md`
- `SHOTLIST-PLAN.md`
- `VIDEO-RISK-REPORT.md`
- `PRODUCTION-PACKAGE-MANIFEST.md`
- `subtitles/`
- `mappings/`
- `production-package/`

## 4. PROJECT.md 草案

````markdown
# 项目档案

本文件用于 Phase 0 项目建档。用户确认本文件前，不得进入 Phase 1 Skill 锁定。

## 基本信息

- 项目名称：
- 项目类型：教辅短剧 / 文言文情境复演
- 篇目标题：
- 出处：
- 教材版本：
- 年级：
- 目标学生：

## 原文

```text
待填写原文。
```

## 输出目标

- 视频时长：
- 输出目标：
- 输出范围：
- 是否需要字幕：是 / 否 / 待确认
- 是否需要分镜：是 / 否 / 待确认
- 是否需要视频生成提示词：是 / 否 / 待确认

## 风格与边界

- 目标风格：真人古风 / 教辅短剧 / 情境复演
- 禁止方向：
  - 不玄幻化。
  - 不恋爱化。
  - 不权谋化。
  - 不篡改原文事实。
  - 不把补充想象写成原文事实。

## Skill 与 Phase

- 当前 Skill：`genre-skills/wenyan-skill/`
- 当前 Phase：Phase 0 项目建档
- 下一 Phase：Phase 1 教辅 Skill 加载

## Phase 0 门禁

进入 Phase 1 前必须确认：

- 篇目标题已填写。
- 原文已提供或明确待补。
- 出处 / 教材版本 / 年级已填写或标记为待补。
- 输出目标和输出范围已明确。
- 用户已确认本文件。

## 用户确认状态

- 确认状态：未确认
- 确认人：
- 确认时间：
- 备注：
````

## 5. PROJECT-STATE.json 草案

```json
{
  "projectType": "edu-shortdrama",
  "skillId": "wenyan-skill",
  "phase": 0,
  "status": "initializing",
  "confirmedArtifacts": {
    "projectMd": false,
    "genreSkillLock": false,
    "storySpec": false,
    "endingLock": false,
    "outline": false,
    "originalTextAnalysis": false,
    "sceneMapping": false,
    "script": false,
    "subtitlePlan": false,
    "shotlistPlan": false,
    "teachingReview": false,
    "revisionLog": false,
    "finalScript": false,
    "productionPackage": false
  },
  "eduTextStatus": "not_started",
  "sceneMappingStatus": "not_started",
  "scriptStatus": "not_started",
  "subtitleStatus": "not_started",
  "shotlistStatus": "not_started",
  "reviewStatus": "not_started",
  "productionPackageStatus": "not_started",
  "lockedArtifacts": [],
  "lastUpdated": null,
  "notes": []
}
```

初始化说明：

- `phase` 初始为 `0`。
- `status` 初始为 `initializing`。
- 所有确认项初始为 `false`。
- 后置产物状态均为 `not_started`。
- `lockedArtifacts` 初始为空数组。

## 6. GENRE-SKILL-LOCK.md 草案

````markdown
# 教辅 Skill 锁定记录

本文件用于 Phase 1 锁定项目使用的教辅 Skill。用户确认本文件前，不得进入 Phase 2 原文拆解与教学目标规格。

## Skill 基本信息

- skillPath：`genre-skills/wenyan-skill/`
- skillName：
- skillVersion：
- lockStatus：未锁定

## 能力声明

### declaredCapabilities

- 待从 Skill 文件读取。

### inferredCapabilities

- 文言文原文拆解：
- 白话释义：
- 教学目标：
- 人物 / 事件链：
- Scene 与原文映射：
- 正片剧本：
- 字幕方案：
- 分镜 / 镜头表：
- 视频生成风险：
- 教学准确性审查：

### missingCapabilities

- 待记录缺失能力。

## 适用范围

### applicableTextTypes

- 文言文篇目：
- 古文寓言：
- 古代人物事件：
- 其他：

### unsupportedTextTypes

- 现代小说改编：
- 纯虚构玄幻：
- 恋爱向改写：
- 权谋爽剧化改写：
- 无原文依据的历史演绎：

## fallbackRules

如果 `wenyan-skill` 缺少 version / capabilities / fallback / shellBoundary：

- `skillVersion` 记录为“未声明，按当前文件快照锁定”。
- `declaredCapabilities` 记录为“未声明”。
- `inferredCapabilities` 只记录从已读文件可以推断的能力。
- `missingCapabilities` 明确列出缺失项。
- `fallbackRules` 记录为“待补充；当前遇到缺失能力时暂停并请求用户确认”。
- 不允许用推断能力冒充 Skill 已声明能力。

## shellBoundary

- Skill 只提供规则、模板和审查标准。
- Skill 不接管 workflow。
- Skill 不创建项目。
- Skill 不绕过 Phase 门禁。
- Skill 不自动生成视频、图片或后置提示词。
- Skill 不替代用户确认。

## 用户确认状态

- 确认状态：未确认
- 确认人：
- 确认时间：
- 备注：
````

## 7. specs/STORY-SPEC.md 草案

显示名：**原文拆解与教学目标规格**

````markdown
# 原文拆解与教学目标规格

本文件用于 Phase 2。用户确认本文件后，才允许进入 Phase 3 情境复演结构设计。

## 原文

```text
待填写原文。
```

## 逐句拆解表

| 编号 | 原文句子 | 关键词 / 实词 | 虚词 / 句式 | 白话释义 | 教学提示 | 不确定项 |
|---|---|---|---|---|---|---|
| 1 |  |  |  |  |  |  |

## 白话释义

- 整体释义：
- 逐段释义：
- 不确定释义：

## 人物 / 事件链

| 人物 / 对象 | 原文依据 | 行为 / 状态 | 事件顺序 | 可复演性 | 风险 |
|---|---|---|---|---|---|
|  |  |  |  |  |  |

## 学习难点

- 字词难点：
- 句式难点：
- 文化背景：
- 容易误读点：

## 教学目标

- 知识目标：
- 能力目标：
- 情感 / 审美目标：
- 视频观看后应掌握：

## 不可改写事实

- 不得改写的原文事实：
- 不得添加为事实的推断：
- 不得提前揭示的结论：

## 主题 / 考点

- 主题：
- 考点：
- 适合在字幕中提示的知识点：
- 不适合在剧情中过度解释的知识点：

## 情境复演适配判断

- 是否适合情境复演：
- 适合复演的片段：
- 不适合复演的片段：
- 复演边界：

## 不适配风险

- 原文过短风险：
- 角色不足风险：
- 场景不可视化风险：
- 教学目标被剧情稀释风险：

## 用户确认状态

- 确认状态：未确认
- 确认人：
- 确认时间：
- 备注：
````

## 8. planning/ENDING-LOCK.md 草案

显示名：**原文结果与学习闭环锁定**

短期保留 `ENDING-LOCK.md` 文件名是为了兼容旧 Phase / 状态语义。未来可评估是否改名为 `TEXT-LOCK.md`、`LEARNING-LOCK.md` 或 `ORIGINAL-FACT-LOCK.md`。

```markdown
# 原文结果与学习闭环锁定

本文件用于 Phase 3 前后的关键结论锁定。它不是小说结局锁定，而是原文事实、主题和学习闭环的锁定。

## 原文结果锁定

- 原文最终结果：
- 原文事实依据：
- 不可改写边界：

## 主题锁定

- 核心主题：
- 主题依据：
- 不可偏移方向：

## 学习闭环锁定

- 视频开始时学生应看到：
- 视频中段应理解：
- 视频结尾应掌握：
- 最终教学闭环：

## 不可误读点

- 不可误读点 1：
- 不可误读点 2：
- 对应原文依据：

## 不可提前解释点

- 需要保留到结尾解释的点：
- 不应在开头直接讲明的点：
- 原因：

## 不可改写事实

- 原文事实：
- 禁止改写方式：
- 允许的表现方式：

## 用户确认状态

- 确认状态：未确认
- 确认人：
- 确认时间：
- 备注：
```

## 9. outlines/OUTLINE.md 草案

显示名：**情境复演结构与 Scene 映射**

```markdown
# 情境复演结构与 Scene 映射

本文件用于 Phase 3。用户确认 `OUTLINE.md` 后，才允许进入 Phase 4 正片剧本生成。

## 结构目标

- 总时长：
- Scene 数量：
- 主要场景：
- 教学闭环：

## Scene 映射表

| Scene 编号 | Scene 时长 | 场景 | 人物 | 对应原文 | 白话释义 | 剧情功能 | 知识功能 | 字幕要点 | 分镜提示 | 视频生成风险 |
|---|---:|---|---|---|---|---|---|---|---|---|
| S01 |  |  |  |  |  |  |  |  |  |  |

## Scene 顺序说明

- 开场 Scene：
- 发展 Scene：
- 转折 Scene：
- 学习闭环 Scene：

## 字幕要点汇总

- 必须出现的原文：
- 必须出现的白话提示：
- 不应过早出现的解释：

## 分镜提示汇总

- 可生产镜头：
- 高风险镜头：
- 建议规避的镜头：

## 用户确认状态

- 确认状态：未确认
- 确认人：
- 确认时间：
- 备注：
```

## 10. scripts/SCRIPT-STATUS.md 草案

```markdown
# 正片剧本状态

本文件用于记录 Phase 4 正片剧本、原文映射、字幕方案和分镜草案的状态。不得用本文件绕过审查、修订或锁稿门禁。

## 状态总览

| 项目 | 状态 | 备注 |
|---|---|---|
| 正片剧本状态 | 未开始 |  |
| 原文映射表状态 | 未开始 |  |
| 字幕方案状态 | 未开始 |  |
| 分镜草案状态 | 未开始 |  |
| 审查准入 | 不允许 |  |
| 修订准入 | 不允许 |  |
| 锁稿准入 | 不允许 |  |

## 正片剧本状态

- 是否完成：否
- 剧本路径：
- 原文映射是否同步：
- 字幕方案是否同步：
- 分镜草案是否同步：

## 原文映射表状态

- 是否完成：否
- 覆盖 Scene：
- 缺失原文：
- 待确认项：

## 字幕方案状态

- 是否完成：否
- 字幕类型：原文字幕 / 白话字幕 / 知识点字幕
- 可读性风险：

## 分镜草案状态

- 是否完成：否
- 是否绑定 Scene：
- 是否绑定原文：
- 是否标记视频风险：

## 审查准入

- 是否允许进入 Phase 5：否
- 准入条件：
  - 正片剧本完成。
  - 原文映射表完成。
  - 字幕方案完成或明确不需要字幕。
  - 分镜草案完成或明确不需要分镜。
  - 用户确认进入审查。

## 修订准入

- 是否允许进入 Phase 6：否
- 条件：Phase 5 审查完成，且用户确认修订范围。

## 锁稿准入

- 是否允许进入 Phase 7：否
- 条件：修订完成，审查通过，用户确认锁定生产稿包。

## 用户确认状态

- 确认状态：未确认
- 确认人：
- 确认时间：
- 备注：

## 禁止事项

- 禁止自动进入审查。
- 禁止自动进入修订。
- 禁止自动锁稿。
- 禁止用占位 `final-review.md` 或空文件通过门禁。
```

## 11. PROJECT-MEMORY.md 草案

显示名：**项目长期记忆 / 教辅事实连续性**

```markdown
# 项目长期记忆 / 教辅事实连续性

本文件记录项目级稳定事实。它不替代 `wenyan-skill` 的通用规则，只记录本项目已经确认的事实、偏好、映射和变更。

## 当前项目事实

- 篇目标题：
- 出处：
- 教材版本：
- 年级：
- 目标学生：
- 输出目标：
- 当前 Skill：
- 当前 Phase：

## 原文事实表

| 编号 | 原文事实 | 原文依据 | 是否确认 | 备注 |
|---|---|---|---|---|
| F001 |  |  | 否 |  |

## 句意解释表

| 编号 | 原文句子 | 解释 | 是否确认 | 不确定项 |
|---|---|---|---|---|
| M001 |  |  | 否 |  |

## 教学点表

| 编号 | 教学点 | 对应原文 | 教学目标 | 是否确认 |
|---|---|---|---|---|
| T001 |  |  |  | 否 |

## 角色映射表

| 角色 | 原文依据 | 剧中功能 | 不可改写边界 |
|---|---|---|---|
|  |  |  |  |

## Scene / 场景映射表

| Scene | 场景 | 对应原文 | 知识功能 | 风险 |
|---|---|---|---|---|
| S01 |  |  |  |  |

## 字幕规则

- 原文字幕规则：
- 白话字幕规则：
- 知识点字幕规则：
- 字幕长度限制：

## 分镜与视频风险

- 高风险镜头：
- 不建议生成的画面：
- 需要人工确认的镜头：

## 用户偏好

- 风格偏好：
- 节奏偏好：
- 字幕偏好：
- 分镜偏好：

## 已确认产物

| 产物 | 路径 | 确认状态 | 确认时间 |
|---|---|---|---|
|  |  |  |  |

## 不可改写知识结论

- 结论 1：
- 结论 2：

## 变更记录

| 时间 | 变更内容 | 影响范围 | 用户是否确认 |
|---|---|---|---|
|  |  |  |  |
```

## 12. reviews/README.md 草案

显示名：**教学与生产审查**

```markdown
# 教学与生产审查

本目录用于 Phase 5。审查必须基于已完成的正片剧本、原文映射、字幕方案和分镜草案。不得手动创建占位 `final-review.md` 来通过门禁。

## 审查维度

| 维度 | 检查问题 | 是否通过 | 阻断项 | 修改建议 |
|---|---|---|---|---|
| 原文准确性 | 是否篡改或误解原文事实 |  |  |  |
| 白话释义准确性 | 释义是否准确、不过度发挥 |  |  |  |
| Scene 与原文映射 | 每个 Scene 是否有明确原文依据 |  |  |  |
| 教学目标达成 | 视频结构是否服务教学目标 |  |  |  |
| 字幕可读性 | 字幕是否简洁、可读、时机合适 |  |  |  |
| 镜头可生产性 | 镜头是否适合真人古风短剧生产 |  |  |  |
| 视频生成风险 | 是否存在难生成、易误解或高成本镜头 |  |  |  |
| taboo 触发项 | 是否玄幻化、恋爱化、权谋化或篡改原文 |  |  |  |

## 审查结论

- 是否通过：否
- 阻断项：
- 修改建议：
- 是否允许进入 Phase 6：否

## 禁止事项

- 禁止手动创建占位 `final-review.md`。
- 禁止未完成审查直接进入修订。
- 禁止未通过审查直接锁稿。
```

## 13. revisions/ 草案

### revisions/README.md 草案

```markdown
# 修订目录

本目录用于 Phase 6。所有修订必须对应明确审查问题，并记录是否影响原文事实、教学目标、字幕或分镜。

## 修订规则

- 修订前必须有审查结论或用户明确要求。
- 影响原文事实的修订必须同步更新 `PROJECT-MEMORY.md`。
- 影响教学目标的修订必须同步更新 `specs/STORY-SPEC.md` 或相关确认记录。
- 影响字幕或分镜的修订必须同步更新对应方案。
- 修订完成后必须等待用户确认是否进入锁稿。

## 用户确认状态

- 确认状态：未确认
- 确认人：
- 确认时间：
- 备注：
```

### revisions/revision-log.md 草案

```markdown
# 修订日志

| 编号 | 修订对象 | 修订原因 | 对应审查问题 | 是否影响原文事实 | 是否影响教学目标 | 是否影响字幕 | 是否影响分镜 | 修订前摘要 | 修订后摘要 | 用户确认状态 |
|---|---|---|---|---|---|---|---|---|---|---|
| R001 |  |  |  | 否 | 否 | 否 | 否 |  |  | 未确认 |

## 当前修订结论

- 是否完成修订：否
- 是否允许进入 Phase 7：否
- 待用户确认事项：
```

## 14. locked/ 草案

### locked/README.md 草案

```markdown
# 生产稿包锁定区

本目录用于 Phase 7。`FINAL-SCRIPT.md` 只代表最终剧本，不代表完整生产稿包。

完整生产稿包还应包含：

- 原文映射表
- 字幕方案
- 分镜方案
- 视频风险说明
- 审查结论
- 修订记录
- Skill 锁定信息
- manifest

## 锁定规则

- 未经用户确认不得锁稿。
- 审查未通过不得锁稿。
- 修订未完成不得锁稿。
- 锁定后不得自动修改生产稿包。

## 建议未来生产稿包文件清单

- `FINAL-SCRIPT.md`
- `ORIGINAL-MAPPING.md`
- `SUBTITLE-PLAN.md`
- `SHOTLIST-PLAN.md`
- `VIDEO-RISK-REPORT.md`
- `FINAL-REVIEW.md`
- `REVISION-SUMMARY.md`
- `SKILL-LOCK-SNAPSHOT.md`
- `PRODUCTION-PACKAGE-MANIFEST.md`
```

### locked/FINAL-SCRIPT.md 草案

```markdown
# 最终剧本

本文件只锁定最终正片剧本，不代表完整生产稿包。完整生产稿包还必须同步锁定原文映射、字幕、分镜、视频风险、审查结论、修订记录和 Skill 锁定信息。

## 锁定信息

- 锁定状态：未锁定
- 锁定时间：
- 锁定人：
- 对应 Skill：
- 对应审查结论：
- 对应修订记录：

## 正片剧本

待锁定。

## 原文映射摘要

- 完整映射文件：
- 缺失项：

## 字幕摘要

- 完整字幕方案：
- 缺失项：

## 分镜摘要

- 完整分镜方案：
- 高风险镜头：

## 锁定后禁止事项

- 禁止自动改写剧本。
- 禁止自动改写原文映射。
- 禁止自动生成视频提示词，除非用户明确要求。
```

## 15. materials/README.md 草案

```markdown
# 项目素材

本目录用于存放原文、注释、教材版本、用户资料、参考视频和风格参考。

## 可存放内容

- 原文
- 注释
- 教材版本
- 用户资料
- 参考视频
- 风格参考
- 临时材料

## 规则

- `materials/` 中的内容不是稳定事实。
- 素材必须经过 Phase 2 或写入 `PROJECT-MEMORY.md` 并由用户确认后，才成为后续必须遵守的项目事实。
- 不要把 `wenyan-skill` 的通用规则复制到本目录。
- 引用素材时应记录来源。
```

## 16. short-drama-shotlists/README.md 草案

```markdown
# 教辅短剧分镜

本目录是教辅短剧分镜主目录，用于 Phase 8 或用户明确要求后的后置输出。

## 启用条件

- 默认不自动生成。
- 必须在锁稿后或用户明确确认后生成。
- 分镜必须绑定 Scene、原文、知识功能和视频风险。

## 分镜字段

| 镜头 | Scene | 对应原文 | 知识功能 | 画面 | 景别 | 运镜 | 字幕 | 视频风险 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| 1 |  |  |  |  |  |  |  |  |  |

## 禁止事项

- 禁止未锁稿自动生成分镜。
- 禁止脱离原文映射生成镜头。
- 禁止忽略视频生成风险。
```

## 17. seedance-prompts/README.md 草案

```markdown
# Seedance 提示词

本目录用于可选的视频生成提示词。默认关闭。

## 启用条件

- 默认关闭。
- 不自动生成视频提示词。
- 不自动生成图片或视频。
- 只有用户明确要求时才生成。
- 必须基于锁定剧本、分镜和视频风险说明。

## 禁止事项

- 禁止未锁稿生成 Seedance 提示词。
- 禁止跳过分镜直接生成视频提示词。
- 禁止生成与原文事实冲突的画面。
- 禁止把高风险镜头包装成可直接生成镜头。
```

## 18. 可选新增文件建议

| 文件 | 建议位置 | 是否建议未来新增 | 说明 |
|---|---|---|---|
| `ORIGINAL-MAPPING.md` | `locked/` 或 `mappings/` | 建议 | 用于锁定原文句子、Scene、对白、字幕之间的对应关系。 |
| `SUBTITLE-PLAN.md` | `locked/` 或 `scripts/` | 建议 | 用于锁定原文字幕、白话字幕和知识点字幕方案。 |
| `SHOTLIST-PLAN.md` | `locked/` 或 `short-drama-shotlists/` | 建议 | 用于锁定分镜方案；后续可复制到分镜目录继续扩展。 |
| `VIDEO-RISK-REPORT.md` | `locked/` 或 `reviews/` | 建议 | 用于集中记录视频生成风险和规避建议。 |
| `PRODUCTION-PACKAGE-MANIFEST.md` | `locked/` | 强烈建议 | 用于声明最终生产稿包包含哪些文件，以及每个文件的锁定状态。 |

本草案只列出建议，不创建上述文件。

## 19. 与现有 projects/_template 的差异总结

| 原模板文件 | 教辅草案变化 | 是否破坏旧模板兼容性 | 建议落地方式 |
|---|---|---|---|
| `PROJECT.md` | 从故事项目档案改为教辅短剧项目建档，新增篇目、原文、教材版本、年级、输出目标等字段 | 如果直接改旧模板会破坏兼容性 | 放入新模板目录 |
| `PROJECT-STATE.json` | 新增 `projectType`、教辅产物状态、生产稿包状态和锁定产物数组 | 直接改可能影响 validate 预期 | 放入新模板目录，后续再补验证 |
| `GENRE-SKILL-LOCK.md` | 强化 Skill version、capabilities、fallback、shellBoundary 记录 | 不必破坏旧模板，但语义更偏教辅 | 新模板独立维护 |
| `PROJECT-MEMORY.md` | 从小说连续性改为教辅事实连续性 | 直接改旧模板会改变旧项目使用方式 | 新模板独立维护 |
| `specs/STORY-SPEC.md` | 显示名改为原文拆解与教学目标规格 | 文件名可兼容，内容语义变化大 | 新模板内保留文件名、改显示语义 |
| `planning/ENDING-LOCK.md` | 显示名改为原文结果与学习闭环锁定 | 文件名可兼容，旧语义不适合教辅 | 新模板内保留文件名、改显示语义 |
| `outlines/OUTLINE.md` | 改为 Scene 与原文映射 | 旧大纲语义会被改变 | 新模板内独立维护 |
| `scripts/SCRIPT-STATUS.md` | 增加原文映射、字幕、分镜、审查准入状态 | 可兼容但字段更多 | 新模板独立维护 |
| `reviews/` | 审查维度改为教学准确性与生产可行性 | 旧审查维度不足 | 新模板内提供 README |
| `revisions/` | 修订日志增加对教学事实、字幕、分镜影响判断 | 可兼容但语义更细 | 新模板内提供 README 和 revision-log |
| `locked/FINAL-SCRIPT.md` | 明确只代表最终剧本，不代表完整生产稿包 | 直接改旧模板会改变锁稿理解 | 新模板内独立维护 |
| `short-drama-shotlists/` | 成为教辅短剧分镜主目录 | 旧模板中已是预留接口 | 新模板强化 README |
| `seedance-prompts/` | 继续默认关闭，必须用户明确要求 | 与旧模板兼容 | 新模板强化边界说明 |
| `materials/` | 明确素材不是稳定事实，必须经过 Phase 2 或 PROJECT-MEMORY 确认 | 与旧模板兼容 | 新模板强化 README |

## 20. 推荐后续任务

主任务建议：**TEMPLATE-004：由用户确认后落地教辅短剧模板目录**。

推荐顺序：

1. `TEMPLATE-004`：由用户确认后落地 `projects/_template-edu-shortdrama/` 候选模板目录。
2. `CONTRACT-001`：扩展 Skill 合约，让 capabilities 能表达教辅生产能力。
3. `WORKFLOW-DOC-001`：更新 workflow 文档语义，说明 Phase 映射与教辅解释。
4. `VALIDATE-001`：运行现有校验基线，记录当前验证结果。

本轮不执行上述后续任务。

## 21. 明确结论

- `TEMPLATE-003` 已完成的是模板草案文档。
- 本轮没有修改 `projects/_template/`。
- 本轮没有创建 `projects/_template-edu-shortdrama/`。
- 本轮没有创建 `projects/_edu-template/`。
- 本轮没有修改 `workflow/`、`scripts/`、`genre-skills/` 或 `projects/`。
- 推荐未来落地方式是新增 `projects/_template-edu-shortdrama/`，但必须由用户确认后另开 `TEMPLATE-004` 执行。
- 下一步建议是 `TEMPLATE-004`。
