#!/usr/bin/env bash
# stop-gate.sh - 停止前门禁检查
# 触发时机：停止维护或交付前
# 检测到严重门禁问题时通过 stderr 输出，exit 2 阻止停止
# 没有问题则 exit 0，允许正常停止
#
# 判断顺序（优先级从高到低）：
# 1. 已锁稿（locked/FINAL-SCRIPT.md 存在）→ 优先检查，无论 SCRIPT-STATUS.md 状态如何
#    - 无 final-review.md → 阻断
#    - final-review.md 为占位/不完整 → 阻断
# 2. 正文已完成但待用户确认进入 Phase 5（含"待用户确认进入 Phase 5"）→ 仅提醒，不阻断
# 3. 正文生成中（SCRIPT-STATUS.md 含"正文生成中"）→ 仅提醒，不阻断
# 4. Phase 6 等待用户决策（含"待用户确认进入 Phase 6"/"待用户决定继续修订或进入 Phase 7"）→ 仅提醒，不阻断
# 5. 待审查/全部章节完成，但无有效 final-review.md → 阻断
# 6. 审查不通过但无 revision-log.md → 阻断

set -euo pipefail

PROJECT_DIR="${WORKFLOW_PROJECT_DIR:-.}"
PROJECTS_DIR="$PROJECT_DIR/projects"

# 如果没有 projects 目录，放行
if [ ! -d "$PROJECTS_DIR" ]; then
  exit 0
fi

BLOCKERS=0

