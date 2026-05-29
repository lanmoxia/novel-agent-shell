# 状态字段口径统一修复报告

- 修复时间：2026-05-12
- 修复类型：状态字段术语统一
- 修复状态：**已完成**

---

## 一、统一规则

| 状态值 | 含义 | 适用范围 |
|--------|------|----------|
| `待用户确认` | 新生成的阶段产物，未经用户确认 | STORY-SPEC.md、OUTLINE.md |
| `已确认` | 用户明确说"确认/通过/可以进入下一阶段/没问题/按这个继续" | 上述所有产物 |
| ~~`草稿`~~ | **不再使用** | — |

---

## 二、修改清单

| # | 文件 | 修改内容 |
|---|------|----------|
| 1 | `.claude/skills/story-spec-builder/SKILL.md` | 模板：`状态：草稿 / 已确认` → `状态：待用户确认 / 已确认` |
| 2 | `.claude/skills/outline-builder/SKILL.md` | 模板：`状态：草稿 / 已确认` → `状态：待用户确认 / 已确认` |
| 3 | `.claude/skills/outline-builder/SKILL.md` | 注意事项新增：默认状态规则 |

### outline-builder 新增规则

```markdown
- **新生成的 OUTLINE.md 默认状态必须为待用户确认。用户明确确认后，才允许改为已确认。用户确认前不得进入 script-writer。**
```

---

## 三、全局搜索验证

搜索关键词：
- `状态：草稿 / 已确认` — 0 个残留
- `草稿 / 已确认` — 0 个残留
- `默认为可接受` — 0 个残留（仅历史报告中的"0 个残留"记录）

---

## 四、约束校验

| # | 约束项 | 状态 |
|---|--------|------|
| 1 | 未进入 Phase 3 | ✓ |
| 2 | 未生成大纲 | ✓ |
| 3 | 未生成正文 | ✓ |
| 4 | 未修改 genre-skills/ | ✓ |
| 5 | STORY-SPEC.md 状态保持"待用户确认" | ✓ |

---

## 五、状态口径全景

修复后，所有阶段产物的状态字段统一为：

```
Phase 0  PROJECT.md           → 无状态字段（项目档案，非阶段产物）
Phase 1  GENRE-SKILL-LOCK.md  → 已锁定 / 未锁定（特殊状态体系）
Phase 2  STORY-SPEC.md        → 待用户确认 / 已确认
Phase 3  OUTLINE.md           → 待用户确认 / 已确认
Phase 4  scripts/             → 由 SCRIPT-STATUS.md 跟踪
Phase 5  reviews/             → 由 final-review.md 汇总
Phase 6  revision-log.md      → 记录修订历史
Phase 7  FINAL-SCRIPT.md      → 锁稿标记
```
