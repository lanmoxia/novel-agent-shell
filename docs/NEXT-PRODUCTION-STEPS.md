# 后续生产化使用流程

本文件说明使用本壳子创建正式小说/剧本项目的完整流程。

---

## 1. 新建正式项目

**入口方式**：在 Windows 上运行 `powershell -ExecutionPolicy Bypass -File scripts/new-project.ps1 <project-name>`，或在 Bash 环境运行 `bash scripts/new-project.sh <project-name>`。脚本会从 `projects/_template/` 创建一个新目录到 `projects/<project-name>/`，再按 Phase 0 → Phase 8 填写和生成文件。维护前建议运行 `powershell -ExecutionPolicy Bypass -File scripts/validate-shell.ps1` 或 `bash scripts/validate-shell.sh`。

跨会话恢复时，先读取单项目状态：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/project-status.ps1 <project-name> -Validate
```

```bash
bash scripts/project-status.sh --validate <project-name>
```

项目建档需要明确以下信息：
- 项目名称
- 作品类型（小说 / 剧本）
- 篇幅（短篇 / 中篇 / 长篇）
- 目标用户
- 输出形式

**不要**直接复制 `projects/test-xianshi-demo/` 的正文内容。test-xianshi-demo 是测试项目，正文为测试数据。新建项目时只复用壳子框架。

---

## 2. 选择题材 Skill

`genre-loader` 会扫描 `genre-skills/` 目录，列出可用题材 Skill。选择后生成 `GENRE-SKILL-LOCK.md`。

当前可用的题材 Skill：
- `xianshi-skill`：现实职场题材
- `gudai-skill`：古代题材

如果需要的题材没有对应 Skill，放入 `genre-skills/` 目录后运行 `bash scripts/validate-genre-skills.sh` 检查合约。

**不得**在未加载题材 Skill 的情况下进入写作。

---

## 3. 从故事企划开始（Phase 2）

`story-spec-builder` 会基于项目档案和题材 Skill 生成 `specs/STORY-SPEC.md`，包含：
- 核心创意
- 人物设定
- 核心冲突
- 调性
- 结局方向
- 题材限制

**必须等待用户确认 STORY-SPEC.md 后，才能进入大纲阶段。**

---

## 4. 大纲生成（Phase 3）

`outline-builder` 生成章纲（小说）或集纲/场次节拍（剧本）。

小说输出：`outlines/OUTLINE.md`（逐章大纲）
剧本输出：集纲 + 场次节拍

**必须等待用户确认 OUTLINE.md 后，才能进入正文写作。**

---

## 5. 正文写作（Phase 4）

`script-writer` 逐章或逐集写正文。一次只能写当前请求的章节。

正文输出到：`scripts/E##-标题.md`

**不得一次性无控制生成全部章节。** 每次生成后等待确认。

---

## 6. 需要用户确认的阶段节点

以下节点必须等待用户明确确认，壳子不会自动推进：

| 阶段过渡 | 确认内容 |
|----------|----------|
| Phase 1 → Phase 2 | 题材 Skill 选择 |
| Phase 2 → Phase 3 | STORY-SPEC.md |
| Phase 3 → Phase 4 | OUTLINE.md |
| Phase 4 → Phase 5 | 全部章节写作完成 |
| Phase 5 → Phase 6 | 审查报告 + **修订范围选择**（A/B/C） |
| Phase 6 → Phase 7 | 接受剩余问题 / 继续修订 |
| Phase 7 → Phase 8 | 后置输出类型选择 |

**stop-gate 的阻断提示不是自动推进的信号。** 每次跨阶段必须用户主动发起。

---

## 7. 审查流程（Phase 5）

正文完成后，运行 `script-review`。四类审查依次执行：
1. 结构审查（structure-reviewer）
2. 连续性审查（continuity-reviewer）
3. 对白审查（dialogue-reviewer）
4. 题材符合度审查（genre-reviewer）

输出汇总到 `reviews/final-review.md`。

审查完成后，壳子会提供修订选项：
- **A**：仅修复严重问题
- **B**：修复严重 + 中等问题
- **C**：全部修复

用户必须明确选择，壳子不会自动默认。

---

## 8. 修订流程（Phase 6）

`revision-fixer` 按用户选择的范围修订。一次只修一类问题，修完复查。

**不得在用户选择 A 时继续修中等/轻微问题。**
**不得在用户选择 B 时继续修轻微问题。**

修订完成后，等待用户决定继续修订或进入锁稿。

---

## 9. 锁稿（Phase 7）

`script-locker` 确认所有条件满足后生成 `locked/FINAL-SCRIPT.md`。

锁稿后正文不得修改。

---

## 10. 后置模块（Phase 8）

锁稿后可选择进入后置模块。默认只启用小说分镜（`shotlists/`）。

Seedance 提示词默认关闭，需用户明确要求。

---

## 11. 避免长会话上下文污染

- **每个 Phase 完成后，建议重新整理当前项目状态。** 尤其在 Phase 5 审查和 Phase 6 修订之间。
- 审查输出量大，审查完成后上下文容易膨胀。继续下一阶段前应优先读取 `SCRIPT-STATUS.md`、`reviews/final-review.md` 和 `PROJECT-MEMORY.md`（如存在）。
- 以下节点特别建议重开：
  - Phase 4 正文完成后（审查前）
  - Phase 5 审查报告完成后（修订前）
  - Phase 7 锁稿完成后（后置模块前）
- 继续工作时，项目状态以 `scripts/SCRIPT-STATUS.md` 和项目内稳定记录为准。

---

## 12. 需要发压缩包给外部审查的场景

本壳子的审查规则保存在 `workflow/agents/`。如果需要**人工外部审查**（如编辑、合作者审稿），建议：
1. 将 `projects/<project-name>/scripts/` 下所有章节打包成 .zip
2. 附上 `reviews/final-review.md` 作为参考
3. 外部审查意见回来后，手动录入为 revision-fixer 的修订依据

壳子当前不支持导入外部审查报告。

---

## 13. 快速参考：完整流程

```
运行 `scripts/new-project.ps1` 或 `scripts/new-project.sh`
→ Phase 0: project-intake-builder 规则（项目建档）
→ Phase 1: genre-loader（选择题材 Skill）
→ Phase 2: story-spec-builder（等待确认 STORY-SPEC.md）
→ Phase 3: outline-builder（等待确认 OUTLINE.md）
→ Phase 4: script-writer（逐章写作，等待确认）
→ Phase 5: script-review（审查 + 等待用户选择修订范围）
→ Phase 6: revision-fixer（修订 + 等待用户决定锁稿）
→ Phase 7: script-locker（锁稿）
→ Phase 8: post-production-builder（可选，等待用户选择输出类型）
```
