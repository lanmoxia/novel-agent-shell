# TEMPLATE-001：projects/_template 教辅短剧适配审计

- 审计日期：2026-05-28
- 审计类型：只读模板适配审计
- 模板修改：无

本次审计基于 `docs/AI-CONTEXT/archive/ARCH-002-PHASE-MAPPING.md`、`docs/AI-CONTEXT/archive/SKILL-001-WENYAN-CONTRACT-AUDIT.md`、`docs/GENRE-SKILL-CONTRACT.md`、`genre-skills/wenyan-skill/` 和 `projects/_template/` 的只读结果，评估当前项目模板是否能承载文言文教辅真人古风短剧生产流程。本轮未修改 `projects/_template/`，未修改 `workflow/`、`scripts/`、`genre-skills/` 或 `projects/`，未运行测试，未创建项目。

## 1. 审计范围

实际读取了：

- `docs/AI-CONTEXT/README.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/archive/ARCH-002-PHASE-MAPPING.md`
- `docs/AI-CONTEXT/archive/SKILL-001-WENYAN-CONTRACT-AUDIT.md`
- `docs/GENRE-SKILL-CONTRACT.md`
- `genre-skills/wenyan-skill/SKILL.md`
- `genre-skills/wenyan-skill/templates/T-WY001-qingjing-fuyan.md`
- `genre-skills/wenyan-skill/templates/script-template.md`
- `genre-skills/wenyan-skill/templates/shotlist-template.md`
- `genre-skills/wenyan-skill/templates/subtitle-template.md`
- `genre-skills/wenyan-skill/review-rubric.md`
- `projects/_template/`
- `projects/_template/PROJECT.md`
- `projects/_template/PROJECT-STATE.json`
- `projects/_template/GENRE-SKILL-LOCK.md`
- `projects/_template/PROJECT-MEMORY.md`
- `projects/_template/RUN-LOG.md`
- `projects/_template/specs/STORY-SPEC.md`
- `projects/_template/planning/ENDING-LOCK.md`
- `projects/_template/planning/REVERSE-OUTLINE.md`
- `projects/_template/planning/FORESHADOW-LEDGER.md`
- `projects/_template/planning/REVEAL-SCHEDULE.md`
- `projects/_template/outlines/OUTLINE.md`
- `projects/_template/scripts/SCRIPT-STATUS.md`
- `projects/_template/reviews/README.md`
- `projects/_template/revisions/README.md`
- `projects/_template/revisions/revision-log.md`
- `projects/_template/revisions/snapshots/README.md`
- `projects/_template/locked/README.md`
- `projects/_template/locked/FINAL-SCRIPT.md`
- `projects/_template/materials/README.md`
- `projects/_template/shotlists/README.md`
- `projects/_template/short-drama-shotlists/README.md`
- `projects/_template/seedance-prompts/README.md`
- `projects/_template/drafts/README.md`
- `projects/_template/drafts/rewrite-candidates/README.md`

## 2. 总体判断

当前 `projects/_template` 属于：

**B. 可复用但必须扩展字段。**

理由：

- 可复用：现有模板已经具备项目建档、状态机、Skill 锁定、运行日志、项目记忆、审查、修订、锁稿和后置输出目录，这些是 shell 状态 / 恢复 / 门禁的基础，不应删除。
- 不可直接复用：核心语义仍是小说 / 剧本创作，`STORY-SPEC.md`、`ENDING-LOCK.md`、`OUTLINE.md`、`PROJECT-MEMORY.md` 和 `FINAL-SCRIPT.md` 与教辅短剧的原文拆解、教学目标、Scene 映射、字幕、分镜和生产稿包边界不匹配。
- 不建议本轮新增独立模板目录：还没有字段方案，不应直接创建 `projects/_edu-template/` 或 `projects/_template-edu-shortdrama/`。
- 最小稳妥下一步：先做 `TEMPLATE-002`，设计教辅短剧项目模板字段方案，再决定是在现有 `_template` 上扩展，还是新增专用模板变体。

## 3. 模板文件逐项检查

