# SKILL-001：wenyan-skill 与现有 Skill 合约差距审计

- 审计日期：2026-05-28
- 审计类型：只读审计
- 业务文件修改：无

本次审计只读取 `docs/GENRE-SKILL-CONTRACT.md`、`genre-skills/README.md`、`genre-skills/_contract-example/`、`genre-skills/wenyan-skill/` 和相关 ARCH 归档，用于判断 `wenyan-skill` 是否符合当前题材 Skill 合约，以及它作为文言文教辅真人古风短剧 Skill 的能力缺口。本轮未修改 `docs/GENRE-SKILL-CONTRACT.md`，未修改 `workflow/`、`scripts/`、`genre-skills/`、`projects/` 或 `projects/_template/`，未运行测试，未创建项目。

## 1. 审计范围

实际读取了：

- `docs/AI-CONTEXT/README.md`
- `docs/AI-CONTEXT/CURRENT-STATE.md`
- `docs/AI-CONTEXT/BACKLOG.md`
- `docs/AI-CONTEXT/LAST-TASK.md`
- `docs/AI-CONTEXT/archive/ARCH-001-AUDIT.md`
- `docs/AI-CONTEXT/archive/ARCH-002-PHASE-MAPPING.md`
- `docs/GENRE-SKILL-CONTRACT.md`
- `genre-skills/README.md`
- `genre-skills/_contract-example/README.md`
- `genre-skills/wenyan-skill/README.md`
- `genre-skills/wenyan-skill/SKILL.md`
- `genre-skills/wenyan-skill/genre-profile.md`
- `genre-skills/wenyan-skill/style-guide.md`
- `genre-skills/wenyan-skill/structure-rules.md`
- `genre-skills/wenyan-skill/character-rules.md`
- `genre-skills/wenyan-skill/dialogue-rules.md`
- `genre-skills/wenyan-skill/taboo.md`
- `genre-skills/wenyan-skill/review-rubric.md`
- `genre-skills/wenyan-skill/templates/T-WY001-qingjing-fuyan.md`
- `genre-skills/wenyan-skill/templates/script-template.md`
- `genre-skills/wenyan-skill/templates/shotlist-template.md`
- `genre-skills/wenyan-skill/templates/subtitle-template.md`
- `genre-skills/wenyan-skill/examples/liangxiaor-bianri-example.md`

## 2. 文件结构检查

| 合约要求文件 | wenyan-skill 是否存在 | 内容是否有效 | 问题 | 建议 |
|---|---|---|---|---|
| `SKILL.md` | 是 | 部分有效 | 有 name 和 description，但缺少 version、capabilities、明确 fallback、与 shell 边界说明 | 后续补强元数据和边界，不影响本轮 TEMPLATE-001 评估 |
| `genre-profile.md` | 是 | 有效 | 已说明题材本质、目标用户、学习目标、适用 / 不适用文本 | 保留，可在后续补充教材版本或年级边界 |
| `style-guide.md` | 是 | 有效 | 已覆盖真人古风、教材感、视觉复杂度和色调 | 保留，可后续加入视频平台 / 画幅约束 |
| `structure-rules.md` | 是 | 有效 | 已要求先拆原文，并定义 60 / 90 / 180 秒结构、Scene 和原文映射 | 保留，后续可与 Phase 2 / Phase 3 模板字段对齐 |
| `character-rules.md` | 是 | 有效 | 已定义人物类型、数量、角色一致性和禁用人物 | 保留，后续可补生产稿包中的角色一致性清单 |
| `dialogue-rules.md` | 是 | 有效 | 已区分角色对白、旁白、原文字幕、白话释义字幕 | 保留，后续可补字幕长度和分层校验标准 |
| `taboo.md` | 是 | 有效 | 已覆盖玄幻化、恋爱化、权谋化、改写原文事实、字幕和教学禁忌 | 保留，后续可与 review-rubric 建立显式扣分关系 |
| `review-rubric.md` | 是 | 部分有效 | 有教学准确性、剧情、映射、视频、字幕维度，但缺少评分阈值和硬阻断条件 | 后续补强审查标准；不阻塞模板审计 |
| `templates/` | 是 | 有效 | 有默认模板、剧本、分镜、字幕模板 | 保留，后续检查与项目模板字段的衔接 |
| `examples/` | 是 | 部分有效 | 有《两小儿辩日》示例，但覆盖篇目类型较少 | 后续可增加寓言型、机智型、劝诫型示例 |

