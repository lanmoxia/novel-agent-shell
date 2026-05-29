# Phase 1 修复与验收报告

- 修复时间：2026-05-12
- 修复范围：.claude/agents/*.md、.claude/hooks/*.sh、.claude/settings.json
- 修复状态：已完成

---

## 一、修复的文件清单

| # | 文件 | 修复内容 |
|---|------|----------|
| 1 | `.claude/agents/structure-reviewer.md` | 删除 `agentMode: subagent`，新增 `tools: Read, Grep, Glob` |
| 2 | `.claude/agents/continuity-reviewer.md` | 删除 `agentMode: subagent`，新增 `tools: Read, Grep, Glob` |
| 3 | `.claude/agents/dialogue-reviewer.md` | 删除 `agentMode: subagent`，新增 `tools: Read, Grep, Glob` |
| 4 | `.claude/agents/genre-reviewer.md` | 删除 `agentMode: subagent`，新增 `tools: Read, Grep, Glob` |
| 5 | `.claude/agents/feedback-observer.md` | 删除 `agentMode: subagent`，新增 `tools: Read, Write, Edit, Grep, Glob` |
| 6 | `.claude/agents/evolution-runner.md` | 删除 `agentMode: subagent`，新增 `tools: Read, Write, Grep, Glob` |
| 7 | `.claude/hooks/detect-feedback-signal.sh` | 重写：从 stdin 读取 JSON → 解析 prompt 字段 → 检测中文关键词 → 输出中文提示 |
| 8 | `.claude/hooks/stop-gate.sh` | 重写：严重问题输出到 stderr、exit 2 阻断停止；无问题 exit 0 |
| 9 | `.claude/hooks/stage-gate.sh` | 新增注释：明确标注"仅提醒型门禁，非强阻断"，始终 exit 0 |

---

## 二、Hook 阻断行为说明

### 强阻断 Hook（会阻止 Claude Code 操作）

| Hook | 触发时机 | 阻断条件 | 阻断行为 |
|------|----------|----------|----------|
| `stop-gate.sh` | Stop（停止前） | scripts/ 有更新但未审查 | stderr 输出错误，exit 2，阻止停止 |
| `stop-gate.sh` | Stop（停止前） | 审查不通过但无 revision-log.md | stderr 输出错误，exit 2，阻止停止 |
| `stop-gate.sh` | Stop（停止前） | 已锁稿但缺少 final-review.md | stderr 输出错误，exit 2，阻止停止 |

### 仅提醒 Hook（不会阻断任何操作）

| Hook | 触发时机 | 行为 |
|------|----------|------|
| `detect-feedback-signal.sh` | UserPromptSubmit | 检测到反馈关键词时向 stdout 输出中文提示，始终 exit 0 |
| `stage-gate.sh` | SubagentStop | 阶段门禁不满足时向 stdout 输出提醒，始终 exit 0 |
| `check-evolution.sh` | SessionStart | 有反馈记录时提示考虑进化扫描，始终 exit 0（本次未修改） |

---

## 三、settings.json 验收

- 路径：`.claude/settings.json`
- 结构合法：`hooks` → 四个事件（UserPromptSubmit / Stop / SubagentStop / SessionStart）→ matchers → command hooks
- 所有 hook 路径指向正确的 `.claude/hooks/*.sh` 文件
- **未添加** auto-push
- **未添加** bypass permissions
- **未修改** check-evolution.sh（已符合要求）

---

## 四、如何测试 feedback 检测

### 手动测试

在终端中模拟 Claude Code hook 传入的 JSON：

```bash
echo '{"prompt":"不对，这个人物性格写错了"}' | bash .claude/hooks/detect-feedback-signal.sh
```

预期输出：
```
[feedback-signal] 检测到用户反馈信号，建议调用 feedback-observer 记录。注意：不辩解、不扩写，只记录明确信号。
```

### 无关键词时

```bash
echo '{"prompt":"请帮我写下一章"}' | bash .claude/hooks/detect-feedback-signal.sh
```

预期：无输出，静默退出。

### 边界情况

```bash
# 空 prompt
echo '{"prompt":""}' | bash .claude/hooks/detect-feedback-signal.sh
# 预期：静默退出

# 缺少 prompt 字段
echo '{"other_field":"value"}' | bash .claude/hooks/detect-feedback-signal.sh
# 预期：静默退出

# stdin 为空
echo '' | bash .claude/hooks/detect-feedback-signal.sh
# 预期：静默退出
```

---

## 五、如何测试 stop-gate

### 手动测试（模拟阻断场景）

在 projects/test-project/ 下创建触发条件：

```bash
# 场景 1：scripts/ 有文件但无 final-review.md
mkdir -p projects/test-project/scripts
echo "# test" > projects/test-project/scripts/episode-1.md
bash .claude/hooks/stop-gate.sh
echo "exit code: $?"
# 预期：stderr 输出阻断信息，exit 2
```

```bash
# 场景 2：审查不通过但无 revision-log.md
mkdir -p projects/test-project/reviews
echo "审查结论：不通过" > projects/test-project/reviews/final-review.md
bash .claude/hooks/stop-gate.sh
echo "exit code: $?"
# 预期：stderr 输出阻断信息，exit 2
```

```bash
# 场景 3：正常状态（无 projects 目录或无问题）
rm -rf projects/test-project
bash .claude/hooks/stop-gate.sh
echo "exit code: $?"
# 预期：静默，exit 0
```

---

## 六、未修改的文件

- `.claude/hooks/check-evolution.sh`：已有正确的 `不得自动修改` 提示，无需修改
- `.claude/CLAUDE.md`：未修改
- 所有 `genre-skills/` 目录：本次不涉及

---

## 七、验收结论

- [x] 当前启动目录为 `novel-agent-shell-demo`
- [x] 6 个 Agent 文件已清理 `agentMode`，已添加明确 `tools` 字段
- [x] `detect-feedback-signal.sh` 已改为 stdin JSON 解析，不依赖 `CLAUDE_USER_INPUT`
- [x] `stop-gate.sh` 严重问题走 stderr + exit 2，无问题走 exit 0
- [x] `stage-gate.sh` 已标注仅提醒型门禁
- [x] `settings.json` 结构合法
- [x] 无 auto-push
- [x] 无 bypass permissions
- [x] 无小说内容生成
- [x] 无分镜或 Seedance 提示词生成
