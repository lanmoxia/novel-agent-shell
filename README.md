# novel-agent-shell-demo

小说/剧本创作 Agent 壳子 —— 可插拔题材 Skill 的创作流程调度框架。

## 定位

这是一个由 Codex 维护的**小说/剧本创作流程调度壳子**。壳子只负责流程管理，不内置任何具体题材的写作规则。

本项目当前不生成具体小说内容，不包含具体题材写作规则，只提供可插拔题材 Skill 的调度壳子。

## 当前迁移状态

本项目原本是小说 / 剧本 Agent 壳子，目前正在向**教辅类 AI 真人古风短剧生产系统**迁移。

当前重点不是立即重构 `workflow/` 或生成业务内容，而是先沉淀可插拔 Skill 与长期上下文机制。新会话应先读取 `docs/AI-CONTEXT/README.md`、`docs/AI-CONTEXT/CURRENT-STATE.md`、`docs/AI-CONTEXT/BACKLOG.md` 和 `docs/AI-CONTEXT/LAST-TASK.md`，再决定是否继续架构审计、Skill 合约检查或模板评估。`docs/AI-CONTEXT/archive/` 为按需读取的历史归档区，不是默认上下文。

## 核心功能

1. **流程管理**：8 阶段创作流程（建档 → 题材加载 → 企划 → 大纲 → 正文 → 审查 → 修订 → 锁稿）
2. **题材解耦**：题材写作规则以 Skill 插件形式放入 `genre-skills/`，壳子不关心具体内容
3. **审查闭环**：4 类审查 Agent（结构、连续性、对白、题材符合度）
4. **反馈进化**：用户反馈自动记录，同类问题 3 次以上触发规则升级建议
5. **阶段门禁**：Hook 脚本兜底，防止跳过关键阶段
6. **后置模块**：分镜和 Seedance 提示词默认关闭，锁稿后才可启用

## 目录结构

```
novel-agent-shell-demo/
├── README.md
├── docs/                        # 架构文档
│   ├── SHELL-SPEC.md
│   ├── GENRE-SKILL-CONTRACT.md
│   ├── SHELL-BUILD-PLAN.md
│   ├── TOKEN-CONTROL.md
│   └── OPEN-QUESTIONS.md
├── genre-skills/                # 题材 Skill 插件目录
│   ├── README.md
│   └── _contract-example/
├── projects/                    # 创作项目输出目录
│   └── README.md
└── workflow/                    # Codex 维护的流程规则资产
    ├── ORCHESTRATION.md         # 顶层调度规则
    ├── skills/                  # 8 个通用流程 Skill
    ├── agents/                  # 6 个审查/反馈 Agent
    ├── hooks/                   # 4 个阶段门禁 Hook
    └── feedback/                # 反馈记录与进化系统
```

## 快速开始

1. 将题材 Skill 放入 `genre-skills/<skill-name>/`
2. 运行 `bash scripts/new-project.sh <project-name>` 创建项目
3. 按 Phase 0 → Phase 8 推进：建档 → 题材加载 → 企划 → 大纲 → 正文 → 审查 → 修订 → 锁稿
4. 维护前运行 `bash scripts/validate-shell.sh` 检查结构、工作流资产和 Skill 合约

## 维护命令

PowerShell（Windows）：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/new-project.ps1 huanghe-minsu-horror-002
powershell -ExecutionPolicy Bypass -File scripts/validate-shell.ps1
powershell -ExecutionPolicy Bypass -File scripts/project-status.ps1 huanghe-minsu-horror-001 -Validate
powershell -ExecutionPolicy Bypass -File scripts/validate-project-state.ps1 huanghe-minsu-horror-001
powershell -ExecutionPolicy Bypass -File scripts/new-proposal.ps1 20260518-120000-proposal.md
powershell -ExecutionPolicy Bypass -File scripts/update-lock-manifest.ps1 huanghe-minsu-horror-001
```

Bash：

```bash
bash scripts/new-project.sh huanghe-minsu-horror-002
bash scripts/validate-shell.sh
bash scripts/project-status.sh --validate huanghe-minsu-horror-001
bash scripts/new-proposal.sh 20260518-120000-proposal.md
bash scripts/update-lock-manifest.sh huanghe-minsu-horror-001
bash scripts/validate-workflow-assets.sh
bash scripts/validate-genre-skills.sh
bash scripts/validate-projects.sh
bash scripts/validate-project-state.sh huanghe-minsu-horror-001
```

## 题材 Skill 放置

将题材 Skill 放入 `genre-skills/` 即可被自动识别。至少需要一个 `SKILL.md` 文件。

详细合约见 [docs/GENRE-SKILL-CONTRACT.md](docs/GENRE-SKILL-CONTRACT.md)。

## 后置模块

分镜和 Seedance 提示词是后置模块，默认关闭。必须在锁稿后才允许启用。

## 当前状态

- **主流程 Phase 0 → Phase 8 已闭环跑通。**
- `projects/test-xianshi-demo/` 是示例项目，展示了完整流程输出。**正式使用时不要复制其正文内容。**
- `workflow/settings*.json` 和 `.claude/` 是运行配置兼容残留，不属于当前必需文件。详见 `docs/TEMPLATE-PACKAGING-GUIDE.md`。
- 新建正式项目的流程见 `docs/NEXT-PRODUCTION-STEPS.md`。

## 安全约束

- 不自动修改规则
- Hook 脚本不联网、不删文件
- 所有规则升级需用户确认
