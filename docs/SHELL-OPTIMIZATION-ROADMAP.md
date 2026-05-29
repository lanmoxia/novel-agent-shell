# 小说 Agent 壳子优化大纲

> 历史参考说明：本文件已不再作为当前任务清单或新会话接力文件。当前任务清单以 `docs/AI-CONTEXT/BACKLOG.md` 为准，当前状态以 `docs/AI-CONTEXT/CURRENT-STATE.md` 为准。本文件仅作为旧壳子优化历史参考保留。

> 用途：作为后续会话接力文件。新会话可先读取本文，理解当前优化方向、边界和优先级。

---

## 1. 当前项目定位

本项目是一个**小说/剧本创作 Agent 调度壳子**，不是单一写作 Skill，也不是某个题材的写作知识库。

壳子的核心职责：

- 管理项目从建档到锁稿的完整生命周期
- 维护阶段门禁、状态、产物目录和校验规则
- 加载和调度可插拔 Skill
- 调度审查、修订、锁稿、后置模块
- 维护项目长期记忆、运行记录和规则进化建议
- 保证不同 Skill、不同题材、不同项目之间的边界清晰

题材、文风、具体写法、案例和专门方法论应尽量通过可插拔 Skill 或知识库提供，而不是硬编码进壳子主流程。

---

## 2. 已完成的一轮优化

已完成方向：

1. 项目长期记忆制度化  
   新增 `PROJECT-MEMORY.md`，用于记录稳定事实、人物状态、伏笔、信息释放、修订影响。

2. 倒推式规划制度化  
   新增：
   - `planning/ENDING-LOCK.md`
   - `planning/REVERSE-OUTLINE.md`
   - `planning/FORESHADOW-LEDGER.md`
   - `planning/REVEAL-SCHEDULE.md`

3. 重写候选机制  
   新增：
   - `drafts/rewrite-candidates/`
   - `revisions/snapshots/`

   规则：轻微问题可局部修；中等/严重问题优先诊断后生成重写候选，不直接覆盖正式正文。

4. workflow 方法论和执行协议  
   新增：
   - `workflow/theory/`
   - `workflow/execution/`
   - `workflow/modes/`

5. 审查标准升级  
   四类审查 Agent 增加项目记忆读取、倒推规划读取、0-5 评分和修订/重写建议。

6. 校验脚本增强  
   Bash 和 PowerShell 双入口已验证通过：
   - `bash scripts/validate-shell.sh`
   - `powershell -NoProfile -ExecutionPolicy Bypass -File scripts/validate-shell.ps1`

7. 壳子边界与机器状态  
   已新增：
   - `docs/SHELL-BOUNDARY.md`
   - `projects/_template/PROJECT-STATE.json`
   - `projects/_template/RUN-LOG.md`
   - `scripts/migrate-project.sh`
   - `scripts/migrate-project.ps1`

8. 知识库分层与 Skill 能力声明  
   已新增：
   - `docs/KNOWLEDGE-LAYERING.md`

   已扩展：
   - `docs/GENRE-SKILL-CONTRACT.md` 增加 `capabilities`
   - `workflow/skills/genre-loader/SKILL.md` 增加能力声明读取、推断和兜底记录
   - 现有题材 Skill 的 `SKILL.md` 已补充 capabilities 字段

   说明：根目录 `knowledge/global/` 已撤回。全局知识库不放在仓库根目录，后续应根据 Skill 测试结果作为全局 Skill 包或 Skill 资源承载。

9. Skill 锁定指纹与漂移检测
   已新增：
   - `scripts/update-skill-lock-manifest.sh`
   - `scripts/update-skill-lock-manifest.ps1`
   - `locked/SKILL-LOCK-MANIFEST.sha256`

   用途：记录项目锁定时题材 Skill 文件 hash。后续 Skill 文件变化时，校验脚本提示漂移，不评价内容对错。

10. 项目状态快速恢复
   已新增：
   - `scripts/project-status.sh`
   - `scripts/project-status.ps1`
   - `scripts/validate-project-state.sh`
   - `scripts/validate-project-state.ps1`

   用途：快速读取 `PROJECT-STATE.json` 和 `RUN-LOG.md`，输出当前阶段、状态、锁稿状态和下一步；`--validate` / `-Validate` 可联动单项目状态校验。

11. 恢复/校验联动
   `validate-project-state` 已接入 Bash 与 PowerShell 双入口，并纳入 `validate-shell`。它会校验 `PROJECT-STATE.json` 的 phase/status/locked 与关键产物、确认字段、RUN-LOG 最新阶段是否自洽。

12. 进化系统分层提案
   已新增：
   - `workflow/feedback/proposals/`
   - `workflow/feedback/proposals/TEMPLATE.md`
   - `scripts/new-proposal.sh`
   - `scripts/new-proposal.ps1`

   已扩展：
   - `feedback-observer` 记录层级和优先级
   - `evolution-runner` 生成分层提案文件
   - `check-evolution.sh` 统计分类、层级和 P0 反馈

   规则：提案只记录建议，不自动修改 `ORCHESTRATION.md`、Skill、Agent、Hook 或项目记忆。