for proj_dir in "$PROJECTS_DIR"/*/; do
  if [ ! -d "$proj_dir" ]; then
    continue
  fi

  proj_name=$(basename "$proj_dir")

  SCRIPTS_DIR="$proj_dir/scripts"
  REVIEW_FILE="$proj_dir/reviews/final-review.md"
  LOCKED_FILE="$proj_dir/locked/FINAL-SCRIPT.md"

  # === 情况 1（最高优先级）：已锁稿 → 必须先通过锁稿校验 ===
  if [ -f "$LOCKED_FILE" ]; then
    if [ ! -f "$REVIEW_FILE" ]; then
      >&2 echo "[stop-gate] [阻断] 项目 '$proj_name'：locked/FINAL-SCRIPT.md 存在但缺少 reviews/final-review.md，状态异常。锁稿前必须完成审查，请补充审查记录。"
      BLOCKERS=$((BLOCKERS + 1))
      continue
    fi

    # 检查 final-review.md 是否为占位/不完整
    if grep -qiE "占位|不完整|待全部章节完成后重新审查|待全部章节完成后" "$REVIEW_FILE" 2>/dev/null; then
      >&2 echo "[stop-gate] [阻断] 项目 '$proj_name'：已锁稿但 final-review.md 为占位或不完整审查，不得视为有效最终审查。请运行 script-review 生成正式审查报告后重新锁稿。"
      BLOCKERS=$((BLOCKERS + 1))
      continue
    fi
  fi

  # === 检查 scripts/ 是否有内容 ===
  if [ ! -d "$SCRIPTS_DIR" ] || [ "$(ls -A "$SCRIPTS_DIR" 2>/dev/null || true)" = "" ]; then
    continue
  fi

  STATUS_FILE="$SCRIPTS_DIR/SCRIPT-STATUS.md"

  # 读取 SCRIPT-STATUS.md 中的当前状态
  if [ -f "$STATUS_FILE" ]; then
    CURRENT_STATUS=$(grep -oP '当前状态：\*{0,2}[^*]+\*{0,2}' "$STATUS_FILE" 2>/dev/null | head -1 | sed 's/当前状态：//;s/\*//g' | xargs || true)
  else
    CURRENT_STATUS=""
  fi

  # === 情况 2：正文已完成，待用户确认进入 Phase 5 → 只提醒，不阻断 ===
  if echo "$CURRENT_STATUS" | grep -qi "待用户确认进入 Phase 5" 2>/dev/null; then
    echo "[stop-gate] [提醒] 项目 '$proj_name'：正文已完成但用户尚未确认进入 Phase 5（$CURRENT_STATUS），不阻断停止。"
    continue
  fi

  # === 情况 3：正文生成中 → 只提醒，不阻断 ===
  if echo "$CURRENT_STATUS" | grep -qi "正文生成中" 2>/dev/null; then
    echo "[stop-gate] [提醒] 项目 '$proj_name'：正文生成中（$CURRENT_STATUS），章节未全部完成，不阻断停止。"
    continue
  fi

  # === 情况 4：Phase 6 等待用户决策 → 只提醒，不阻断 ===
  if echo "$CURRENT_STATUS" | grep -qiE "待用户确认进入 Phase 6|待用户决定继续修订或进入 Phase 7" 2>/dev/null; then
    echo "[stop-gate] [提醒] 项目 '$proj_name'：Phase 6 等待用户决策（$CURRENT_STATUS），不阻断停止。"
    continue
  fi

  # === 情况 5：无 SCRIPT-STATUS.md → 无法判断，不阻断 ===
  if [ ! -f "$STATUS_FILE" ]; then
    if [ ! -f "$REVIEW_FILE" ]; then
      echo "[stop-gate] [提醒] 项目 '$proj_name'：scripts/ 有内容但缺少 SCRIPT-STATUS.md 和 final-review.md，无法确定状态，暂不阻断。"
    fi
    continue
  fi

  # === 情况 6：状态为"待正式审查"或"全部章节已完成"或"待审查"，但无有效 final-review.md → 阻断 ===
  if echo "$CURRENT_STATUS" | grep -qiE "待正式审查|全部章节已完成|待审查" 2>/dev/null; then
    if [ ! -f "$REVIEW_FILE" ]; then
      >&2 echo "[stop-gate] [阻断] 项目 '$proj_name'：状态为 '$CURRENT_STATUS' 但缺少 final-review.md，必须先完成审查才能停止。请运行 script-review。"
      BLOCKERS=$((BLOCKERS + 1))
      continue
    fi

    # 检查 final-review.md 是否为占位/不完整
    if grep -qiE "占位|不完整|待全部章节完成后重新审查|待全部章节完成后" "$REVIEW_FILE" 2>/dev/null; then
      >&2 echo "[stop-gate] [阻断] 项目 '$proj_name'：final-review.md 为占位或不完整审查，不得视为有效最终审查。请运行 script-review 生成正式审查报告。"
      BLOCKERS=$((BLOCKERS + 1))
      continue
    fi

    # 有效 final-review.md 存在，检查是否最新
    newest_script=$(find "$SCRIPTS_DIR" -name "*.md" -not -name "SCRIPT-STATUS.md" -type f -printf '%T@\n' 2>/dev/null | sort -rn | head -1 || true)
    review_time=$(stat -c '%Y' "$REVIEW_FILE" 2>/dev/null || true)
    if [ -n "$newest_script" ] && [ -n "$review_time" ]; then
      if [ "${newest_script%.*}" -gt "${review_time%.*}" ] 2>/dev/null; then
        >&2 echo "[stop-gate] [阻断] 项目 '$proj_name'：scripts/ 自上次审查后有更新，必须先完成审查才能停止。请运行 script-review。"
        BLOCKERS=$((BLOCKERS + 1))
      fi
    fi
  fi

  # === 情况 7：审查不通过但没有修订记录 → 阻断 ===
  if [ -f "$REVIEW_FILE" ]; then
    if grep -q "不通过" "$REVIEW_FILE" 2>/dev/null; then
      if [ ! -f "$proj_dir/revisions/revision-log.md" ]; then
        >&2 echo "[stop-gate] [阻断] 项目 '$proj_name'：审查不通过但缺少 revision-log.md，必须先完成修订才能停止。请运行 revision-fixer。"
        BLOCKERS=$((BLOCKERS + 1))
      fi
    fi
  fi
done

# 汇总输出
if [ $BLOCKERS -gt 0 ]; then
  >&2 echo "[stop-gate] 共 $BLOCKERS 个阻断项，停止被阻止。请先处理上述问题。"
  exit 2
fi

# 没有问题，放行
exit 0
