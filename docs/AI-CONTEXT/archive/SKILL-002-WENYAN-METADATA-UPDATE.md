# SKILL-002：wenyan-skill 元数据补强记录

- 任务编号：SKILL-002
- 任务名称：按新合约补强 `wenyan-skill` 元数据
- 完成日期：2026-05-28
- 当前状态：已完成

## 修改范围

- 修改 `genre-skills/wenyan-skill/SKILL.md` 的 YAML frontmatter。
- 更新 `docs/AI-CONTEXT/BACKLOG.md` 中 `SKILL-002` 的完成状态和备注。
- 更新 `docs/AI-CONTEXT/CURRENT-STATE.md` 与 `docs/AI-CONTEXT/LAST-TASK.md` 的当前状态。
- 新增本文档作为 `SKILL-002` 的归档记录。

## 修改目的

基于 `CONTRACT-001` 扩展后的 Skill 合约，为 `wenyan-skill` 补齐机器可读元数据，使其能够明确声明文言文教辅真人古风短剧生产能力、降级规则和 Skill / shell 边界。

## `SKILL.md` 新增元数据摘要

- 新增 `version: 0.1.0`。
- 新增 `capabilities`，声明教辅短剧、原文拆解、白话释义、教学目标、Scene 映射、字幕、分镜、视频风险、教学审查和生产稿包能力。
- 新增 `fallbackRules`，声明缺失输入、文本不适配、部分产物请求、原文与创意冲突、能力缺口等情形的处理方式。
- 新增 `shellBoundary`，声明 Skill 只提供规则、模板、示例和审查标准，不接管 shell、workflow、项目创建、Phase 门禁或后置生成。

## capabilities 列表

- `supports_short_drama: true`
- `supports_edu_shortdrama: true`
- `supports_original_text_analysis: true`
- `supports_plain_translation: true`
- `supports_teaching_objectives: true`
- `supports_character_event_chain: true`
- `supports_scene_original_mapping: true`
- `supports_subtitle_plan: true`
- `supports_shotlist: true`
- `supports_video_risk_notes: true`
- `supports_teaching_review: true`
- `supports_production_package: true`

## fallbackRules 摘要

- 原文缺失时暂停，不编造原文。
- 出处 / 年级缺失时标记待补或请求用户确认。
- 文本不适合情境复演时，降级为讲解、注释、字幕或其他输出建议。
- 用户只要求部分产物时，只输出请求范围，并记录未生成产物。
- 原文与用户创意冲突时，原文事实和教学准确性优先。
- 生成中发现能力缺口时，记录缺失能力，不冒充已声明能力。

## shellBoundary 摘要

- Skill 只提供规则、模板、示例和审查标准。
- Skill 不创建项目。
- Skill 不修改 workflow。
- Skill 不绕过 Phase 门禁。
- Skill 不自动进入审查、修订、锁稿。
- Skill 不自动生成图片、视频或后置提示词。
- Skill 不替代用户确认。

## 未修改范围

- 未修改 `genre-skills/wenyan-skill/genre-profile.md`。
- 未修改 `genre-skills/wenyan-skill/style-guide.md`。
- 未修改 `genre-skills/wenyan-skill/structure-rules.md`。
- 未修改 `genre-skills/wenyan-skill/character-rules.md`。
- 未修改 `genre-skills/wenyan-skill/dialogue-rules.md`。
- 未修改 `genre-skills/wenyan-skill/taboo.md`。
- 未修改 `genre-skills/wenyan-skill/review-rubric.md`。
- 未修改 `genre-skills/wenyan-skill/templates/` 或 `genre-skills/wenyan-skill/examples/`。
- 未修改 `projects/`、`projects/_template/` 或 `projects/_template-edu-shortdrama/`。
- 未修改 `workflow/` 或 `scripts/`。
- 未修改 `docs/GENRE-SKILL-CONTRACT.md`。

## 对后续 validate 的影响

- `wenyan-skill` 现在具备 `version`、`capabilities`、`fallbackRules` 和 `shellBoundary`，可支持后续校验基线检查其声明能力和边界字段。
- 本任务未运行任何 validate 脚本，未创建项目，未生成剧本、分镜、视频提示词或创作测试内容。
- 后续验证时应检查现有校验脚本是否识别这些新增 frontmatter 字段；如脚本尚未覆盖，只记录基线，不为通过验证而修改业务逻辑。

## 后续任务建议

下一步建议执行 `VALIDATE-001`：运行现有校验基线。
