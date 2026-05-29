#!/usr/bin/env bash
# check-evolution.sh - 会话启动时检查是否需要进化扫描
# 在 SessionStart 时触发

set -euo pipefail

PROJECT_DIR="${WORKFLOW_PROJECT_DIR:-.}"
FEEDBACK_DIR="$PROJECT_DIR/workflow/feedback"

if [ ! -d "$FEEDBACK_DIR" ]; then
  exit 0
fi

# 统计反馈文件数量（排除索引文件和 README）
FEEDBACK_COUNT=$(find "$FEEDBACK_DIR" -maxdepth 1 -name "*-feedback.md" -type f 2>/dev/null | wc -l)

if [ "$FEEDBACK_COUNT" -gt 0 ]; then
  echo "[check-evolution] workflow/feedback/ 中有 $FEEDBACK_COUNT 条反馈记录。"

  # 检查是否有新增反馈（最近24小时内）
  NEW_FEEDBACK=$(find "$FEEDBACK_DIR" -maxdepth 1 -name "*-feedback.md" -type f -mtime -1 2>/dev/null | wc -l)

  if [ "$NEW_FEEDBACK" -gt 0 ]; then
    echo "[check-evolution] 最近 24 小时内有 $NEW_FEEDBACK 条新反馈，请考虑调用 evolution-runner 扫描。"
  fi
fi

# 检测是否有同类反馈达到 3 次（通过简单聚类）
# 从 feedback-index.md 中读取分类、层级和优先级统计
INDEX_FILE="$FEEDBACK_DIR/feedback-index.md"
if [ -f "$INDEX_FILE" ]; then
  # 提取分类列，统计每种分类的出现次数
  CATEGORIES=$(grep -oP '结构|连续性|对白|题材|流程|输出格式|其他' "$INDEX_FILE" 2>/dev/null | sort | uniq -c | sort -rn || true)

  if [ -n "$CATEGORIES" ]; then
    while read -r count category; do
      if [ "$count" -ge 3 ] 2>/dev/null; then
        echo "[check-evolution] 类别 '$category' 的反馈已达到 $count 次，建议生成规则升级建议。"
      fi
    done <<< "$CATEGORIES"
  fi

  LAYERS=$(grep -oP '壳子|全局知识库|题材 Skill|项目记忆' "$INDEX_FILE" 2>/dev/null | sort | uniq -c | sort -rn || true)
  if [ -n "$LAYERS" ]; then
    while read -r count layer; do
      if [ "$count" -ge 3 ] 2>/dev/null; then
        echo "[check-evolution] 层级 '$layer' 的反馈已达到 $count 次，建议生成分层进化提案。"
      fi
    done <<< "$LAYERS"
  fi

  P0_COUNT=$(grep -o 'P0' "$INDEX_FILE" 2>/dev/null | wc -l || true)
  if [ "$P0_COUNT" -gt 0 ] 2>/dev/null; then
    echo "[check-evolution] 检测到 $P0_COUNT 条 P0 反馈，建议优先检查壳子流程、门禁、状态或校验。"
  fi
fi

echo "[check-evolution] 不得自动修改 ORCHESTRATION.md 或 SKILL.md，所有升级需用户确认。"

exit 0
