# 小说/剧本创作 Agent 壳子规格说明

> 本文档描述 novel-agent-shell-demo 的架构设计、核心决策和整体约束。面向后续开发者和维护者。

---

## 1. 项目定位

`novel-agent-shell-demo` 是一个**小说/剧本创作 Agent 调度壳子**，当前由 Codex 维护。

它不是一个"一句话生成小说"的工具，而是一个**创作流程管理器**。壳子本身不包含任何具体题材的写作规则。

当前壳子支持多业务语义：旧小说 / 剧本项目继续按原 Phase 0-8 解释；教辅短剧项目可以在不改变 Phase 编号和门禁机制的前提下，按教辅短剧语义解释同一套阶段。壳子仍只负责阶段、状态、门禁和恢复，不负责具体教学规则。

### 核心职责

1. 管理从项目建档到锁稿的完整创作流程
2. 调度通用流程 Skill（8 个阶段 Skill）
3. 加载外部题材 Skill 插件（genre-skills/）
4. 在关键阶段强制触发审查（4 类审查 Agent）
5. 维护项目长期记忆，记录稳定事实、人物状态、伏笔和修订影响
6. 使用倒推式规划，先锁定结局、真相和情绪落点，再生成大纲
7. 使用机器可读状态文件记录项目阶段和确认产物
8. 记录用户反馈并沉淀规则优化建议
9. 在剧本锁定后才允许启用后置模块（分镜、Seedance）
10. 通过 `scripts/validate-shell.sh` / `scripts/validate-shell.ps1` 统一验证结构、模板、项目状态和 Skill 合约

### 支持的项目类型

| 项目类型 | 模板 | Phase 语义 |
|---|---|---|
| 小说 / 剧本项目 | `projects/_template/` | 旧小说 / 剧本创作语义 |
| 教辅短剧项目 | `projects/_template-edu-shortdrama/` | 文言文教辅真人古风短剧语义 |

`projects/_template-edu-shortdrama/` 是教辅短剧专用模板目录，用于承载篇目、原文、出处、年级、教学目标、Scene 原文映射、字幕、分镜、视频风险和生产稿包边界。它不替代旧 `projects/_template/`，也不改变旧项目的兼容性。

---

## 2. 架构分层

```
┌─────────────────────────────────────────────┐
│              ORCHESTRATION.md              │  ← 顶层规则、流程门禁、调度表
├─────────────────────────────────────────────┤
│           workflow/skills/                  │  ← 通用流程 Skill（8 个）
├─────────────────────────────────────────────┤
│           workflow/agents/                  │  ← 审查 Agent（6 个）
├─────────────────────────────────────────────┤
│           workflow/hooks/                   │  ← 阶段门禁 Hook（4 个）
├─────────────────────────────────────────────┤
│           workflow/theory/                  │  ← 倒推、重写、伏笔、连续性方法论
├─────────────────────────────────────────────┤
│           workflow/execution/               │  ← 重写、记忆更新、审查评分协议
├─────────────────────────────────────────────┤
│           workflow/modes/                   │  ← 企划、诊断、写作、重写模式
├─────────────────────────────────────────────┤
│           docs/SHELL-BOUNDARY.md            │  ← 壳子边界说明
├─────────────────────────────────────────────┤
│           genre-skills/                     │  ← 外部题材 Skill 插件
├─────────────────────────────────────────────┤
│           workflow/feedback/                │  ← 反馈记录 & 进化系统
└─────────────────────────────────────────────┘
```

两层 Skill 体系：

| 类型 | 位置 | 职责 | 触发方式 |
|------|------|------|----------|
| 壳子流程 Skill | `workflow/skills/` | 控制通用流程 | 由 Codex 按文档和文件内容读取维护 |
| 题材 Skill 插件 | `genre-skills/` | 提供题材写作规则 | 由 genre-loader 按需读取 |

---

## 3. 工作阶段

```
Phase 0：项目初始化     → project-intake-builder
Phase 1：题材 Skill 加载 → genre-loader
Phase 2：故事企划       → story-spec-builder（含结局锁定和项目记忆）
Phase 3：大纲 / 节拍    → outline-builder（含倒推大纲、伏笔表、信息释放表）
Phase 4：剧本正文       → script-writer
Phase 5：多维审查       → script-review + 4 个 review agent
Phase 6：修订           → revision-fixer
Phase 7：锁稿           → script-locker
Phase 8：可选后置模块   → 分镜 / Seedance（默认关闭）
```

教辅短剧项目中，同一 Phase 编号按以下语义解释：

| Phase | 旧小说 / 剧本语义 | 教辅短剧语义 |
|---|---|---|
| Phase 0 | 项目初始化 | 项目建档：篇目、原文、出处、年级、时长、输出范围 |
| Phase 1 | 题材 Skill 加载 | 教辅 Skill 加载：锁定 `wenyan-skill`，记录能力声明和缺口 |
| Phase 2 | 故事企划 | 原文拆解与教学目标规格，不是原创故事企划 |
| Phase 3 | 大纲 / 节拍 | 情境复演结构与 Scene 原文映射 |
| Phase 4 | 剧本正文 | 正片剧本、原文映射表、字幕方案草案、分镜草案状态 |
| Phase 5 | 多维审查 | 教学与生产审查 |
| Phase 6 | 修订 | 教学错误、映射错误、字幕、分镜和视频风险修订 |
| Phase 7 | 锁稿 | 生产稿包锁定；`FINAL-SCRIPT.md` 不代表完整生产稿包 |
| Phase 8 | 可选后置模块 | 短剧分镜、字幕、视频风险说明和可选视频提示词，默认关闭 |

