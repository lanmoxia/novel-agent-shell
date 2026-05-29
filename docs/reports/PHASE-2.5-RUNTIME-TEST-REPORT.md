# Phase 2.5：运行级最小闭环测试报告

- 测试时间：2026-05-12
- 测试类型：运行级最小闭环
- 测试项目：test-xianshi-demo
- 测试状态：**通过**

---

## 一、测试步骤与结果

### 步骤 1：创建测试项目

| 操作 | 结果 |
|------|------|
| 创建项目目录 `projects/test-xianshi-demo/` | ✓ 成功 |
| 生成 `PROJECT.md` | ✓ 成功 |
| 创建 6 个子目录（specs/ outlines/ scripts/ reviews/ revisions/ locked/） | ✓ 成功 |

### 步骤 2：题材 Skill 选择

| 操作 | 结果 |
|------|------|
| 扫描 `genre-skills/` | ✓ 识别到 xianshi-skill、gudai-skill 两个可用 Skill |
| 选择题材 | ✓ xianshi-skill |
| 跳过非 Skill 目录 | ✓ _contract-example/ 被跳过（无 SKILL.md） |

### 步骤 3：加载题材 Skill

| 操作 | 结果 |
|------|------|
| 读取 SKILL.md | ✓ 已读取，含 name + description |
| 识别文件格式 | ✓ 旧格式（简化结构） |
| 执行兼容映射 | ✓ outline-method.md → structure + character，output-style.md → style + dialogue |
| 记录缺失文件 | ✓ 7 个推荐文件缺失已标注 |
| 设定降级策略 | ✓ taboo 降级、review-rubric 降级 |

### 步骤 4：生成题材锁定文件

| 操作 | 结果 |
|------|------|
| 生成 `GENRE-SKILL-LOCK.md` | ✓ 成功 |
| 锁定状态 | ✓ 已锁定 |
| 加载模式标注 | ✓ 旧格式兼容模式 |
| 映射关系表 | ✓ 完整 |
| 缺失文件清单 | ✓ 7 个全列 |
| 降级策略说明 | ✓ 完整 |

---

## 二、约束校验

| # | 约束项 | 是否满足 |
|---|--------|----------|
| 1 | 未修改 `genre-skills/xianshi-skill/` 原文 | ✓ 是 |
| 2 | 未修改 `genre-skills/gudai-skill/` 原文 | ✓ 是 |
| 3 | 未生成小说正文 | ✓ 是 |
| 4 | 未生成大纲 | ✓ 是 |
| 5 | 未生成分镜 | ✓ 是 |
| 6 | 未生成 Seedance 提示词 | ✓ 是 |
| 7 | 未误读 `_contract-example/`（该目录无 SKILL.md，自动跳过） | ✓ 是 |
| 8 | 未进入正式创作 | ✓ 是 |

---

## 三、生成物清单

```
projects/test-xianshi-demo/
├── PROJECT.md                    # 项目档案
├── GENRE-SKILL-LOCK.md           # 题材锁定记录（已锁定）
├── specs/                        # 故事企划目录（空，待 Phase 2）
├── outlines/                     # 大纲目录（空，待 Phase 3）
├── scripts/                      # 正文目录（空，待 Phase 4）
├── reviews/                      # 审查报告目录（空，待 Phase 5）
├── revisions/                    # 修订记录目录（空，待 Phase 6）
└── locked/                       # 锁稿目录（空，待 Phase 7）
```

---

## 四、GENRE-SKILL-LOCK.md 内容摘要

| 字段 | 值 |
|------|-----|
| 项目名 | test-xianshi-demo |
| 题材 Skill | xianshi-skill |
| 加载模式 | 旧格式兼容模式 |
| 已读取文件 | 3 核心文件 + 4 模板 + 3 示例 |
| 缺失推荐文件 | genre-profile, style-guide, structure-rules, character-rules, dialogue-rules, taboo, review-rubric（共 7 个） |
| 降级策略 | taboo → 不执行题材专属禁忌审查（通用审查照样执行）；review-rubric → 降级审查 |
| 锁定状态 | 已锁定 |

---

## 五、可进入 Phase 2 判定

| 前置条件 | 状态 |
|----------|------|
| PROJECT.md 存在 | ✓ |
| GENRE-SKILL-LOCK.md 存在且已锁定 | ✓ |
| 题材 Skill 可正确加载 | ✓ |
| 旧格式兼容映射完整 | ✓ |
| 降级策略已记录 | ✓ |

**结论：当前可以进入 Phase 2（故事企划测试）。**

---

## 六、遗留注意项

1. 七个缺失推荐文件在当前旧格式 Skill 下不是阻断项，但进入 Phase 5（审查）时题材审查将使用降级模式。
2. 如果后续需要完整审查能力，建议为 xianshi-skill 补充 taboo.md 和 review-rubric.md。
3. 当前测试项目为临时测试用途，项目状态标注为"测试项目"，可随时清理。
