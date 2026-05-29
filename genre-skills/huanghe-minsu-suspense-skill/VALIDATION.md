# huanghe-minsu-suspense-skill 验收记录

- Skill 名称：huanghe-minsu-suspense-skill
- Skill 类型：genre-skills 新格式题材 Skill
- 题材方向：黄河故道 / 中式民俗恐怖 / 旧村禁忌 / 清淤旧事 / 旧物污染 / 禁忌传播 / 责任链
- 验收版本：v2
- 验收日期：2026-05-14
- 验收项目：projects/huanghe-skill-smoke-test-v2/
- 测试作品：《河底回声》
- 验收范围：Phase 0 → Phase 7 主流程
- 验收结论：通过
- 是否可用于正式小说/剧本项目：是
- 是否包含 Phase 8 后置模块测试：否
- 是否建议继续用于分镜/视觉提示词：否，本 Skill 仅完成文字创作主流程验收

---

## 已通过阶段

| 阶段 | 名称 | 结果 |
|------|------|------|
| Phase 0 | 项目初始化 | 通过 |
| Phase 1 | 题材 Skill 加载 | 通过 |
| Phase 2 | 故事企划 | 通过 |
| Phase 3 | 大纲 | 通过 |
| Phase 4 | 五章正文 | 通过 |
| Phase 5 | 多维审查 | 通过 |
| Phase 6 | 轻微修订 | 通过 |
| Phase 7 | 锁稿 | 通过 |

---

## 关键验收点

- 新格式标准合约模式识别通过
- 未发生旧格式降级
- references / templates / examples 可被 Agent 使用
- 能生成 STORY-SPEC.md
- 能生成 OUTLINE.md
- 能生成 E01-E05 正文
- 能执行多维审查
- 能执行轻微修订
- 能锁稿生成 FINAL-SCRIPT.md
- 道具去同质化规则有效
- 未默认复用"小铜碗 / 红布 + 小铜碗 + 浑黄水 + 发丝"
- 未误写"老田另半截碑"
- 未跑偏到玄幻斗法、鬼怪现身、刑侦推理或血浆恐怖

---

## 标准测试样例

- 测试项目：projects/huanghe-skill-smoke-test-v2/
- 最终锁稿：projects/huanghe-skill-smoke-test-v2/locked/FINAL-SCRIPT.md
- 完整总结：docs/reports/HUANGHE-SKILL-V2-FULL-SMOKE-TEST-SUMMARY.md

---

## 使用建议

1. 可作为正式黄河民俗恐怖小说/剧本项目的题材 Skill。
2. 新项目应继续保留"核心旧物候选与选择理由"机制。
3. 不应默认复用测试样例《河底回声》的旧堤界碑碎片设定。
4. 正式项目仍需按 Phase 0 → Phase 7 门禁运行。
5. Phase 8 后置模块未纳入本次验收，后续应单独开发和测试。
