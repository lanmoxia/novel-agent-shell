# 项目输出目录

每个创作项目在本目录下有独立的子目录。

## 目录内容

| 目录 | 说明 |
|------|------|
| `_template/` | **空白项目模板**，新建正式项目时的复制起点 |
| `test-xianshi-demo/` | **示例项目**，展示 Phase 0 → Phase 8 完整流程输出 |

## 项目结构

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
│   ├── E01-标题.md
│   └── ...
├── reviews/
│   ├── structure-review.md
│   ├── continuity-review.md
│   ├── dialogue-review.md
│   ├── genre-review.md
│   └── final-review.md
├── revisions/
│   └── revision-log.md
├── locked/
│   ├── FINAL-SCRIPT.md
│   └── LOCK-MANIFEST.sha256
├── shotlists/
├── short-drama-shotlists/
└── seedance-prompts/
```

## 创建新项目

1. 运行 `bash scripts/new-project.sh <project-name>` 创建项目
2. 使用 `project-intake-builder` 规则填写 PROJECT.md
3. 按 Phase 0 → Phase 8 流程推进

**不要复制 `test-xianshi-demo/`。** test-xianshi-demo 包含特定测试项目的正文、人物和情节，不是空白起点。
