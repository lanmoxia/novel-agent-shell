---
name: genre-loader
description: 扫描 genre-skills/ 目录，列出可用题材 Skill，读取用户选择的题材 Skill，检查接口文件完整性和能力声明，兼容旧格式 Skill，生成 GENRE-SKILL-LOCK.md。禁止在未锁定题材 Skill 的情况下进入正式写作。
---

# genre-loader

## 职责

加载题材 Skill 插件并生成锁定记录。

## 工作流程

1. 扫描 `genre-skills/` 目录，找到所有包含 SKILL.md 的子目录
2. 列出可用题材 Skill 列表，展示给用户
3. 用户选择题材 Skill
4. 读取该 Skill 的 SKILL.md frontmatter
5. 检查 capabilities 能力声明；如缺失，则根据实际文件推断能力
6. 读取该 Skill 的所有可用文件
7. 检查文件完整性，对照合约标准目录
8. 列出缺失文件和缺失能力
9. 如果缺失关键文件（SKILL.md 不存在），直接报错
10. 如果缺失推荐文件或能力，记录缺失项并询问用户是否继续
11. 兼容旧格式 Skill（SKILL.md + outline-method.md + output-style.md）
12. 如需兜底，记录为“待全局写作 Skill 兜底”；当前不从仓库根目录读取全局知识库
13. 生成 `projects/<project-name>/GENRE-SKILL-LOCK.md`
14. 生成或提示生成 `locked/SKILL-LOCK-MANIFEST.sha256`
15. 锁定题材 Skill

## 旧格式兼容

如果题材 Skill 采用旧格式：
- `SKILL.md` → 题材总说明
- `outline-method.md` → 映射为 structure-rules + character-rules
- `output-style.md` → 映射为 style-guide + dialogue-rules
- `examples/` 缺失 → 记录缺失，不阻断
- `templates/` 缺失 → 记录缺失，不阻断
- `capabilities` 缺失 → 根据文件存在情况推断能力，记录为能力声明缺失

## 输出

```
projects/<project-name>/GENRE-SKILL-LOCK.md
```

## GENRE-SKILL-LOCK.md 模板

```markdown
# 题材 Skill 锁定记录

- 项目名：
- 题材 Skill：
- Skill 路径：
- 加载时间：
- 已读取文件：
- 能力声明：
- 缺失能力：
- 缺失文件：
- 降级策略：
- 当前状态：已锁定 / 未锁定
```

## 题材切换规则

- 同一项目不允许中途切换题材 Skill
- 如需切换，必须新建项目或用户确认重新锁定

## 无题材 Skill 时的行为

- 提示用户放入题材 Skill 到 genre-skills/
- 询问是否使用通用占位模式（仅基础逻辑审查，无题材约束）
- 通用占位模式下，题材审查 Agent 降级为基础逻辑审查

## 注意事项

- 不要假设用户想要哪个题材
- 不要跳过完整性检查
- 不要因为 capabilities 缺失而编造题材能力，只能根据已有文件推断
- 使用兜底时必须写入降级策略；当前全局兜底应由未来的全局写作 Skill 包承载
- 题材 Skill 锁定后应生成 Skill 指纹清单，用于后续漂移检测
- 缺失文件不是致命错误，但要明确告知用户
- 锁定后状态必须在 GENRE-SKILL-LOCK.md 中明确标记
