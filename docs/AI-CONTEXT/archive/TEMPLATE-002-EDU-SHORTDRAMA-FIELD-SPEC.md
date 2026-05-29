# TEMPLATE-002：教辅短剧项目模板字段方案

- 完成日期：2026-05-28
- 任务类型：字段方案设计
- 模板文件修改：无

本方案基于 `TEMPLATE-001` 审计结果、`ARCH-002` Phase 映射、`SKILL-001` 合约差距审计、`docs/GENRE-SKILL-CONTRACT.md`、`genre-skills/wenyan-skill/` 和 `projects/_template/` 的只读结果整理。本轮只设计字段、文件语义、生产稿包边界和状态字段，不修改任何模板文件，不创建新模板目录。

## 1. 设计目标

本方案解决的问题：

- 将现有小说 / 剧本项目模板映射到教辅短剧生产流程。
- 保留 shell 的状态、恢复、门禁和锁稿机制。
- 为后续是否修改 `projects/_template` 或新增模板变体提供依据。
- 明确文言文教辅真人古风短剧项目需要哪些项目级事实、状态字段、产物边界和锁定规则。
- 不在本轮修改任何模板文件。

## 2. 设计原则

- 不破坏旧小说 / 剧本项目模板兼容性。
- 不把教辅规则硬编码进 shell。
- 教辅细则优先来自 `wenyan-skill`。
- 项目模板只承载项目级事实、状态、产物和锁定边界。
- Phase 编号短期继续保留。
- 只设计字段，不执行落地。
- 所有跨阶段推进仍需用户确认。
- `projects/_template` 的状态 / 恢复 / 门禁机制优先保留，不因业务迁移直接删除。

## 3. 推荐模板路径判断

| 选项 | 判断 | 理由 |
|---|---|---|
| A. 直接扩展现有 `projects/_template` | 暂不推荐 | 旧模板仍服务小说 / 剧本项目，直接改会破坏兼容性和现有验证预期。 |
| B. 新增 `projects/_template-edu-shortdrama` | 后续候选 | 名称清楚，适合未来承载教辅短剧专用模板，但本轮不创建。 |
| C. 新增 `projects/_edu-template` | 不推荐 | 命名不如 `_template-edu-shortdrama` 明确，容易和通用模板层级混淆。 |
| D. 先不修改模板，只保留字段方案 | **本轮推荐** | 当前需要先稳定字段、文件语义和产物边界，再决定落地路径。 |

明确推荐：**D. 先不修改模板，只保留字段方案。**

理由：当前字段边界刚完成设计，尚未验证是否会影响旧小说 / 剧本项目模板和 validate 脚本。下一步应先生成教辅短剧模板草案文档，再由用户确认是否落到新目录或扩展现有模板。

## 4. Phase 0-8 字段方案总表

| Phase | 教辅短剧语义 | 主要产物 | 推荐承载文件 | 新增字段 | 是否必须确认后进入下一阶段 |
|---|---|---|---|---|---|
| Phase 0 | 项目建档 | 项目档案、原文资料、目标说明 | `PROJECT.md`、`materials/`、`PROJECT-STATE.json` | 篇目标题、原文、出处、教材版本、年级、视频时长、输出目标、输出范围 | 是 |
| Phase 1 | 教辅 Skill 加载 | Skill 锁定记录、能力缺口、降级策略 | `GENRE-SKILL-LOCK.md`、`PROJECT-STATE.json` | skillId、skillVersion、declaredCapabilities、inferredCapabilities、fallbackRules、shellBoundary | 是 |
| Phase 2 | 原文拆解 / 教学目标 | 原文拆解与教学目标规格 | `specs/STORY-SPEC.md` | 逐句拆解、白话释义、人物事件链、学习难点、教学目标、不可改写事实 | 是 |
| Phase 3 | 情境复演结构设计 | Scene 映射、时间结构、知识功能 | `outlines/OUTLINE.md`、`planning/ENDING-LOCK.md` | Scene 编号、时长、场景、人物、对应原文、字幕要点、视频风险 | 是 |
| Phase 4 | 正片剧本生成 | 正片剧本、原文映射表、字幕方案草案、分镜草案 | `scripts/`、`scripts/SCRIPT-STATUS.md` | scriptStatus、sceneMappingStatus、subtitleStatus、shotlistStatus | 是 |
| Phase 5 | 教学与生产审查 | 审查报告、阻断项、修改建议 | `reviews/` | 原文准确性、释义准确性、Scene 映射、字幕可读性、镜头可生产性、taboo 触发项 | 是 |
| Phase 6 | 修订与校正 | 修订日志、快照、候选稿 | `revisions/`、`drafts/rewrite-candidates/`、`PROJECT-MEMORY.md` | 修订对象、修订原因、影响原文事实、影响教学目标、影响字幕 / 分镜 | 是 |
| Phase 7 | 最终生产稿包锁定 | 生产稿包、锁定清单、manifest | `locked/` | lockedArtifacts、productionPackageStatus、生产稿包 manifest、锁定后禁止事项 | 是 |
| Phase 8 | 分镜 / 字幕 / 视频说明 | 短剧分镜、视频提示词、后置说明 | `short-drama-shotlists/`、`seedance-prompts/`、`shotlists/` | 后置输出类型、启用状态、用户确认、视频生成风险 | 是 |