| 文件 / 目录 | 当前用途 | 教辅短剧是否可复用 | 主要冲突 | 建议处理 |
|---|---|---|---|---|
| `PROJECT.md` | 项目档案，记录项目名、类型、Skill、目标、阶段 | 部分可复用 | 缺篇目、原文、出处 / 教材版本、年级、视频时长、输出目标 | 保留结构，未来增加教辅建档字段 |
| `PROJECT-STATE.json` | 机器可读 phase / status / confirmedArtifacts 状态源 | 可复用 | confirmedArtifacts 仍是 storySpec、endingLock、outline、finalScript，缺教辅产物标记 | 保留，不删；未来增加或映射教辅产物状态 |
| `GENRE-SKILL-LOCK.md` | 题材 Skill 锁定记录，记录能力、缺失、降级 | 可复用 | 当前 capabilities 合约无法表达教辅生产能力 | 保留；未来随合约扩展记录教辅能力 |
| `PROJECT-MEMORY.md` | 项目长期记忆，记录稳定事实、人物、伏笔、修订 | 部分可复用 | 偏结局、真相、伏笔、道具，不适合原文事实和教学点 | 保留项目记忆机制，未来改字段语义 |
| `RUN-LOG.md` | 阶段动作运行记录，支持跨会话恢复 | 可复用 | 无核心冲突 | 保留，未来记录教辅 Phase 输出 |
| `specs/STORY-SPEC.md` | 故事企划，记录核心创意、主角、冲突、结局 | 不可直接复用 | 与原文拆解 / 教学目标冲突最大 | 未来改为原文拆解与教学目标规格 |
| `planning/ENDING-LOCK.md` | 锁定结局事实、核心真相、情绪落点 | 部分可复用 | 教辅短剧需要锁原文结果、主题、学习闭环，不是原创结局 | 未来改为原文结果 / 主题 / 学习闭环锁定 |
| `outlines/OUTLINE.md` | 大纲 / 分集结构 | 部分可复用 | 缺 Scene、时长、对应原文、知识功能、字幕要点 | 未来改为情境复演结构 / Scene 映射 |
| `scripts/SCRIPT-STATUS.md` | 正文阶段状态，防止自动审查 / 自动锁稿 | 可复用 | “章节 / 正文”语义偏旧，但状态机制有价值 | 保留状态机，未来补字幕 / 映射表状态 |
| `reviews/` | Phase 5 审查报告目录 | 可复用 | 审查维度仍是结构 / 连续性 / 对白 / 题材 | 保留目录，未来增加教学准确性、映射、字幕、生产审查 |
| `revisions/` | Phase 6 修订日志、快照、重写候选 | 可复用 | 修订对象偏正文，缺教学错误 / 映射错误 / 字幕问题分类 | 保留机制，未来扩展修订分类 |
| `locked/` | Phase 7 锁稿目录，含 FINAL-SCRIPT 与 manifest | 部分可复用 | 锁稿对象偏最终剧本，缺生产稿包边界 | 保留锁定机制，未来定义生产稿包锁定范围 |
| `shotlists/` | Phase 8 小说分镜 | 部分可复用 | 名义偏小说分镜，不贴合教辅短剧 | 保留为通用分镜区或历史兼容，教辅优先考虑 `short-drama-shotlists/` |
| `short-drama-shotlists/` | Phase 8 短剧分镜预留接口 | 部分可复用 | README 明确格式尚未定义 | 未来按 `wenyan-skill` 分镜模板定义格式 |
| `seedance-prompts/` | Phase 8 Seedance 提示词，默认关闭 | 可复用 | 教辅视频提示词边界需更严格 | 保留默认关闭原则，未来增加教辅风险字段 |
| `materials/` | 用户素材、参考片段、背景资料 | 可复用 | 需要明确原文、注释、教材来源可放这里但不自动成为稳定事实 | 保留，未来补原文 / 教材资料说明 |

## 4. Phase 0-8 对模板的影响

