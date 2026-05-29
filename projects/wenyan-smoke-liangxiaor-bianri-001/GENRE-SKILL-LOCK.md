# 题材 Skill 锁定记录

- 项目名：wenyan-smoke-liangxiaor-bianri-001
- 题材 Skill：wenyan-skill
- Skill 版本：0.1.0
- Skill 路径：`genre-skills/wenyan-skill/`
- 加载时间：2026-05-29
- 当前状态：已锁定（烟测）

## 已读取文件

- `genre-skills/wenyan-skill/SKILL.md`
- `genre-skills/wenyan-skill/templates/T-WY001-qingjing-fuyan.md`
- `genre-skills/wenyan-skill/examples/liangxiaor-bianri-example.md`

## 能力声明

declaredCapabilities：

- supports_short_drama: true
- supports_edu_shortdrama: true
- supports_original_text_analysis: true
- supports_plain_translation: true
- supports_teaching_objectives: true
- supports_character_event_chain: true
- supports_scene_original_mapping: true
- supports_subtitle_plan: true
- supports_shotlist: true
- supports_video_risk_notes: true
- supports_teaching_review: true
- supports_production_package: true

inferredCapabilities：

- T-WY001 情境复演型模板适合《两小儿辩日》这类有人物、争辩、证据和反转的短篇文言文。
- 示例文件可作为结构参照，但不得直接复制成完整生产稿包。

缺失能力：

- 本轮未发现阻塞 Phase 0-4 烟测的能力缺口。
- 本轮不验证 Phase 5-8 的审查、修订、锁稿或后置生产能力。

## fallbackRules

- 原文缺失时暂停，不编造原文。
- 出处 / 年级缺失时标记待补或请求用户确认。
- 文本不适合情境复演时，降级为讲解、注释、字幕或其他输出建议。
- 用户只要求部分产物时，只输出请求范围，并记录未生成产物。
- 原文与用户创意冲突时，原文事实和教学准确性优先。
- 生成中发现能力缺口时，记录缺失能力，不冒充已声明能力。

## shellBoundary

- Skill 只提供规则、模板、示例和审查标准。
- Skill 不创建项目。
- Skill 不修改 workflow。
- Skill 不绕过 Phase 门禁。
- Skill 不自动进入审查、修订、锁稿。
- Skill 不自动生成图片、视频或后置提示词。
- Skill 不替代用户确认。

## 烟测边界

- 本锁定记录只服务 `WENYAN-SMOKE-001-RUN`。
- 不生成 `locked/SKILL-LOCK-MANIFEST.sha256`。
- 不进入 Phase 5 审查。
- 不进入 Phase 7 锁稿。
