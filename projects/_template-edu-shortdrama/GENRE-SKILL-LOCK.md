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