结论：文件结构符合当前题材 Skill 合约的标准目录要求，不是旧格式 Skill。内容已经能支撑第一版教辅短剧生成，但机器可读能力声明和边界说明不足。

## 3. SKILL.md 检查

| 检查项 | 当前情况 | 是否合格 | 风险 | 建议 |
|---|---|---|---|---|
| name | frontmatter 中有 `name: wenyan-skill` | 是 | 低 | 保留 |
| version | 未声明 | 否 | 中 | 后续补 `version`，便于锁定和漂移判断 |
| description | 有清晰描述，定位为文言文教辅真人古风短剧 Skill | 是 | 低 | 保留 |
| capabilities | 未声明 | 否 | 中高 | 后续补 capabilities；当前合约也需要扩展才能表达教辅能力 |
| 适用范围 | 已列小学 / 初中文言文、寓言、人物故事等 | 是 | 低 | 保留 |
| 不适用范围 | 已列纯写景、纯抒情、长篇复杂古文等 | 是 | 低 | 保留 |
| 输入要求 | 已列篇目标题、原文、年级、视频时长、生成目标 | 是 | 低 | 保留，后续可补“出处 / 教材版本” |
| 输出要求 | 已列项目信息、教学目标、原文拆解、剧本、映射表、字幕、分镜、视频注意事项、审查结果 | 是 | 低 | 保留 |
| 硬约束 | 已列先拆原文、Scene 绑定原文、不得玄幻 / 权谋 / 爱情化等 | 是 | 低 | 保留 |
| 降级 / fallback | 未明确 | 否 | 中 | 后续补“原文不适配、缺少年级、缺少出处、只生成部分产物”的降级规则 |
| 视频生产边界 | 部分说明生成注意事项和视频提示词目标，但未说明不实际生成视频、不接管后置模块 | 部分 | 中 | 后续补清 Skill 只提供规则和模板，不调用生成工具 |
| 与 shell 的关系 | 未明确写出 Skill 只提供规则、不接管 workflow | 否 | 中 | 后续补边界说明，与 `docs/SHELL-BOUNDARY.md` 对齐 |

## 4. capabilities 检查

| 能力项 | 当前是否声明 | 当前是否实际支持 | 合约是否能表达 | 风险 | 建议 |
|---|---|---|---|---|---|
| 支持短剧剧本 | 否 | 是 | 部分，`supports_short_drama` 可表达 | 中 | 在 capabilities 中声明 |
| 文言文原文拆解 | 否 | 是 | 否 | 中高 | 合约后续增加教辅能力字段 |
| 白话释义 | 否 | 是 | 否 | 中高 | 合约后续增加释义能力字段 |
| 教学目标 | 否 | 是 | 否 | 中高 | 合约后续增加教学目标字段 |
| 人物事件链 | 否 | 是 | 部分，结构 / 人物能力只能间接表达 | 中 | 合约后续增加原文事件拆解字段 |
| Scene 与原文映射 | 否 | 是 | 否 | 中高 | 合约后续增加原文映射字段 |
| 字幕方案 | 否 | 是 | 否 | 中高 | 合约后续增加字幕能力字段 |
| 分镜 / 镜头表 | 否 | 是 | 否 | 中高 | 合约后续增加分镜能力字段 |
| 视频生成风险 | 否 | 是 | 否 | 中 | 合约后续增加视频生产风险字段 |
| 教学准确性审查 | 否 | 是 | 否 | 中高 | 合约后续增加教学审查字段 |
| 生产稿包输出 | 否 | 部分 | 否 | 中 | 先在模板审计中判断生产稿包边界 |
| 提供审查标准 | 否 | 是 | 是，`provides_review_rubric` 可表达 | 中 | 在 capabilities 中声明 |
| 提供禁忌约束 | 否 | 是 | 是，`provides_taboo` 可表达 | 中 | 在 capabilities 中声明 |
| 提供示例 | 否 | 是 | 是，`provides_examples` 可表达 | 中 | 在 capabilities 中声明 |

