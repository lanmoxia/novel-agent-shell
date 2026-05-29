#!/usr/bin/env bash
# detect-feedback-signal.sh - 检测用户反馈信号
# 触发时机：UserPromptSubmit（每次用户提交 prompt 时）
# 从 stdin 读取运行器传入的 JSON，解析 prompt 字段
# 检测中文反馈关键词，检测到时输出中文上下文提示（stdout）
# 不阻断用户输入，始终 exit 0

set -euo pipefail

# 从 stdin 读取 hook 传入的 JSON
HOOK_JSON=$(cat)

# 解析 prompt 字段（使用 grep/sed 做简单解析，避免依赖 jq）
USER_PROMPT=$(echo "$HOOK_JSON" | grep -o '"prompt"[[:space:]]*:[[:space:]]*"[^"]*"' | head -1 | sed 's/^[^:]*:[[:space:]]*"//;s/"$//' || true)

# 如果无法获取用户输入，静默退出
if [ -z "$USER_PROMPT" ]; then
  exit 0
fi

# 反馈信号关键词列表（中文）
FEEDBACK_KEYWORDS=(
  "不对"
  "不是这样"
  "你又"
  "以后不要"
  "记住"
  "这次漏了"
  "风格不对"
  "人物不对"
  "节奏不对"
  "太AI"
  "太假"
  "要接地气"
  "不要跳步"
  "之前说过"
  "上次不是"
  "我说过"
  "改回去"
  "别这样"
  "老是"
  "又是"
)

DETECTED=0

for keyword in "${FEEDBACK_KEYWORDS[@]}"; do
  if echo "$USER_PROMPT" | grep -qi "$keyword" 2>/dev/null; then
    DETECTED=1
    break
  fi
done

if [ $DETECTED -eq 1 ]; then
  echo "[feedback-signal] 检测到用户反馈信号，建议调用 feedback-observer 记录。注意：不辩解、不扩写，只记录明确信号。"
fi

# 始终 exit 0，不阻断用户输入
exit 0
