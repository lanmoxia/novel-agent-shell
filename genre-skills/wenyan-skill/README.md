# wenyan-skill 目录说明

```txt
genre-skills/
└── wenyan-skill/                              # 文言文教辅真人古风短剧 Skill
    ├── README.md                             # 目录说明，方便人工查看每个文件的作用
    ├── SKILL.md                              # Skill 总入口，说明用途、输入、输出、硬约束
    ├── genre-profile.md                      # 题材定位，定义适用内容和不适用内容
    ├── style-guide.md                        # 风格规则，控制古风真人、教材感、画面气质
    ├── structure-rules.md                    # 结构规则，控制剧本叙事骨架
    ├── character-rules.md                    # 人物规则，控制孔子、儿童、先生、路人等角色
    ├── dialogue-rules.md                     # 台词规则，控制原文、白话、对白、旁白
    ├── taboo.md                              # 禁忌规则，防止跑偏成玄幻、权谋、爱情、网感内容
    ├── review-rubric.md                      # 审查标准，用于生成后自检和返修
    ├── templates/                            # 输出模板目录
    │   ├── T-WY001-qingjing-fuyan.md         # 情境复演型模板，当前默认模板
    │   ├── script-template.md                # 剧本输出模板
    │   ├── shotlist-template.md              # 分镜输出模板
    │   └── subtitle-template.md              # 字幕输出模板
    └── examples/                             # 示例目录
        └── liangxiaor-bianri-example.md      # 《两小儿辩日》对标视频结构示例
```

## 使用建议

把整个 `wenyan-skill` 文件夹放到项目的：

```txt
genre-skills/wenyan-skill/
```

当前版本是 MVP，不建议继续拆分更多文件。先用一篇文言文跑通：

```txt
原文拆解 → 剧本生成 → 原文映射表 → 分镜表 → 字幕方案 → 审查结果
```