| Phase | 教辅短剧语义 | 当前模板承载情况 | 缺口 | 是否阻塞 |
|---|---|---|---|---|
| Phase 0 | 项目建档：篇目、原文、出处、年级、时长、输出目标 | `PROJECT.md` 可承载基本项目档案 | 缺教辅建档字段 | 不阻塞审计，阻塞直接生产 |
| Phase 1 | 教辅 Skill 加载：锁定 `wenyan-skill` 与适用边界 | `GENRE-SKILL-LOCK.md` 可承载 Skill 锁定 | capabilities 不足来自合约和 Skill 元数据 | 不阻塞模板字段设计 |
| Phase 2 | 原文拆解 / 教学目标 | `STORY-SPEC.md` 名义可作为规格文件 | 现内容是故事企划，不适配教辅拆解 | 阻塞直接复用 |
| Phase 3 | 情境复演结构设计 | `OUTLINE.md` 可作为结构文件 | 缺 Scene / 原文 / 知识功能映射 | 阻塞直接复用 |
| Phase 4 | 正片剧本生成 | `scripts/` 与 `SCRIPT-STATUS.md` 可承载文本和状态 | 缺字幕、映射表、分镜草案落点 | 不阻塞，但需要字段方案 |
| Phase 5 | 教学与生产审查 | `reviews/` 可承载审查报告 | 缺教学准确性、字幕、视频可生产性维度 | 阻塞直接复用 |
| Phase 6 | 修订与校正 | `revisions/` 可承载修订日志和快照 | 缺教辅错误类型和映射 / 字幕修订记录 | 不阻塞，但需要扩展 |
| Phase 7 | 最终生产稿包锁定 | `locked/` 可承载锁定产物 | `FINAL-SCRIPT.md` 不足以表达生产稿包 | 阻塞直接复用 |
| Phase 8 | 分镜 / 字幕 / 视频说明 | `shotlists/`、`short-drama-shotlists/`、`seedance-prompts/` 可承载后置输出 | 短剧分镜格式未定义，字幕不应只作为后置 | 不阻塞字段设计，阻塞直接生产 |

## 5. 必须新增或调整的字段

### `PROJECT.md`

- 篇目标题
- 原文
- 出处 / 教材版本
- 年级
- 视频时长
- 输出目标
- 生成范围：剧本 / 字幕 / 分镜 / 视频说明 / 全套生产稿
- 教辅 Skill：默认或候选 `wenyan-skill`

### `PROJECT-STATE.json`

- 教辅项目类型标记
- 原文拆解是否完成
- 教学目标是否确认
- Scene 映射是否确认
- 字幕方案是否确认
- 分镜方案是否确认
- 教学审查是否通过
- 生产稿包是否锁定

### `GENRE-SKILL-LOCK.md`

- `wenyan-skill` 能力声明与缺失能力
- 教辅能力推断：原文拆解、白话释义、Scene 映射、字幕、分镜、视频风险、教学审查
- 降级策略：缺少原文、缺少年级、只生成部分产物、文本不适配情境复演

### `specs/STORY-SPEC.md`

- 原文拆解
- 白话释义
- 教学目标
- 学生学习难点
- 人物事件链
- 原文事实 / 不可改写点
- 主题 / 考点 / 学习闭环

### `planning/ENDING-LOCK.md`

- 原文结果
- 文章主题
- 学习闭环
- 不可改写的原文事实
- 不可提前解释或误导的知识点

### `outlines/OUTLINE.md`

- Scene 编号
- Scene 时长
- 对应原文
- 白话释义
- 剧情功能
- 知识功能
- 字幕要点
- 拍摄 / 生成风险

### `PROJECT-MEMORY.md`

- 原文事实
- 句意解释
- 教学点
- 角色映射
- 字幕规则
- 分镜风险
- 不可改写的知识结论

### `scripts/SCRIPT-STATUS.md`

- 正片剧本状态
- 原文映射表状态
- 字幕方案状态
- 分镜草案状态
- 教学审查状态
- 生产稿包锁定状态

### `reviews/`

