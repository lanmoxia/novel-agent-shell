# script-writer 旧格式题材 Skill 兼容修复报告

- 修复时间：2026-05-12
- 修复类型：兼容性增强
- 修复范围：`.claude/skills/script-writer/SKILL.md`
- 修复状态：**已完成**

---

## 一、修复前问题

script-writer 的工作流程硬编码了"新格式"文件路径（style-guide.md、dialogue-rules.md、taboo.md），无法处理当前 genre-skills/ 下两个旧格式 Skill（xianshi-skill、gudai-skill），因为这两个 Skill 目录中不存在这些文件。

---

## 二、修复内容

### 2.1 工作流程重构

**修复前**：无条件要求读取 style-guide.md、dialogue-rules.md、taboo.md。

**修复后**：增加两步判断逻辑：
1. 读取 GENRE-SKILL-LOCK.md 获取加载模式
2. 根据模式分支：
   - 新格式模式 → 读标准合约文件
   - 旧格式兼容模式 → 读 SKILL.md + outline-method.md + output-style.md

### 2.2 新增题材规则映射表

| 旧格式文件 | 提供规则 |
|-----------|----------|
| SKILL.md | 题材总说明、创作流程、触发条件 |
| outline-method.md | 结构规则、人物规则、节奏规则、冲突设计、伏笔管理 |
| output-style.md | 文风规则、语言风格、对白规则、句式要求 |

### 2.3 新增注意事项（2 条）

1. **不得因为缺少 style-guide.md、dialogue-rules.md、taboo.md 就自行编造题材规则。旧格式 Skill 必须以 GENRE-SKILL-LOCK.md 中的映射为准。**
2. **正文生成只能写当前指定章节，不允许一次性写完整作品。**

---

## 三、约束校验

| # | 约束项 | 状态 |
|---|--------|------|
| 1 | 未修改 genre-skills/ 原文 | ✓ |
| 2 | 未生成正文 | ✓ |
| 3 | 未进入 Phase 4 | ✓ |
| 4 | 未修改 OUTLINE.md | ✓ |

---

## 四、验证路径

script-writer 在旧格式 Skill 下的正确执行路径：

```
1. 读取 OUTLINE.md
2. 读取 GENRE-SKILL-LOCK.md → 识别"加载模式：旧格式兼容模式"
3. 读取 genre-skills/xianshi-skill/SKILL.md
4. 读取 genre-skills/xianshi-skill/outline-method.md
5. 读取 genre-skills/xianshi-skill/output-style.md
6. 读取上一章正文（如续写）
7. 按题材规则生成当前章节
8. 写入 scripts/E##-标题.md
9. 更新 SCRIPT-STATUS.md
```
