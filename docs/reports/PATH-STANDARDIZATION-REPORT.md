# 项目路径规范统一修复报告

- 修复时间：2026-05-12
- 修复类型：路径标准化
- 修复状态：**已完成**

---

## 一、目标路径规范

```
projects/<project-name>/
├── PROJECT.md
├── GENRE-SKILL-LOCK.md
├── specs/
│   └── STORY-SPEC.md
├── outlines/
│   └── OUTLINE.md
├── scripts/
│   ├── SCRIPT-STATUS.md
│   └── E##-标题.md
├── reviews/
├── revisions/
└── locked/
```

---

## 二、修改清单

| # | 文件 | 修改内容 | 类型 |
|---|------|----------|------|
| 1 | `.claude/CLAUDE.md` | Phase 3 前置条件：`STORY-SPEC.md` → `specs/STORY-SPEC.md` | 路径修正 |
| 2 | `.claude/CLAUDE.md` | Phase 4 前置条件：`OUTLINE.md` → `outlines/OUTLINE.md` | 路径修正 |
| 3 | `.claude/skills/story-spec-builder/SKILL.md` | 输出路径：`projects/<project-name>/STORY-SPEC.md` → `projects/<project-name>/specs/STORY-SPEC.md` | 路径修正 |
| 4 | `.claude/skills/outline-builder/SKILL.md` | 前置条件：`projects/<project-name>/STORY-SPEC.md` → `projects/<project-name>/specs/STORY-SPEC.md` | 路径修正 |
| 5 | `.claude/skills/outline-builder/SKILL.md` | 输出路径：`projects/<project-name>/OUTLINE.md` → `projects/<project-name>/outlines/OUTLINE.md` | 路径修正 |
| 6 | `.claude/skills/script-writer/SKILL.md` | 前置条件：`projects/<project-name>/OUTLINE.md` → `projects/<project-name>/outlines/OUTLINE.md` | 路径修正 |
| 7 | `.claude/skills/script-writer/SKILL.md` | SCRIPT-STATUS 路径：`projects/<project-name>/SCRIPT-STATUS.md` → `projects/<project-name>/scripts/SCRIPT-STATUS.md` | 路径修正 |
| 8 | `projects/README.md` | 目录结构：STORY-SPEC.md / OUTLINE.md 移入 specs/ / outlines/ 子目录 | 结构更新 |
| 9 | `docs/SHELL-SPEC.md` | 门禁表：Gate 2→3 和 Gate 3→4 前置条件路径修正 | 路径修正 |
| 10 | `docs/SHELL-SPEC.md` | 输出目录结构：STORY-SPEC.md / OUTLINE.md / SCRIPT-STATUS.md 归入子目录 | 结构更新 |
| 11 | `docs/SHELL-BUILD-PLAN.md` | Phase 3 输出路径：3 处修正 | 路径修正 |

---

## 三、保留的裸引用（无需修改）

以下引用仅出现在描述性文字中，不作为文件路径使用，无需修改：

| 文件 | 内容 | 原因 |
|------|------|------|
| outline-builder SKILL.md:10 | "基于已确认的 STORY-SPEC.md" | 描述 Skill 职责 |
| outline-builder SKILL.md:19 | "读取 STORY-SPEC.md" | 描述工作流程步骤 |
| outline-builder SKILL.md:27 | "生成 OUTLINE.md" | 描述工作流程步骤 |
| story-spec-builder SKILL.md:29 | "生成 STORY-SPEC.md 初稿" | 描述工作流程步骤 |
| script-writer SKILL.md:10 | "基于已确认的 OUTLINE.md" | 描述 Skill 职责 |
| script-writer SKILL.md:19 | "读取 OUTLINE.md" | 描述工作流程步骤 |
| script-writer SKILL.md:31 | "更新 SCRIPT-STATUS.md" | 描述工作流程步骤 |
| docs/TOKEN-CONTROL.md | 表中提及 OUTLINE.md | 上下文表格中的文件引用说明 |

---

## 四、未修改的文件

| 文件 | 原因 |
|------|------|
| `projects/test-xianshi-demo/specs/STORY-SPEC.md` | 已在正确位置，不需要移动 |
| `genre-skills/` 全部文件 | 用户明确禁止修改 |
| `docs/PHASE-*-TEST-REPORT.md` | 测试报告为历史记录，描述的是生成动作而非路径标准 |

---

## 五、约束校验

| # | 约束项 | 状态 |
|---|--------|------|
| 1 | 未移动 test-xianshi-demo/specs/STORY-SPEC.md | ✓ |
| 2 | 未生成大纲 | ✓ |
| 3 | 未生成正文 | ✓ |
| 4 | 未修改 genre-skills/ 原文 | ✓ |
| 5 | 未进入下一阶段 | ✓ |

---

## 六、验收

- [x] 11 处路径已从裸文件名修正为完整子目录路径
- [x] STORY-SPEC.md 统一归入 `specs/`
- [x] OUTLINE.md 统一归入 `outlines/`
- [x] SCRIPT-STATUS.md 统一归入 `scripts/`
- [x] 描述性裸引用已确认无歧义，保留不修改
- [x] 7 个目标文件的路径描述均已更新