## 5. PROJECT.md 字段方案

建议显示名：`项目档案`，保留文件名 `PROJECT.md`。

### 必填字段

- 项目名称
- 项目类型：教辅短剧 / 文言文情境复演 / 其他
- 篇目标题
- 原文
- 出处
- 年级
- 目标学生
- 视频时长
- 输出目标
- 输出范围
- 当前 Skill
- 当前 Phase
- 用户确认状态

### 选填字段

- 教材版本
- 是否需要字幕
- 是否需要分镜
- 是否需要视频生成提示词
- 目标风格
- 禁止方向
- 平台 / 画幅 / 时长偏好
- 参考资料路径

### 可后补字段

- 详细注释
- 教师补充要求
- 视频平台发布要求
- 特殊审查要求
- 生产工具偏好

### 字段说明

- `输出范围` 用于区分只生成剧本、字幕、分镜、视频风险说明或全套生产稿。
- `禁止方向` 应记录项目级禁忌，例如不得玄幻化、恋爱化、权谋化、改写原文事实。
- `用户确认状态` 是进入 Phase 1 前的门禁依据。

## 6. PROJECT-STATE.json 字段方案

### 可复用旧字段

- `project`
- `phase`
- `status`
- `genreSkill`
- `genreSkillVersion`
- `locked`
- `confirmedArtifacts.projectMd`
- `confirmedArtifacts.genreSkillLock`
- `confirmedArtifacts.storySpec`
- `confirmedArtifacts.outline`
- `confirmedArtifacts.finalReview`
- `confirmedArtifacts.revisionLog`
- `confirmedArtifacts.finalScript`
- `notes`