- 教学准确性审查结果
- 原文映射审查结果
- 白话释义审查结果
- 字幕可读性审查结果
- 视频可生产性审查结果

### `locked/`

- 生产稿包锁定范围
- 剧本锁定状态
- 原文映射表锁定状态
- 字幕方案锁定状态
- 分镜方案锁定状态
- 视频风险说明锁定状态

## 6. 可继续复用的旧机制

- `PROJECT-STATE.json` 的 `phase` / `status` / `confirmedArtifacts`：仍是机器状态与恢复基础，不应删除。
- `GENRE-SKILL-LOCK.md` 的 Skill 锁定机制：仍可用于锁定 `wenyan-skill`，记录能力、缺失和降级策略。
- `RUN-LOG.md` 的运行记录：仍可支持跨会话断点恢复。
- `PROJECT-MEMORY.md` 的项目级长期记忆：机制有价值，只需从故事事实迁移为原文事实、教学点和生产约束。
- `reviews/`、`revisions/`、`locked/`：审查、修订、锁稿机制仍是教辅短剧生产质量控制基础。
- `shotlists/`、`short-drama-shotlists/`、`seedance-prompts/`：后置输出区仍有价值，尤其需要保留默认关闭和用户确认原则。
- `materials/`：可作为原文、注释、教材版本、参考资料和用户输入资料的存放区。

## 7. 语义冲突较大的文件

### `specs/STORY-SPEC.md`

当前以核心创意、主角设定、主要冲突、情绪基调和结局方向为中心。教辅短剧 Phase 2 需要的是原文拆解、白话释义、教学目标、学习难点和不可改写的原文事实。未来应改为“原文拆解与教学目标规格”，而不是继续叫故事企划。

### `planning/ENDING-LOCK.md`

当前锁定结局事实、核心真相、情绪落点和不可提前暴露的信息。文言文教辅短剧没有原创结局设计，应该锁定原文结果、文章主题、知识闭环和不可误读点。该文件可以复用“锁定不可随意改写的核心事实”机制，但字段必须重写。

### `outlines/OUTLINE.md`

当前偏章节 / 集数、大纲和章末钩子。教辅短剧需要 Scene、时长、对应原文、知识功能、字幕要点和生产风险。未来应改成 Scene 映射结构。

### `PROJECT-MEMORY.md`

当前偏结局、人物、道具、伏笔、信息释放和修订影响。教辅短剧更需要记录原文事实、句意、教学目标、角色映射、字幕规则和不可改写的知识结论。机制可复用，内容语义必须改。

### `locked/FINAL-SCRIPT.md` 和 `locked/`

当前以最终剧本为锁稿中心。教辅短剧需要锁定生产稿包，包括正片剧本、原文映射表、字幕方案、分镜方案、视频风险说明和审查结论。`locked/` 机制可复用，但 `FINAL-SCRIPT.md` 不足以代表全部最终产物。

### `scripts/SCRIPT-STATUS.md`

当前状态围绕正文生成、审查、修订和锁稿。教辅短剧需要追踪剧本、原文映射、字幕、分镜和教学审查状态。状态机有价值，但字段需要扩展。

## 8. 是否需要独立教辅短剧模板

明确判断：

- 当前不建议立即新增 `projects/_edu-template/`。
- 当前不建议立即新增 `projects/_template-edu-shortdrama/`。
- 当前也不建议直接修改 `projects/_template/`。

推荐路径：

1. 先新增 `TEMPLATE-002`：设计教辅短剧项目模板字段方案。
2. 在 `TEMPLATE-002` 中明确字段、文件语义、生产稿包边界和状态字段。
3. 再由用户决定是：
   - 在现有 `projects/_template/` 上扩展字段；
   - 还是新增专用模板变体，例如 `projects/_template-edu-shortdrama/`。

理由：

- 现有 `_template` 的状态 / 恢复 / 门禁机制很重要，不能丢。
- 现有 `_template` 的核心内容语义又明显偏小说 / 剧本，不能直接作为教辅生产模板。
- 在没有字段方案前直接新增模板目录，容易复制旧语义冲突。

