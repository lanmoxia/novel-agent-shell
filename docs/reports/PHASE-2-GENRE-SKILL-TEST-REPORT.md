# Phase 2：题材 Skill 导入测试报告

- 测试时间：2026-05-12
- 测试范围：`genre-skills/` 目录全部内容
- 合约依据：`docs/GENRE-SKILL-CONTRACT.md`
- 测试状态：已完成

---

## 一、扫描结果

扫描 `genre-skills/` 目录，识别到以下内容：

| 目录/文件 | 类型 | 说明 |
|-----------|------|------|
| `xianshi-skill/` | 题材 Skill | 现实题材短篇小说 |
| `gudai-skill/` | 题材 Skill | 古代权谋短篇小说 |
| `_contract-example/` | 参考文档 | 合约示例（非 Skill） |
| `README.md` | 索引文档 | 目录说明（非 Skill） |

**可用题材 Skill 数量：2 个**（xianshi-skill、gudai-skill）

---

## 二、逐 Skill 文件清单

### 2.1 xianshi-skill（现实题材）

```
genre-skills/xianshi-skill/
├── SKILL.md                         # 必需 ✓
├── outline-method.md                # 旧格式：结构+人物规则
├── output-style.md                  # 旧格式：风格+对白规则
├── templates/                       # 可选
│   ├── outline-template.md
│   ├── character-template.md
│   ├── chapter-index-template.md
│   └── chapter-template.md
└── examples/                        # 可选
    ├── outline-example.md
    ├── character-example.md
    └── chapter-example.md
```

### 2.2 gudai-skill（古代权谋）

```
genre-skills/gudai-skill/
├── SKILL.md                         # 必需 ✓
├── outline-method.md                # 旧格式：结构+人物规则
├── output-style.md                  # 旧格式：风格+对白规则
├── templates/                       # 可选
│   ├── outline-template.md
│   ├── character-template.md
│   ├── chapter-index-template.md
│   └── chapter-template.md
└── examples/                        # 可选
    ├── outline-example.md
    ├── character-example.md
    └── chapter-example.md
```

---

## 三、标准合约符合度检查

### 3.1 对照表

| 合约文件 | 必需性 | xianshi-skill | gudai-skill |
|----------|--------|---------------|-------------|
| SKILL.md | **必需** | ✓ 有 | ✓ 有 |
| genre-profile.md | 推荐 | ✗ 缺失 | ✗ 缺失 |
| style-guide.md | 推荐 | ✗ 缺失 | ✗ 缺失 |
| structure-rules.md | 推荐 | ✗ 缺失 | ✗ 缺失 |
| character-rules.md | 推荐 | ✗ 缺失 | ✗ 缺失 |
| dialogue-rules.md | 推荐 | ✗ 缺失 | ✗ 缺失 |
| taboo.md | 推荐 | ✗ 缺失 | ✗ 缺失 |
| review-rubric.md | 推荐 | ✗ 缺失 | ✗ 缺失 |
| templates/ | 可选 | ✓ 有（4 文件） | ✓ 有（4 文件） |
| examples/ | 可选 | ✓ 有（3 文件） | ✓ 有（3 文件） |

### 3.2 结论

两个 Skill 均采用**旧格式（简化结构）**：
- SKILL.md → 存在，且包含合法 YAML frontmatter（name + description）
- outline-method.md → 存在
- output-style.md → 存在
- 缺少全部 7 个推荐标准文件（genre-profile / style-guide / structure-rules / character-rules / dialogue-rules / taboo / review-rubric）
- templates/ 和 examples/ 均完整提供

---

## 四、旧格式兼容映射

按 `GENRE-SKILL-CONTRACT.md` 第 3 节的兼容规则：