---

## 3. 壳子与 Skill 的边界

### 壳子可以定义

- 阶段流程和门禁
- 项目目录结构
- 文件命名和状态记录
- Skill 加载协议
- Skill 能力声明格式
- 审查调度流程
- 修订/重写协议
- 锁稿和后置模块规则
- 反馈与进化机制
- 校验脚本和迁移脚本

### 壳子不应硬编码

- 某个题材的专属写法
- 某种固定文风
- 某类故事的唯一结构
- 某个题材的禁忌细节
- 具体案例全文
- 单个作者的风格偏好

这些内容应由 Skill 或知识库提供。

---

## 4. 知识库分层设想

后续 Skill 和知识库不应只有当前题材 Skill 一层，可以分为三层：

### 4.1 全局写作知识库

适用于所有题材和所有项目，作为底层兜底机制。

可能内容：

- 通用叙事原则
- 文风控制原则
- 对白基本原则
- 长篇连续性原则
- 倒推设计原则
- 重写而非乱改的原则
- AI 协作注意事项
- 常见创作风险清单

建议承载方式：

```text
skills/global-writing-core/
```

当前不在根目录维护全局知识库内容，避免过早固化。

### 4.2 题材级知识库

绑定单个题材或类型，比如现实题材、古代题材、民俗恐怖、悬疑、短剧等。

可能内容：

- 题材结构规则
- 题材文风
- 题材禁忌
- 典型人物关系
- 常见冲突模型
- 题材审查 rubric
- 题材案例和反例

当前已有落点：

```text
genre-skills/<skill-name>/
```

后续可以继续强化 Skill 合约，而不是把内容写进壳子。

### 4.3 项目级知识库

绑定单个作品项目，只记录该项目自己的稳定事实。

当前落点：

```text
projects/<project-name>/PROJECT-MEMORY.md
projects/<project-name>/planning/
projects/<project-name>/materials/
```

项目级知识库不能污染全局知识库，也不能自动反向改写题材 Skill。

---

## 5. Skill 插件协议优化方向

壳子后续应根据 Skill 技能包继续优化调度方式。重点不是研究 Skill 内容，而是定义 Skill 如何被壳子识别、加载、降级和锁定。

建议为 Skill 增加机器可读能力声明，例如：

```yaml
capabilities:
  supports_novel: true
  supports_script: true
  supports_short_drama: false
  provides_style: true
  provides_dialogue_rules: true
  provides_review_rubric: true
  provides_taboo: true
  provides_examples: true
```

壳子可根据能力声明决定：

- 是否允许用于当前作品类型
- 缺少哪些能力
- 是否需要加载全局兜底知识库
- 审查阶段是否降级
- 是否需要提醒用户补充 Skill 文件

---

## 6. Skill 锁定与复现能力

当前 `GENRE-SKILL-LOCK.md` 已记录 Skill 名称、路径和版本。后续建议增强为：

```text
- Skill 版本：
- Skill 路径：
- 已读取文件：
- 每个已读取文件的 sha256：
- 加载时能力声明：
- 缺失能力：
- 降级策略：
```

目标：

- 项目锁定后，不随 Skill 后续修改漂移
- 能检测当前 Skill 与项目锁定版本是否不一致
- 能解释为什么某次审查是标准审查或降级审查

---

## 7. 机器可读项目状态

当前很多状态写在 Markdown 中，适合人读，但脚本判断容易脆弱。

建议新增：

```text
projects/<project-name>/PROJECT-STATE.json
```

示例字段：

```json
{
  "project": "project-name",
  "phase": 4,
  "status": "drafting",
  "genreSkill": "skill-name",
  "genreSkillVersion": "1.0.0",
  "locked": false,
  "confirmedArtifacts": {
    "storySpec": true,
    "endingLock": true,
    "outline": true,
    "reverseOutline": true
  }
}
```

原则：

- Markdown 继续给人读
- JSON 给脚本、门禁和恢复流程读
- 不用中文文本作为 PowerShell 逻辑判断核心

---

## 8. 运行日志与断点恢复

写作流程可能跨多个会话。壳子应支持断点恢复，不依赖上下文记忆。

建议新增：

```text
projects/<project-name>/RUN-LOG.md
```

记录：

- 执行时间
- 执行动作
- 输入文件
- 输出文件
- 当前阶段
- 是否完成
- 下一步建议

可配合 `PROJECT-STATE.json` 使用。

---

## 9. 统一操作协议

建议在壳子层定义标准动作名，未来可以接 CLI、前端或更强调度器。

建议动作：

```text
new-project
load-genre
build-spec
lock-ending
build-outline
write-chapter
review
revise
rewrite-candidate
accept-rewrite
lock
post-production
status
validate
migrate-project
```

这些动作不一定马上做成命令，但应在 workflow 文档和 Skill 说明中统一。

---