## 9. 与 wenyan-skill 的衔接

| wenyan-skill 要求 | 当前 projects/_template 是否能承载 | 说明 |
|---|---|---|
| 输入要求：篇目标题 | 部分 | `PROJECT.md` 可记录项目名，但缺篇目字段 |
| 输入要求：原文内容 | 部分 | `materials/` 可存放，但 `PROJECT.md` / `STORY-SPEC.md` 没有明确字段 |
| 输入要求：出处 / 年级 / 视频时长 | 部分 | `PROJECT.md` 有目标和类型，但缺出处、年级、时长 |
| 输出要求：教学目标 | 部分 | `STORY-SPEC.md` 可承载，但当前语义不匹配 |
| 输出要求：原文结构拆解 | 部分 | 需要重写 `STORY-SPEC.md` 字段 |
| 输出要求：剧情结构 / Scene 映射 | 部分 | `OUTLINE.md` 可承载结构，但缺 Scene 映射字段 |
| 输出要求：正片剧本 | 是 | `scripts/` 可承载 |
| 输出要求：原文 / 剧情映射表 | 不足 | 没有明确落点，可放 `scripts/` 或 `outlines/`，但需方案 |
| 输出要求：字幕模板 | 不足 | 没有字幕目录或字段，可在 `scripts/`、`locked/` 或后置目录中设计 |
| 输出要求：分镜模板 | 部分 | `short-drama-shotlists/` 有预留，但格式尚未定义 |
| 输出要求：审查结果 | 部分 | `reviews/` 可承载，但审查维度需调整 |
| 输出要求：视频风险说明 | 部分 | `short-drama-shotlists/` / `seedance-prompts/` 可承载，但字段未定义 |

结论：`projects/_template` 可以承载 `wenyan-skill` 的生产链路，但需要字段方案，不能直接使用当前文本模板。

## 10. 风险等级

### 高

- `STORY-SPEC.md`、`ENDING-LOCK.md`、`OUTLINE.md` 与教辅短剧 Phase 2 / Phase 3 语义冲突明显，直接复用会导致输出继续按原创故事走。
- `locked/FINAL-SCRIPT.md` 无法代表完整生产稿包，容易漏掉原文映射、字幕、分镜和视频风险说明。

### 中

- `PROJECT.md` 缺教辅建档字段。
- `PROJECT-MEMORY.md` 仍偏伏笔 / 结局 / 道具记忆，需要转向原文事实和教学点。
- `reviews/` 目录可复用，但审查维度仍需从四类剧本审查迁移为教学与生产审查。
- `short-drama-shotlists/` 已预留，但格式未定义。

### 低

- `RUN-LOG.md`、`revisions/`、`materials/` 和后置输出区的目录机制可以继续使用。
- `PROJECT-STATE.json` 可继续作为状态源，只需后续扩展 confirmedArtifacts。

## 11. 推荐后续任务

建议下一步执行：

**TEMPLATE-002：设计教辅短剧项目模板字段方案。**

理由：

- 目前不是验证阶段，直接跑 `VALIDATE-001` 只能验证旧壳子结构，不能解决教辅模板语义。
- 当前也不应先做 workflow 文档更新，因为模板字段和生产稿包边界尚未定稿。
- `CONTRACT-001` 确实需要，但它主要解决 Skill capabilities 表达；当前最阻塞的是项目模板字段如何承载 `wenyan-skill` 输出。

本轮不执行 `TEMPLATE-002`、`CONTRACT-001`、`WORKFLOW-DOC-001` 或 `VALIDATE-001`。

## 12. 明确结论

- `TEMPLATE-001` 已完成的是只读模板适配审计。
- 本轮没有修改 `projects/_template/`。
- 本轮没有修改 `workflow/`、`scripts/`、`genre-skills/` 或 `projects/`。
- 当前 `projects/_template` 可复用为 shell 基础模板，但不能直接作为教辅短剧生产模板。
- 下一步建议执行 `TEMPLATE-002`：设计教辅短剧项目模板字段方案。
