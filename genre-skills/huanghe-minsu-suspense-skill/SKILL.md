---
name: huanghe-minsu-suspense-skill
version: 1.0.0
description: 用于小说、剧本、短剧剧本文字创作的黄河故道中式民俗恐怖题材 Skill。适用于故事企划、大纲、正文、对白、人物、旧物、禁忌、旧事、恐怖递进和题材审查。核心方向是黄河故道、旧村禁忌、清淤旧事、河工传闻、旧物污染、诅咒传播、村庄共谋、伪纪录压迫感和现实质感下的不可解释恐怖。禁止写成玄幻斗法、捉鬼驱魔、怪物猎杀、血浆恐怖、搞笑乡村怪谈、现代刑侦推理或固定旧物模板复用。
capabilities:
  supports_novel: true
  supports_script: true
  supports_short_drama: true
  provides_style: true
  provides_structure: true
  provides_character_rules: true
  provides_dialogue_rules: true
  provides_review_rubric: true
  provides_taboo: true
  provides_examples: true
---

# 黄河民俗恐怖题材 Skill

## 定位

本 Skill 是放置在 `genre-skills/` 目录下的可插拔题材 Skill，用于给小说 / 剧本 / 短剧文字 Agent 提供题材规则、风格约束、结构方法、人物规则、对白规则、旧物规则、民俗禁忌和审查标准。

本 Skill 不是 `workflow/skills/` 下的流程 Skill，不负责项目建档、文件写入、命令执行或流程调度。本 Skill 仅服务文字创作，不处理后置视觉生产。

## 核心题材公式

黄河民俗恐怖 = 旧地貌记忆 + 村庄禁忌 + 被污染的旧物 + 老人不敢明说的旧事 + 诅咒式后果 + 现实质感下的不可解释感。

重点不是“鬼出来吓人”，而是：

- 有些事村里人都知道，但没人敢说全。
- 有些旧物不该被挖出来。
- 有些规矩看似荒唐，但所有老人都默认。
- 有些后果不是马上爆发，而是慢慢渗进日常。
- 主角以为自己在旁观，后来发现自己已经被卷入。
- 真相被揭开后，不是解决问题，而是证明事情已经停不住。

## 适用任务

适用于：故事企划、大纲、分集剧情、正文片段、剧本文字、对白片段、人物设定、旧事设定、禁忌规则设定、旧物链条设计、题材一致性审查、文本修订建议。

## 不适用任务

不用于：玄幻修仙、法术斗法、道士驱魔爽文、河神显灵式神话冒险、纯刑侦推理、怪物追杀、血浆猎奇、搞笑乡村怪谈。

## 旧物去固定化原则

本 Skill 不把任何单一旧物或固定组合设为默认核心。红布、铜器、碗、水、头发、旧包裹等只能作为可选旧物素材；除非用户明确指定，不得默认复用某组固定旧物。每个新项目必须根据主题、旧事、人物关系和场景来源重新选择核心旧物。

## 阶段读取建议

### 故事企划阶段

优先读取：`genre-profile.md`、`style-guide.md`、`structure-rules.md`、`folklore-rules.md`、`props-rules.md`、`templates/story-spec-template.md`、`examples/story-spec-example.md`。

目标：基于当前项目设定生成具体 STORY-SPEC.md，明确核心创意、旧事来源、禁忌规则、核心旧物、恐怖递进和结局方向；不得复用固定旧物组合。

### 大纲阶段

优先读取：`structure-rules.md`、`suspense-rules.md`、`character-rules.md`、`setting-rules.md`、`templates/outline-template.md`、`examples/outline-example.md`。

目标：保证结构递进为“日常旧村 → 异常旧物 → 村民避讳 → 旧事露头 → 禁忌被破 → 后果渗出 → 不可逆收束”。

### 正文 / 剧本阶段

优先读取：`style-guide.md`、`dialogue-rules.md`、`setting-rules.md`、`props-rules.md`、`references/writing-style-reference.md`、`references/dialogue-reference.md`、`references/atmosphere-reference.md`、`templates/script-template.md`、`examples/script-style-example.md`。

目标：写出可拍摄、接地气、克制、压抑、具有中式民俗恐怖压迫感的文字。

### 审查阶段

优先读取：`taboo.md`、`review-rubric.md`、`genre-profile.md`、`suspense-rules.md`、`props-rules.md`。

目标：判断文本是否误写成普通乡村怪谈、玄幻斗法、现代悬疑腔、廉价跳吓、固定旧物复用或道具断裂。

## 写作硬约束

必须做到：旧物有来源、传递、状态变化和后果；禁忌具体可执行；老人知道旧事但不一次说全；村民沉默有共谋感；河工旧事与清淤、旧堤、河泥、故道相关；恐怖递进要慢；对白短、硬、土、避讳、有停顿；真相揭开后仍保留不可解释感和不可逆代价。

禁止做到：玄幻斗法、驱魔解法、鬼脸堆叠、血浆猎奇、现代刑侦推理主导、固定旧物组合复用、老人一次讲完整设定、旧物凭空出现或消失、主角开挂解决一切。