结论：`wenyan-skill` 实际能力明显强于当前声明能力；问题不在内容完全缺失，而在没有机器可读 capabilities，且当前 `GENRE-SKILL-CONTRACT.md` 无法表达多数教辅生产能力。

## 5. 教辅短剧生产能力检查

- 原文拆解：已具备。`structure-rules.md`、`script-template.md` 和示例都要求先拆原文。
- 白话释义：已具备。`dialogue-rules.md`、`subtitle-template.md` 和示例都要求原文与白话对应。
- 教学目标：已具备。`genre-profile.md` 和 `script-template.md` 覆盖学习目标与学生痛点。
- Scene 映射：已具备。`structure-rules.md` 和 `script-template.md` 明确每个 Scene 绑定原文或教学点。
- 正片剧本：已具备。`script-template.md` 提供完整正片剧本结构。
- 字幕：已具备。`dialogue-rules.md` 和 `subtitle-template.md` 提供字幕类型、层级和禁忌。
- 分镜：已具备。`shotlist-template.md` 提供镜头字段、生成方式和风险判断。
- 视频风险：已具备。`style-guide.md`、`shotlist-template.md` 和示例都包含可生产性风险。
- 教学审查：部分具备。`review-rubric.md` 覆盖核心维度，但缺少评分阈值、硬阻断条件和与 taboo 的显式联动。
- 合约表达：当前合约无法完整表达上述教辅能力，只能表达短剧、结构、人物、对白、审查、禁忌、示例等通用写作能力。

## 6. 模板与示例检查

`templates/` 已包含：

- `T-WY001-qingjing-fuyan.md`：当前默认模板，适合故事型文言文情境复演。
- `script-template.md`：包含项目信息、教学目标、原文拆解、正片剧本、映射表、分镜、字幕、视频注意事项和审查结果。
- `shotlist-template.md`：包含镜头编号、时长、景别、场景、人物、动作、对应原文、知识功能、生成方式和风险。
- `subtitle-template.md`：包含原文字幕、白话字幕、对白字幕和字幕禁忌。

`examples/` 已包含：

- `liangxiaor-bianri-example.md`：提供《两小儿辩日》的结构拆解、剧情结构、分镜示例、字幕示例和生成风险。

判断：

- 有默认模板，可以支撑第一版稳定生成。
- 模板强制要求原文拆解、Scene 对应原文、字幕和分镜，能明显降低创意发散风险。
- 示例质量有效，但篇目类型单一，不能覆盖寓言型、机智型、劝诫型等全部适用范围。
- 模板已经包含视频生成风险，但尚未定义“最终生产稿包”的锁定边界。
- 如果进入 `TEMPLATE-001`，应重点评估 `projects/_template` 是否能承载这些模板字段，而不是先修 `wenyan-skill`。

## 7. 审查标准检查

`review-rubric.md` 已覆盖：

- 原文准确性：通过“是否忠于原文事件”“是否保留原文核心逻辑”等项覆盖。
- 白话释义准确性：通过“是否解释关键句”“白话解释是否对应原文”等项覆盖。
- Scene 与原文对应关系：通过“每个 Scene 是否绑定原文”“是否有原文 / 剧情映射表”等项覆盖。
- 教学目标达成：通过“主题总结”“字幕学习闭环”等项部分覆盖。
- 字幕可读性：通过“原文字幕”“白话翻译”“避免大段堆字”等项覆盖。
- 镜头可生产性：通过人物数量、动作复杂度、场景数量、生成风险等项覆盖。