### 建议新增字段

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
    "productionPackage": false
  },
  "eduTextStatus": "not_started",
  "sceneMappingStatus": "not_started",
  "scriptStatus": "not_started",
  "subtitleStatus": "not_started",
  "shotlistStatus": "not_started",
  "reviewStatus": "not_started",
  "productionPackageStatus": "not_locked",
  "lockedArtifacts": [],
  "lastUpdated": "待填写",
  "notes": "待填写"
}
```

### 状态字段建议

- `eduTextStatus`：`not_started` / `drafted` / `confirmed` / `needs_revision`
- `sceneMappingStatus`：`not_started` / `drafted` / `confirmed` / `needs_revision`
- `scriptStatus`：`not_started` / `drafting` / `completed_waiting_review` / `reviewed` / `locked`
- `subtitleStatus`：`not_started` / `drafted` / `reviewed` / `locked`
- `shotlistStatus`：`not_started` / `drafted` / `reviewed` / `locked`
- `reviewStatus`：`not_started` / `in_progress` / `passed` / `needs_revision` / `blocked`
- `productionPackageStatus`：`not_started` / `drafted` / `ready_to_lock` / `locked`

## 7. GENRE-SKILL-LOCK.md 字段方案

建议保留文件名 `GENRE-SKILL-LOCK.md`，显示名可解释为“教辅 Skill 锁定记录”。

必须包含：

- `skillPath`
- `skillName`
- `skillVersion`
- `declaredCapabilities`
- `inferredCapabilities`
- `missingCapabilities`
- `fallbackRules`
- `applicableTextTypes`
- `unsupportedTextTypes`
- `shellBoundary`
- `lockStatus`

### wenyan-skill 当前缺口记录方式

- `skillVersion`：如果 `SKILL.md` 未声明 version，记录为“未声明，按文件快照或 manifest 锁定”。
- `declaredCapabilities`：如果缺少 capabilities，记录为“未声明”。
- `inferredCapabilities`：根据文件推断原文拆解、白话释义、Scene 映射、字幕、分镜、视频风险、教学审查等能力。
- `missingCapabilities`：记录当前合约无法表达或 Skill 未声明的能力。
- `fallbackRules`：若 Skill 未明确 fallback，记录为“待补充；当前按用户确认降级”。
- `shellBoundary`：记录“Skill 只提供规则、模板和审查标准，不创建项目、不修改 workflow、不绕过 Phase 门禁、不直接调用后置模块”。

## 8. specs/STORY-SPEC.md 字段方案

建议新显示名：**原文拆解与教学目标规格**。

文件名短期可保留 `STORY-SPEC.md`，用于兼容旧 Phase 2 和现有状态字段；未来可评估是否新增 `original-text-analysis.md`。

必须包含：

- 原文
- 逐句拆解
- 白话释义
- 人物 / 事件链
- 学习难点
- 教学目标
- 不可改写事实
- 主题 / 考点
- 情境复演适配判断
- 不适配风险
- 用户确认状态

建议结构：

- 项目信息
- 原文与来源
- 逐句拆解表
- 人物 / 事件链
- 学习难点
- 教学目标
- 不可改写事实
- 情境复演适配判断
- 不适配风险
- 用户确认区

## 9. planning/ENDING-LOCK.md 字段方案

建议短期保留文件名 `ENDING-LOCK.md`，但显示名改为：**原文结果与学习闭环锁定**。

理由：旧 workflow 和项目状态仍可能依赖 `endingLock` 概念；短期改文件名风险高。未来可评估新增或改名为 `TEXT-LOCK.md`、`LEARNING-LOCK.md` 或 `ORIGINAL-FACT-LOCK.md`。

必须设计：

- 原文结果锁定
- 主题锁定
- 学习闭环锁定
- 不可误读点
- 不可提前解释点
- 不可改写事实
- 用户确认状态

字段说明：

- `原文结果锁定` 替代旧“最终结局事实”。
- `主题锁定` 替代旧“核心真相”。
- `学习闭环锁定` 替代旧“情绪落点”。
- `不可提前解释点` 用于控制视频中何时揭示结论或考点，避免一开始直接讲答案导致情境复演失效。

## 10. outlines/OUTLINE.md 字段方案

建议新显示名：**情境复演结构与 Scene 映射**。

必须包含：

- Scene 编号
- Scene 时长
- 场景
- 人物
- 对应原文
- 白话释义
- 剧情功能
- 知识功能
- 字幕要点
- 分镜提示
- 视频生成风险
- 用户确认状态

建议表格字段：

| Scene | 时长 | 场景 | 人物 | 对应原文 | 白话释义 | 剧情功能 | 知识功能 | 字幕要点 | 分镜提示 | 视频风险 |
|---|---:|---|---|---|---|---|---|---|---|---|

门禁说明：用户确认 `OUTLINE.md` 后，才允许进入 Phase 4 正片剧本生成。

## 11. scripts/SCRIPT-STATUS.md 字段方案

必须包含：

- 正片剧本是否完成
- 原文映射表是否完成
- 字幕方案是否完成
- 分镜草案是否完成
- 是否允许进入审查
- 是否允许进入修订
- 是否允许进入锁稿
- 用户确认状态

建议状态字段：

| 字段 | 值 |
|---|---|
| 正片剧本状态 | 未开始 / 生成中 / 已完成待确认 / 已确认 |
| 原文映射表状态 | 未开始 / 已生成 / 待修订 / 已确认 |
| 字幕方案状态 | 未开始 / 已生成 / 待修订 / 已确认 |
| 分镜草案状态 | 未开始 / 已生成 / 待修订 / 已确认 |
| 审查准入 | 不允许 / 待用户确认 / 允许 |
| 修订准入 | 不允许 / 待用户选择范围 / 允许 |
| 锁稿准入 | 不允许 / 待用户确认 / 允许 |

保留旧状态值中的“正文已完成，待用户确认进入 Phase 5”“审查完成，待用户确认进入 Phase 6”“已锁稿”等门禁语义。

## 12. PROJECT-MEMORY.md 字段方案

建议新显示名：**项目长期记忆 / 教辅事实连续性**。

必须包含：

- 原文事实
- 句意解释
- 教学点
- 角色映射
- 场景映射
- 字幕规则
- 分镜风险
- 用户偏好
- 已确认产物
- 不可改写知识结论
- 变更记录

建议结构：

- 当前项目事实
- 原文事实表
- 句意解释表
- 教学点表
- 角色映射表
- Scene / 场景映射表
- 字幕规则
- 分镜与视频风险
- 用户偏好
- 已确认产物
- 不可改写知识结论
- 变更记录

说明：`PROJECT-MEMORY.md` 仍是项目级事实源，不替代 `wenyan-skill` 的通用规则。

## 13. reviews/ 字段方案

建议将 Phase 5 审查显示名改为：**教学与生产审查**。

必须包含：

- 原文准确性
- 白话释义准确性
- Scene 与原文映射
- 教学目标达成
- 字幕可读性
- 镜头可生产性
- 视频生成风险
- taboo 触发项
- 是否通过
- 阻断项
- 修改建议

建议审查文件：

- `teaching-accuracy-review.md`
- `scene-mapping-review.md`
- `subtitle-review.md`
- `production-feasibility-review.md`
- `final-review.md`

短期可不新增文件，只在 `final-review.md` 中按以上维度汇总；后续落地时再决定拆分文件。

## 14. revisions/ 字段方案

必须包含：

- 修订对象
- 修订原因
- 对应审查问题
- 是否影响原文事实
- 是否影响教学目标
- 是否影响字幕
- 是否影响分镜
- 修订前后摘要
- 用户确认状态

建议修订对象类型：

- 原文拆解
- 白话释义
- Scene 映射
- 正片剧本
- 字幕方案
- 分镜方案
- 视频风险说明
- 生产稿包

规则：任何影响原文事实、教学目标或不可改写知识结论的修订，都必须更新 `PROJECT-MEMORY.md` 并等待用户确认。

## 15. locked/ 字段方案

建议将 Phase 7 显示名改为：**生产稿包锁定**。

必须包含：

- 正片剧本
- 原文映射表
- 字幕方案
- 分镜方案
- 视频风险说明
- 审查结论
- 修订记录
- Skill 锁定信息
- 生产稿包 manifest
- 锁定后禁止事项

### 为什么 `FINAL-SCRIPT.md` 不足以代表完整生产稿包

`FINAL-SCRIPT.md` 只能表达最终剧本文本，无法完整锁定文言文教辅短剧所需的原文映射、字幕、分镜、视频风险说明和教学审查结论。教辅短剧的最终可生产状态应是生产稿包，而不是单一剧本文本。

建议后续生产稿包结构：

- `locked/FINAL-SCRIPT.md`
- `locked/ORIGINAL-MAPPING.md`
- `locked/SUBTITLE-PLAN.md`
- `locked/SHOTLIST-PLAN.md`
- `locked/VIDEO-RISK-REPORT.md`
- `locked/FINAL-REVIEW.md`
- `locked/PRODUCTION-PACKAGE-MANIFEST.md`
- `locked/LOCK-MANIFEST.sha256`
- `locked/SKILL-LOCK-MANIFEST.sha256`

本轮不新增这些文件。

## 16. 后置输出目录字段方案

| 目录 | 教辅短剧职责 | 输入 | 输出 | 默认启用 | 是否需要用户确认 |
|---|---|---|---|---|---|
| `shotlists/` | 通用或历史兼容分镜区 | 锁稿剧本、Scene 映射 | 通用分镜表 | 否 | 是 |
| `short-drama-shotlists/` | 教辅短剧分镜主目录 | 生产稿包、Scene 映射、字幕方案 | 短剧镜头表、视频风险标记 | 否 | 是 |
| `seedance-prompts/` | 可选视频生成提示词目录 | 锁定分镜、视频风险说明、用户确认 | Seedance 或视频生成提示词 | 否 | 是 |
| `materials/` | 原文、注释、教材来源、用户资料 | 用户提供资料 | 原始资料、参考说明 | 可使用 | 不一定，但进入稳定事实需确认 |

原则：

- `short-drama-shotlists/` 是教辅短剧更自然的分镜落点。
- `seedance-prompts/` 保持默认关闭。
- `materials/` 中的原文和参考资料不自动成为稳定事实，必须经 Phase 2 或 `PROJECT-MEMORY.md` 确认。

## 17. 建议新增文件或目录

| 新增项 | 是否必要 | 优先级 | 是否可以先不新增 | 说明 |
|---|---|---|---|---|
| `subtitles/` | 建议 | P1 | 可以 | 字幕方案可先放在 `scripts/` 或 `locked/`，后续需要独立管理时再新增。 |
| `mappings/` | 建议 | P1 | 可以 | 原文映射表很重要，但可先放在 `specs/`、`outlines/` 或 `locked/`。 |
| `production-package/` | 候选 | P2 | 可以 | 可作为锁稿包整理区，但可能与 `locked/` 重复。 |
| `teaching-review.md` | 建议 | P1 | 可以 | 可先合入 `reviews/final-review.md`，后续再拆。 |
| `original-text-analysis.md` | 建议 | P1 | 可以 | 可先由 `specs/STORY-SPEC.md` 承载。 |
| `scene-mapping.md` | 建议 | P1 | 可以 | 可先由 `outlines/OUTLINE.md` 承载。 |
| `subtitle-plan.md` | 建议 | P1 | 可以 | 可先由 `scripts/` 或 `locked/` 承载。 |
| `video-risk-report.md` | 建议 | P1 | 可以 | 可先由分镜表和审查报告承载。 |

推荐：字段方案先不强制新增目录，避免把模板复杂度一次性拉高。

## 18. 推荐落地方案

| 方案 | 判断 | 原因 |
|---|---|---|
| 方案 A：扩展现有 `projects/_template` | 暂不推荐作为下一步直接动作 | 会影响旧小说 / 剧本模板兼容性，且可能牵动 validate 脚本。 |
| 方案 B：新增 `projects/_template-edu-shortdrama` | 中期推荐落地方向 | 可以隔离教辅短剧模板语义，不破坏旧模板。 |
| 方案 C：先保留方案文档，不落地修改 | **当前推荐** | 当前只需形成字段方案和草案，再由用户确认实际落地路径。 |

明确推荐：**方案 C：先保留方案文档，不落地修改。**

适用条件：

- 当前仍处于迁移设计阶段。
- 尚未运行验证基线。
- 尚未扩展 Skill 合约。
- 尚未确认是否新增专用模板目录。

风险：

- 不落地意味着短期仍不能直接用 `_template` 创建教辅短剧项目。
- 后续必须有 `TEMPLATE-003` 或等价任务，把字段方案转成可执行模板草案。

## 19. 后续任务建议

主任务建议：

**TEMPLATE-003：按字段方案生成教辅短剧模板草案。**

推荐顺序：

1. `TEMPLATE-003`：按字段方案生成教辅短剧模板草案。建议先生成文档草案或候选模板方案，不直接替换旧 `_template`。
2. `CONTRACT-001`：扩展 Skill 合约，让 capabilities 能表达教辅生产能力。
3. `WORKFLOW-DOC-001`：更新 workflow 文档语义，说明 Phase 映射和教辅短剧解释。
4. `VALIDATE-001`：运行现有校验基线，记录旧结构验证结果。

本轮不执行上述后续任务。

## 20. 明确结论

- `TEMPLATE-002` 已完成的是字段方案设计。
- 本轮没有修改 `projects/_template/`。
- 本轮没有创建新模板目录。
- 本轮没有修改 `workflow/`、`scripts/`、`genre-skills/` 或 `projects/`。
- 当前推荐落地方案是先保留方案文档，不落地修改。
- 下一步建议执行 `TEMPLATE-003`：按字段方案生成教辅短剧模板草案。
