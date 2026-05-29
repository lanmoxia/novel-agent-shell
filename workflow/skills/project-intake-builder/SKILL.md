---
name: project-intake-builder
description: 用于小说或剧本项目启动时收集项目需求、创建项目档案、明确作品类型、篇幅、目标用户、输出形式和题材 Skill 选择。用户说新建项目、开始创作、做一个剧本、做一个小说项目时使用。
---

# project-intake-builder

## 职责

收集项目基础信息并创建项目档案。

## 工作流程

1. 询问项目名称（用户提供则直接使用）
2. 询问作品类型：小说 / 剧本 / 短剧剧本 / 其他
3. 询问篇幅：单集 / 多集 / 短篇 / 中篇
4. 询问目标用途：阅读 / 短剧制作 / 视频化 / 测试
5. 询问题材 Skill 选择（列出 genre-skills/ 中可用的题材 Skill）
6. 从 `projects/_template/` 创建项目目录结构
7. 生成 PROJECT.md
8. 生成或保留 PROJECT-STATE.json 和 RUN-LOG.md
9. 保留 `PROJECT-MEMORY.md`、`planning/`、`materials/`、`drafts/`、`revisions/snapshots/` 等模板资产

## 输出

```
projects/<project-name>/PROJECT.md
projects/<project-name>/PROJECT-STATE.json
projects/<project-name>/RUN-LOG.md
projects/<project-name>/PROJECT-MEMORY.md
```

## PROJECT.md 模板

```markdown
# 项目档案

- 项目名称：
- 作品类型：
- 篇幅：
- 目标用途：
- 题材 Skill：（待锁定）
- 创建时间：
- 当前阶段：Phase 1（题材 Skill 加载）

## 项目说明

（用户输入的项目描述和期望）

## 注意事项

（用户提出的特殊要求和限制）
```

## 注意事项

- 如果用户未明确指定题材 Skill，本阶段可以留空，由 genre-loader 后续处理
- 不要在没有问用户的情况下假设作品类型或篇幅
- 新项目必须从 `projects/_template/` 创建，不得从示例项目复制
- 项目创建后应在 RUN-LOG.md 记录初始化动作
- 项目记忆和倒推规划模板应随项目创建，不得省略
