#!/usr/bin/env bash
# stage-gate.sh - 阶段门禁检查（仅提醒，非强阻断）
#
# 重要：此脚本是【提醒型】门禁，不是强阻断门禁。
# 它只输出中文提示，始终 exit 0，不会阻止当前流程运行。
# 强阻断门禁逻辑在 stop-gate.sh 中（Stop hook, exit 2）。
#
# 触发时机：审查/写作子流程完成后
# 用途：提醒维护者检查阶段推进是否合法
# 行为：不满足前置条件时输出提醒信息，始终 exit 0

set -euo pipefail

# 获取项目目录（默认从当前项目根推断）
PROJECT_DIR="${WORKFLOW_PROJECT_DIR:-.}"
PROJECTS_DIR="$PROJECT_DIR/projects"

# 如果没有 projects 目录，不提醒
if [ ! -d "$PROJECTS_DIR" ]; then
  exit 0
fi

# 遍历所有项目，检查阶段完整性
# 此脚本作为阶段检查入口，提醒维护者检查阶段门禁
# 不直接阻断，而是给出中文提示
# 始终 exit 0（提醒型门禁）

WARNINGS=0

for proj_dir in "$PROJECTS_DIR"/*/; do
  if [ ! -d "$proj_dir" ]; then
    continue
  fi

  proj_name=$(basename "$proj_dir")

  # 检查：有 scripts/ 有修改但没有 reviews/final-review.md
  if [ -d "$proj_dir/scripts" ] && [ "$(ls -A "$proj_dir/scripts" 2>/dev/null || true)" != "" ]; then
    if [ ! -f "$proj_dir/reviews/final-review.md" ]; then
      echo "[stage-gate] 项目 '$proj_name': scripts/ 有内容但缺少 reviews/final-review.md，请提醒用户进行审查。"
      WARNINGS=$((WARNINGS + 1))
    fi
  fi

  # 检查：有 reviews/final-review.md 但没有 revision-log（有严重问题时）
  # 此项需要人工判断，hook 只做提示
  if [ -f "$proj_dir/reviews/final-review.md" ]; then
    if grep -q "不通过" "$proj_dir/reviews/final-review.md" 2>/dev/null; then
      if [ ! -f "$proj_dir/revisions/revision-log.md" ]; then
        echo "[stage-gate] 项目 '$proj_name': final-review.md 提示不通过但缺少 revision-log.md，请提醒用户进行修订。"
        WARNINGS=$((WARNINGS + 1))
      fi
    fi
  fi
done

if [ $WARNINGS -gt 0 ]; then
  echo "[stage-gate] [提醒] 共发现 $WARNINGS 个阶段门禁提醒，请检查。注意：此为提醒型门禁，不会阻断流程。"
fi

# 始终 exit 0 —— 此脚本是提醒型门禁，不阻断任何操作
exit 0
