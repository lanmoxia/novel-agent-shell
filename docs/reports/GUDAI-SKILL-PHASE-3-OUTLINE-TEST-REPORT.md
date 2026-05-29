# gudai-skill Phase 3 大纲测试报告

- 测试时间：2026-05-12
- 测试项目：gudai-skill-smoke-test
- 测试阶段：Phase 3（大纲测试）
- 题材 Skill：gudai-skill（已锁定）

---

## 前置门禁检查

| 门禁 | 结果 |
|------|------|
| PROJECT.md 项目名 = gudai-skill-smoke-test | ✓ 通过 |
| GENRE-SKILL-LOCK.md 状态 = "已锁定" | ✓ 通过 |
| STORY-SPEC.md 状态 = "待用户确认"，用户已明确确认 | ✓ 通过（已更新为"已确认"） |
| 题材 Skill = gudai-skill | ✓ 通过 |

---

## 读取文件

| 文件 | 状态 |
|------|------|
| PROJECT.md | ✓ 已读取 |
| GENRE-SKILL-LOCK.md | ✓ 已读取 |
| STORY-SPEC.md | ✓ 已读取（状态已从"待用户确认"更新为"已确认"） |
| genre-skills/gudai-skill/SKILL.md | ✓ 已读取 |
| genre-skills/gudai-skill/outline-method.md | ✓ 已读取 |
| genre-skills/gudai-skill/output-style.md | ✓ 已读取 |

---

## 生成结果

| 检查项 | 结果 |
|--------|------|
| 是否生成 OUTLINE.md | ✓ 是 |
| OUTLINE.md 状态 | **待用户确认**（非"已确认"） |
| 是否包含 5 章完整大纲 | ✓ 是 |
| 每章是否含回目感标题 | ✓ 是（对仗句式） |
| 是否遵循起承转合结构 | ✓ 是 |
| 每章是否含 10 个字段 | ✓ 是（核心事件/出场人物/权力冲突/信息不对称/证物推进/谋局反制/情绪节点/章末钩子/STORY-SPEC对应） |
| 是否含证物递进总表 | ✓ 是（五证物 × 五章矩阵） |
| 权力棋局是否清晰 | ✓ 是（三方势力全程制约） |
| 信息不对称是否明确 | ✓ 是（每章标注各方知/不知） |
| 谋略推进是否不用巧合 | ✓ 是（勘合符两半、真诏位置、目击者均有前置铺垫） |
| 证物体系是否递进 | ✓ 是（五证物 E01→E04 逐步揭示） |
| 礼制逻辑是否成立 | ✓ 是（押印制度/申议程序/除籍流程） |
| 结局是否有代价 | ✓ 是（沈门除籍、勘合符焚毁、离京） |
| 是否避免大团圆 | ✓ 是 |
| 是否避免突然武力解决 | ✓ 是（全章无武斗） |
| 是否含 gudai-skill 核心公式 | ✓ 是 |

---

## 范围控制

| 检查项 | 结果 |
|--------|------|
| 是否误生成正文 | ✗ 否 |
| 是否误生成审查报告 | ✗ 否 |
| 是否误生成分镜 | ✗ 否 |
| 是否误生成 Seedance 提示词 | ✗ 否 |
| 是否修改 genre-skills/ | ✗ 否 |
| 是否修改 test-xianshi-demo | ✗ 否 |
| 是否修改 _template | ✗ 否 |
| OUTLINE.md 是否误设为"已确认" | ✗ 否（正确设为"待用户确认"） |

---

## gudai-skill 规则校验

| 规则 | 来源 | 是否遵守 |
|------|------|----------|
| 核心公式：权力棋局 + 信息不对称 + 谋略与人心博弈 + 有代价的成局 | outline-method.md | ✓ |
| 5 章起承转合结构 | SKILL.md | ✓ |
| 证物翻盘（诏/印/符/信/档） | outline-method.md | ✓ |
| 三步递进设局—拆局—反将 | outline-method.md | ✓（E04） |
| 文白相济（未写正文，在大纲情绪节点中以此风格提示） | output-style.md | ✓ |
| 伏笔以典章细节轻触 | outline-method.md | ✓ |
| 结局见代价 / 成局必失衡 | outline-method.md | ✓ |
| 不用巧合翻盘 | outline-method.md | ✓ |
| 不用武力硬干 | outline-method.md | ✓ |
| 不搞大团圆 | outline-method.md | ✓ |

---

## 当前状态

- 当前阶段：Phase 3 完成
- STORY-SPEC.md 状态：**已确认**
- OUTLINE.md 状态：**待用户确认**
- 下一步：等待用户明确确认 OUTLINE.md 后进入 Phase 4 正文阶段