## 10. 进化系统优化方向

当前已有：

- `workflow/feedback/`
- `feedback-observer`
- `evolution-runner`
- 反馈达到一定次数后提出规则升级建议
- 不自动修改规则

后续可继续优化：

### 10.1 反馈分层

将反馈分为：

- 全局壳子反馈：流程、门禁、状态、目录、校验问题
- 全局写作知识反馈：通用文风、改稿、协作方式
- 题材 Skill 反馈：某题材规则不足
- 项目反馈：仅当前项目有效的偏好或事实

不同反馈写入不同位置，不要混在一起。

### 10.2 进化建议分级

建议分为：

| 等级 | 含义 | 处理方式 |
|------|------|----------|
| P0 | 阻塞流程或导致错误产物 | 优先修壳子 |
| P1 | 多次出现的质量问题 | 建议升级全局知识库或 Skill 合约 |
| P2 | 单项目偏好 | 写入项目记忆 |
| P3 | 题材特化偏好 | 写入对应题材 Skill 建议 |

### 10.3 进化提案格式

建议生成：

```text
workflow/feedback/proposals/YYYY-MM-DD-xxx.md
```

内容包括：

- 反馈来源
- 出现次数
- 影响范围
- 建议修改位置
- 是否涉及壳子 / 全局知识库 / 题材 Skill / 项目记忆
- 是否需要用户确认

### 10.4 禁止自动进化

仍保持：

- 不自动改 `ORCHESTRATION.md`
- 不自动改 Skill
- 不自动改全局知识库
- 不自动把项目偏好升级成全局规则

---

## 11. 迁移机制

壳子会持续升级，旧项目可能缺少新目录或新状态文件。

建议新增：

```text
scripts/migrate-project.sh
scripts/migrate-project.ps1
```

用途：

- 为旧项目补齐新目录
- 生成 `PROJECT-STATE.json`
- 回填 planning 文件占位
- 标记哪些内容是历史回填
- 避免伪造旧快照或旧审查

历史回填应显式标注，例如：

```text
historical-backfill: true
historical-no-snapshot: true
```

---

## 12. 校验脚本继续优化

建议拆分更清楚：

```text
validate-shell
validate-template
validate-projects
validate-project-state
validate-skill-contract
validate-lock
validate-post-production
```

重点增强：

- 检查 `PROJECT-STATE.json` 与 Markdown 状态是否一致
- 检查 Skill hash 是否漂移
- 检查锁稿后正文是否改动
- 检查后置模块是否只在 Phase 8 后生成
- 检查修订是否有快照或历史回填说明
- 检查重写候选是否未被误当正式稿

---

## 13. 推荐实施优先级

### 第一优先级：壳子边界与状态

1. 新增 `docs/SHELL-BOUNDARY.md`
2. 新增 `PROJECT-STATE.json` 模板和维护规则
3. 修改校验脚本，优先读取机器状态

### 第二优先级：Skill 协议增强

1. 为 Skill 合约增加 `capabilities`
2. 为 `GENRE-SKILL-LOCK.md` 增加文件 hash
3. 增加 Skill 漂移检测

### 第三优先级：全局知识库/兜底机制

1. 设计 `knowledge/global/` 或全局 Skill 的目录合同
2. 明确它只做通用兜底，不替代题材 Skill
3. 调度器根据 Skill 缺失能力选择是否加载全局兜底

### 第四优先级：进化系统升级

1. 反馈分层
2. 进化提案格式化
3. 进化建议分级
4. 用户确认后再修改规则或知识库

### 第五优先级：迁移工具

1. 新增 `migrate-project`
2. 让旧项目升级到新壳子结构
3. 明确历史回填标记

---

## 14. 下一次会话建议先做

建议下一次继续时，先读取：

```text
docs/CODEX-HANDOFF-SUMMARY.md
docs/SHELL-OPTIMIZATION-ROADMAP.md
docs/SHELL-SPEC.md
docs/GENRE-SKILL-CONTRACT.md
workflow/ORCHESTRATION.md
```

然后优先实现：

1. 进化系统的反馈分层与提案格式
2. 或进一步把 `validate-project-state` 结果接入阶段门禁提示
3. 继续保持壳子层优化，不研究具体题材 Skill 内容

这条路线最符合当前目标：继续优化壳子，不深入研究具体写作 Skill。

---

## 15. 当前进度快照

- 已完成：项目长期记忆、倒推规划、重写候选、审查评分、机器状态 JSON、运行日志、Skill 能力声明、Skill 锁定 hash、项目状态查看脚本、单项目状态校验脚本。
- 已完成：壳子边界文档、迁移脚本、校验脚本双入口、历史项目回填。
- 已完成：撤回根目录全局知识库，改为只保留未来由 Skill 包承载的方向说明。
- 当前重点：继续完善壳子层的恢复、校验、状态与调度，而不是研究具体题材 Skill 内容。
- 下一步建议：进一步把状态校验结果接入阶段门禁提示，或把进化提案索引纳入校验。
