---
name: post-production-builder
description: Phase 8 后置模块调度。仅在 locked/FINAL-SCRIPT.md 存在且 SCRIPT-STATUS.md 为"已锁稿"后启用。默认只生成小说分镜，Seedance 提示词默认关闭。
---

# post-production-builder

## 职责

负责 Phase 8 后置模块调度，管理锁稿后的分镜和视频化输出。

## 前置条件（必须全部满足）

- `locked/FINAL-SCRIPT.md` 已存在
- `SCRIPT-STATUS.md` 当前状态为"已锁稿"
- 用户明确提出进入 Phase 8

任一条件不满足，立刻停止，不得生成任何后置模块文件。

## 后置输出类型

| 类型 | 输出目录 | 默认状态 | 说明 |
|------|----------|----------|------|
| 小说分镜 | `shotlists/` | 默认启用 | 基于锁稿正文生成分镜脚本 |
| 短剧分镜 | `short-drama-shotlists/` | 需用户选择 | 基于锁稿正文生成短剧集分镜 |
| Seedance 提示词 | `seedance-prompts/` | **默认关闭** | AI 视频生成提示词，必须用户明确要求 |

## 工作流程

1. 验证前置条件（FINAL-SCRIPT.md + SCRIPT-STATUS.md"已锁稿"）
2. 等待用户选择输出类型
3. 按用户选择的范围生成对应文件
4. 不自动扩展用户未选择的输出类型
5. 生成测试报告：`docs/reports/PHASE-8-<TYPE>-TEST-REPORT.md`

## 小说分镜格式

每个镜头包含：
- 镜号
- 对应原文章节段落
- 景别
- 画面内容
- 人物动作
- 情绪重点
- 声音/环境
- 时长建议

不扩写剧情，不修改正文。

## 注意事项

- **不得自动生成 Seedance 提示词**：必须用户明确要求"生成 Seedance 提示词"后才允许
- **不得自动生成图片或视频**
- **不得修改锁稿正文**
- **不得自动进入 Phase 8**：必须用户主动确认
- 一次只生成用户指定章节的分镜，不一次性生成全部
- 短剧分镜格式与小说分镜不同，需单独定义，当前为预留接口