该表只同步文档语义，不改变 Hook、脚本或项目创建逻辑。

---

## 4. 阶段门禁规则

| 门禁 | 前置条件 | 禁止行为 |
|------|----------|----------|
| Gate 0→1 | PROJECT.md 存在 | 禁止未建档就加载题材 |
| Gate 1→2 | GENRE-SKILL-LOCK.md 存在 | 禁止未锁定题材就企划 |
| Gate 2→3 | specs/STORY-SPEC.md 存在 | 禁止未确认企划就出大纲 |
| Gate 3→4 | outlines/OUTLINE.md 存在 | 禁止未确认大纲就写正文 |
| Gate 4→5 | scripts/ 有内容 | 禁止未写正文就审查 |
| Gate 5→6 | final-review.md 存在 | 禁止未审查就修订 |
| Gate 6→7 | revision-log.md 存在 | 禁止未修订就锁稿 |
| Gate 7→8 | FINAL-SCRIPT.md 存在、用户确认 | 禁止未锁稿就启用后置模块 |

---

## 5. 输出目录结构

每个创作项目在 `projects/<project-name>/` 下生成：

```
projects/<project-name>/
├── PROJECT.md
├── PROJECT-STATE.json
├── RUN-LOG.md
├── GENRE-SKILL-LOCK.md
├── PROJECT-MEMORY.md
├── materials/
├── planning/
│   ├── ENDING-LOCK.md
│   ├── REVERSE-OUTLINE.md
│   ├── FORESHADOW-LEDGER.md
│   └── REVEAL-SCHEDULE.md
├── specs/
│   └── STORY-SPEC.md
├── outlines/
│   └── OUTLINE.md
├── scripts/
│   ├── SCRIPT-STATUS.md
│   └── E01-标题.md ...
├── reviews/
│   ├── structure-review.md
│   ├── continuity-review.md
│   ├── dialogue-review.md
│   ├── genre-review.md
│   └── final-review.md
├── revisions/
│   ├── snapshots/
│   └── revision-log.md
├── drafts/
│   └── rewrite-candidates/
├── locked/
│   ├── FINAL-SCRIPT.md
│   └── LOCK-MANIFEST.sha256
├── shotlists/
├── short-drama-shotlists/
└── seedance-prompts/
```

教辅短剧项目可基于 `projects/_template-edu-shortdrama/` 创建候选项目结构。该模板保留壳子状态文件和 Phase 门禁，同时把以下文件显示语义调整为教辅短剧：

- `PROJECT.md`：项目建档。
- `GENRE-SKILL-LOCK.md`：教辅 Skill 锁定和 capabilities 记录。
- `specs/STORY-SPEC.md`：原文拆解与教学目标规格。
- `planning/ENDING-LOCK.md`：原文结果与学习闭环锁定。
- `outlines/OUTLINE.md`：情境复演结构与 Scene 映射。
- `scripts/SCRIPT-STATUS.md`：正片剧本、原文映射、字幕、分镜状态。
- `reviews/`：教学与生产审查。
- `locked/`：生产稿包锁定区。
- `short-drama-shotlists/`、`seedance-prompts/`：Phase 8 后置输出区，默认关闭并等待用户确认。

---

## 6. 核心设计原则

```
壳子负责流程，不负责题材。
题材 Skill 提供规则，不控制流程。
教辅 Skill 提供原文拆解、释义、教学目标、Scene 映射、字幕、分镜和审查规则，但不接管 workflow。
Sub-Agent 负责审查，不直接改文。
Hook 负责兜底，不替代主流程。
Feedback 负责沉淀，不自动改规则。
Evolution 只提建议，必须用户确认。
分镜和 Seedance 是后置模块，锁稿后才启用。
中大问题优先重写候选，不无边界原地修改。
项目记忆记录稳定事实，不依赖会话上下文临时记忆。
Markdown 主要给人读，`PROJECT-STATE.json` 主要给脚本和恢复流程读。
`RUN-LOG.md` 记录每次阶段动作，支持跨会话断点恢复。
`project-status` 提供单项目恢复视图，`validate-project-state` 校验机器状态与关键产物是否自洽。
反馈进化必须分层记录：壳子、全局知识库、题材 Skill、项目记忆；进化提案只写入 `workflow/feedback/proposals/`，不自动修改规则。
教辅短剧项目的文言文解释、原文映射、字幕规则、分镜规则、视频风险和教学审查由 Skill、模板和审查产物承担；shell 不负责判断具体释义是否正确。
```

---

## 7. 安全约束

- 不启用 bypass permissions
- Hook 脚本不联网
- Hook 脚本不删除用户文件
- Hook 脚本不修改系统环境变量
- 进化系统不自动修改 ORCHESTRATION.md、SKILL.md、Agent 或 Hook
- 锁稿后应生成 `locked/LOCK-MANIFEST.sha256`，用于检测最终稿和章节文件是否被改动

---

## 8. 语言约定

- 所有用户可见内容使用中文
- 文件名、目录名、Skill 名、Agent 名、Hook 名使用英文或拼音
- YAML frontmatter 中的 description 使用中文

---

## 9. 不确定项

见 [OPEN-QUESTIONS.md](OPEN-QUESTIONS.md)。
