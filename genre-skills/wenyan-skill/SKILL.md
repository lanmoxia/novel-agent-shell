---
name: wenyan-skill
description: 文言文教辅真人古风短剧 Skill，用于将教材文言文转化为可生成视频的情境复演剧本。
version: 0.1.0
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
fallbackRules:
  - 原文缺失时暂停，不编造原文。
  - 出处 / 年级缺失时标记待补或请求用户确认。
  - 文本不适合情境复演时，降级为讲解、注释、字幕或其他输出建议。
  - 用户只要求部分产物时，只输出请求范围，并记录未生成产物。
  - 原文与用户创意冲突时，原文事实和教学准确性优先。
  - 生成中发现能力缺口时，记录缺失能力，不冒充已声明能力。
shellBoundary:
  - Skill 只提供规则、模板、示例和审查标准。
  - Skill 不创建项目。
  - Skill 不修改 workflow。
  - Skill 不绕过 Phase 门禁。
  - Skill 不自动进入审查、修订、锁稿。
  - Skill 不自动生成图片、视频或后置提示词。
  - Skill 不替代用户确认。
---

# 文言文教辅真人古风短剧 Skill

## 1. Skill 定位

本 Skill 用于将教材文言文、古代寓言、古代人物故事转化为 AI 真人古风教辅短剧。

它不是普通古风故事创作 Skill，也不是小说改编 Skill。

核心目标是：

1. 准确还原原文事件。
2. 将文言句意转化为可视化剧情。
3. 用人物冲突、行动、问答承载知识点。
4. 用原文字幕与白话解释完成学习闭环。
5. 输出适合 AI 出图、图生视频、文生视频的剧本、分镜和字幕方案。

## 2. 默认模板

当前默认调用模板：

- `templates/T-WY001-qingjing-fuyan.md`

模板名称：

- T-WY001：情境复演型

结构公式：

```txt
题目钩子
→ 古风场景建立
→ 原文事件触发
→ 人物冲突出现
→ 关键人物介入
→ 观点 / 行为展开
→ 证据 / 后果呈现
→ 结果 / 反转
→ 原文回扣
→ 白话释义
→ 主题收束
```

## 3. 适用内容

适合：

1. 小学文言文
2. 初中文言文
3. 古代寓言
4. 古代人物故事
5. 有明确人物、事件、冲突、问答、判断或反转的文本

典型篇目：

- 《两小儿辩日》
- 《司马光》
- 《王戎不取道旁李》
- 《守株待兔》
- 《揠苗助长》
- 《刻舟求剑》
- 《曹冲称象》
- 《杨氏之子》

## 4. 不适用内容

不适合：

1. 纯写景古诗
2. 纯抒情古诗
3. 现代散文
4. 长篇复杂古文
5. 无人物、无事件、无冲突的文本

这些内容应交给其他 Skill。

## 5. 输入要求

调用本 Skill 时，至少需要提供：

- 篇目标题
- 原文内容
- 目标年级
- 视频时长
- 生成目标

生成目标可选：

- 剧本
- 分镜
- 字幕
- 视频提示词
- 全套生产稿

## 6. 输出要求

每次生成必须包含：

1. 项目信息
2. 教学目标
3. 原文结构拆解
4. 剧情结构
5. 正片剧本
6. 原文 / 剧情映射表
7. 字幕设计
8. 分镜表
9. 视频生成注意事项
10. 审查结果

## 7. 硬性约束

1. 必须先拆原文，再写剧本。
2. 剧情不得脱离原文事件链。
3. 每个 Scene 必须绑定原文句子或明确教学点。
4. 每个关键文言句必须提供白话解释。
5. 不得改成仙侠、玄幻、权谋、爱情故事。
6. 不得只写漂亮画面，必须服务理解、记忆、翻译和主题。
7. 单镜头主要互动人物不超过 3 个。
8. 每集必须有学习闭环。
9. 如果原文存在观点对立，必须使用“观点 + 证据”结构。
10. 输出必须严格遵循模板字段，不得自由删改结构。