`taboo.md` 已覆盖：

- 禁止玄幻化、恋爱化、权谋化。
- 禁止脱离教材原文乱编。
- 禁止改变人物关系、原文结果和事件顺序。
- 禁止错误翻译、错误主题和错误考点归纳。

不足：

- 审查标准没有数值评分或通过阈值。
- `review-rubric.md` 与 `taboo.md` 没有明确“触发即不通过”的联动规则。
- 还没有明确“生产稿包是否可锁定”的最终验收表。

## 8. 与 ARCH-002 Phase 映射的适配情况

| 教辅 Phase | wenyan-skill 支撑情况 | 缺口 | 是否阻塞后续 TEMPLATE-001 |
|---|---|---|---|
| Phase 1：教辅 Skill 加载 | 部分支撑 | 有标准文件，但缺少 version、capabilities 和 shell 边界说明 | 否 |
| Phase 2：原文拆解 / 教学目标 | 支撑较好 | 缺少与项目模板字段的落点映射 | 否 |
| Phase 3：情境复演结构设计 | 支撑较好 | 示例类型单一，模板与 `_template/outlines` 尚未对齐 | 否 |
| Phase 4：正片剧本生成 | 支撑较好 | 需要判断 `projects/_template/scripts/` 是否能承载字幕 / 映射表 | 否 |
| Phase 5：教学与生产审查 | 部分支撑 | 缺少评分阈值、硬阻断和生产稿包验收标准 | 否，但会影响后续 workflow 审查设计 |
| Phase 8：分镜 / 字幕 / 视频说明 | 支撑较好 | Skill 未明确不接管后置模块，生产稿包边界待模板评估 | 否 |

结论：`wenyan-skill` 可以支撑 `TEMPLATE-001` 的只读模板评估，不需要先修 Skill 才能进入模板评估。

## 9. 风险等级

### 高

- 当前 `GENRE-SKILL-CONTRACT.md` 无法表达教辅生产能力，如原文拆解、白话释义、Scene 映射、字幕、分镜、视频风险和教学审查。

### 中

- `SKILL.md` 缺少 version 和 capabilities，影响 loader 记录、能力判断和后续锁定。
- `SKILL.md` 未明确 fallback 规则，遇到纯写景、缺少年级、缺少出处或只需部分产物时容易临场判断。
- `SKILL.md` 未明确 Skill 与 shell 的边界，容易被误解为可接管 workflow 或直接调用后置模块。
- `review-rubric.md` 缺少评分阈值、硬阻断和生产稿包锁定标准。

### 低

- 示例只有《两小儿辩日》一种类型，短期可用，但覆盖面不足。
- 模板已经较完整，但与 `projects/_template` 的具体落点仍需 `TEMPLATE-001` 判断。

## 10. 结论

- `wenyan-skill` 当前可以作为第一版教辅生产 Skill 使用，但还不是完全合约化、机器可读能力完备的 Skill。
- 它更接近 **B. 半合格的教辅生产 Skill**，不是单纯提示词模板包。理由是它具备标准文件结构、默认模板、剧本 / 字幕 / 分镜模板、示例、禁忌和审查标准；但缺少 capabilities、version、fallback、shell 边界和合约可表达的教辅能力字段。
- 不需要先修 `wenyan-skill` 再做 `TEMPLATE-001`。当前内容已经足够支撑对 `projects/_template` 的只读评估。
- 需要后续扩展 `GENRE-SKILL-CONTRACT.md`，让合约能表达教辅生产能力；但本轮不修改合约。
- 下一步建议执行 `TEMPLATE-001`：评估 `projects/_template` 是否需要教辅短剧版本，或是否可以在现有模板上扩展教辅字段。
