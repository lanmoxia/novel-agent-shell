# Phase 编号与确认门禁修复报告

- 修复时间：2026-05-12
- 修复类型：阶段编号统一 + 确认门禁强化
- 修复状态：**已完成**

---

## 一、标准阶段定义

```
Phase 0：项目初始化
Phase 1：题材 Skill 加载
Phase 2：故事企划
Phase 3：大纲 / 节拍
Phase 4：剧本正文
Phase 5：多维审查
Phase 6：修订
Phase 7：锁稿
Phase 8：可选后置模块
```

---

## 二、修改清单

| # | 文件 | 修改内容 |
|---|------|----------|
| 1 | `projects/.../specs/STORY-SPEC.md` | 生成阶段 Phase 3 → Phase 2 |
| 2 | `projects/.../specs/STORY-SPEC.md` | 新增元信息字段 `状态：待用户确认` |
| 3 | `projects/.../specs/STORY-SPEC.md` | 核心创意 `已确认（默认可接受）` → `待用户确认`（标记为 ✗） |
| 4 | `projects/.../specs/STORY-SPEC.md` | 门禁结论：`可以进入 Phase 3` → `暂不允许进入 Phase 3，必须等待用户确认` |
| 5 | `docs/PHASE-2.5-RUNTIME-TEST-REPORT.md` | 目录注释 `待 Phase 3` → `待 Phase 2`（specs 目录） |
| 6 | `docs/PHASE-2.5-RUNTIME-TEST-REPORT.md` | 章节标题 `可进入 Phase 3 判定` → `可进入 Phase 2 判定` |
| 7 | `docs/PHASE-2.5-RUNTIME-TEST-REPORT.md` | 结论 `可以进入 Phase 3` → `可以进入 Phase 2` |
| 8 | `docs/PHASE-3-STORY-SPEC-TEST-REPORT.md` | **文件重命名** → `PHASE-2-STORY-SPEC-TEST-REPORT.md` |
| 9 | `docs/PHASE-2-STORY-SPEC-TEST-REPORT.md` | 标题 `Phase 3` → `Phase 2` |
| 10 | `docs/PHASE-2-STORY-SPEC-TEST-REPORT.md` | 约束校验：判定描述从 `"可以进入"` → `等待用户确认` |
| 11 | `docs/PHASE-2-STORY-SPEC-TEST-REPORT.md` | 结论 `可以进入 Phase 3 下一步` → `暂不进入 Phase 3，等待用户确认` |
| 12 | `docs/PHASE-2-STORY-SPEC-TEST-REPORT.md` | 输出物清单中自身文件名更新 |
| 13 | `.claude/skills/story-spec-builder/SKILL.md` | 新增强制规则：不得因测试项目默认确认 |

---

## 三、关键规则变更

### story-spec-builder 新增规则

在 SKILL.md 注意事项中新增第 4 条：

> **不得因测试项目而默认确认 STORY-SPEC.md。必须等待用户明确确认后，才能把状态改为已确认。**

### STORY-SPEC.md 状态字段

所有 STORY-SPEC.md 必须在顶部元信息中包含 `状态` 字段：
- `待用户确认` — 生成后默认状态，不允许进入 Phase 3
- `已确认` — 用户明确确认后，允许进入 Phase 3

---

## 四、全局搜索验证

搜索关键词：
- `Phase 3 故事企划` — 0 个错误残留
- `故事企划测试` — 3 个匹配，均已正确标注为 Phase 2
- `默认为可接受` — 0 个残留
- `可以进入 Phase 3 的下一步` — 0 个残留

---

## 五、约束校验

| # | 约束项 | 状态 |
|---|--------|------|
| 1 | 未生成大纲 | ✓ |
| 2 | 未生成正文 | ✓ |
| 3 | 未修改 genre-skills/ | ✓ |
| 4 | 未进入 outline-builder | ✓ |
| 5 | STORY-SPEC.md 状态为"待用户确认"（未确认） | ✓ |