| 合约需求 | xianshi-skill 映射来源 | gudai-skill 映射来源 |
|----------|----------------------|---------------------|
| 题材总说明 | SKILL.md（直接读取） | SKILL.md（直接读取） |
| 风格规则（style-guide） | output-style.md | output-style.md |
| 对白规则（dialogue-rules） | output-style.md（合并） | output-style.md（合并） |
| 结构规则（structure-rules） | outline-method.md | outline-method.md |
| 人物规则（character-rules） | outline-method.md（合并） | outline-method.md（合并） |
| 题材定位（genre-profile） | SKILL.md 降级提取 | SKILL.md 降级提取 |
| 禁忌（taboo） | 缺失 → 不执行题材专属禁忌审查，但仍执行通用安全、逻辑、连续性审查 | 缺失 → 不执行题材专属禁忌审查，但仍执行通用安全、逻辑、连续性审查 |
| 审查标准（review-rubric） | 缺失 → 降级审查 | 缺失 → 降级审查 |
| 模板（templates） | 已提供 | 已提供 |
| 示例（examples） | 已提供 | 已提供 |

### 降级项汇总

| 降级项 | xianshi-skill | gudai-skill | 影响 |
|--------|---------------|-------------|------|
| taboo.md 缺失 | 是 | 是 | 题材审查时不检查禁忌触发 |
| review-rubric.md 缺失 | 是 | 是 | 题材审查使用降级模式（基于已有文件推断审查标准） |
| genre-profile.md 缺失 | 是 | 是 | 从 SKILL.md 提取题材定位信息 |

---

## 五、genre-loader 可调用性判定

### 5.1 SKILL.md YAML frontmatter 验证

| 字段 | xianshi-skill | gudai-skill |
|------|---------------|-------------|
| name | `xianshi-skill` | `gudai-skill` |
| description | 有（现实题材短篇小说创作） | 有（古代权谋短篇小说创作） |

两个 SKILL.md 均满足合约最低要求（name + description 均存在）。

### 5.2 加载流程模拟

```
1. 扫描 genre-skills/ → 发现 2 个 Skill（xianshi-skill, gudai-skill）
2. 列出可用题材 → 向用户展示 2 个选项
3. 用户选择题材 → 例如选择 xianshi-skill
4. 检查文件完整性 → SKILL.md ✓，记录 7 个缺失推荐文件
5. 告知用户缺失文件 → "xianshi-skill 缺少 taboo.md 等 7 个推荐文件，将使用降级策略"
6. 用户确认继续 → 读取 SKILL.md + outline-method.md + output-style.md + templates + examples
7. 生成 GENRE-SKILL-LOCK.md → 锁定题材
```

### 5.3 判定

| 判定项 | 结果 |
|--------|------|
| 可被 genre-loader 扫描识别 | ✓ 是 |
| 可被 genre-loader 加载 | ✓ 是 |
| 加载模式 | 旧格式兼容加载（降级模式） |
| 是否阻断加载 | 否（满足最低要求：SKILL.md 存在且有 name + description） |

---

## 六、注意事项

1. **两个 Skill 结构完全对称**：文件数量和文件名完全一致，仅题材内容不同。这说明它们的模板来自同一套生成流程。
2. **SKILL.md 内部路径引用旧路径**：SKILL.md 中引用了 `.claude/skills/xianshi-skill/`，实际路径为 `genre-skills/xianshi-skill/`。genre-loader 加载时应使用实际路径，忽略 SKILL.md 中的自引用路径。
3. **genre-profile.md 缺失**：如果需要更精确的题材定位描述，建议后续补充该文件。
4. **taboo.md 缺失**：两个 Skill 均无禁忌约束，在题材审查时 `genre-reviewer` 会标注"未进行禁忌检查"。
5. **review-rubric.md 缺失**：题材审查时 `genre-reviewer` 将使用降级审查（基于 SKILL.md + outline-method.md + output-style.md 推断审查标准）。
6. **_contract-example/** 不是题材 Skill**，genre-loader 应跳过该目录（无 SKILL.md）。

---

## 七、验收结论

- [x] 扫描到 2 个可用题材 Skill：xianshi-skill、gudai-skill
- [x] 每个 Skill 文件清单已列清
- [x] 旧格式兼容映射已明确（outline-method.md → structure + character, output-style.md → style + dialogue）
- [x] 缺失文件已记录（各缺 7 个推荐文件）
- [x] genre-loader 可调用性已确认
- [x] 未修改任何题材 Skill 原文
- [x] 未生成小说正文
- [x] 未生成分镜或 Seedance 提示词
