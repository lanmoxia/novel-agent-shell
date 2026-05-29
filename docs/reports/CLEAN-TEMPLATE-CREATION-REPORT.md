# 空白项目模板创建报告

- 创建时间：2026-05-12
- 模板路径：`projects/_template/`
- 目的：提供干净项目骨架，用于创建正式项目时复制

---

## 创建的目录

```
projects/_template/
├── PROJECT.md
├── GENRE-SKILL-LOCK.md
├── specs/
│   └── STORY-SPEC.md
├── outlines/
│   └── OUTLINE.md
├── scripts/
│   └── SCRIPT-STATUS.md
├── reviews/
│   └── README.md
├── revisions/
│   └── README.md
├── locked/
│   └── README.md
├── shotlists/
│   └── README.md
├── short-drama-shotlists/
│   └── README.md
└── seedance-prompts/
    └── README.md
```

共 11 个文件，11 个目录。

---

## 是否包含测试项目正文

**否。** _template 内所有文件均为占位模板，不包含：
- test-xianshi-demo 的 E01–E05 正文
- FINAL-SCRIPT.md 正文
- 审查报告内容
- 修订日志内容
- 人物设定或情节信息
- 分镜内容
- Seedance 提示词

---

## 是否触碰 test-xianshi-demo

**否。** test-xianshi-demo 下所有文件未修改。

---

## 同时更新的文件

| 文件 | 修改内容 |
|------|----------|
| `projects/README.md` | 新增 `_template/` 说明，更新目录结构图，新增创建新项目流程 |
| `docs/TEMPLATE-PACKAGING-GUIDE.md` | 将 `_template/` 加入打包清单，更新 test-xianshi-demo 说明和分发建议 |

---

## 后续基于 _template 新建正式项目

1. 复制空白模板：
   ```bash
   cp -r projects/_template projects/<新项目名>
   ```
2. 在 Claude Code 中说"新建项目"，触发 `project-intake-builder`
3. 按 Phase 0 → Phase 8 流程推进
4. 每个阶段等待用户确认后再进入下一阶段
5. 参考 `docs/NEXT-PRODUCTION-STEPS.md` 了解完整流程

**不要复制 test-xianshi-demo 作为新项目起点。**
