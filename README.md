# Teachenxi

> **辰汐生态的学习端入口：以 AI 智能体为内核的开源学习 App**
> 拍题分步讲解 ｜ 教材 RAG 问答 ｜ 艾宾浩斯复习闭环 ｜ Provider 中立（BYOK） ｜ 平板横屏深度适配 ｜ 极简陪伴形象
> 一套 Flutter 代码，三端渐进发布：Android → HarmonyOS（v1.5）→ iOS（v2）

> 🪺 **辰汐生态（Chenxi Ecosystem）** 成员项目 —— 与 [LuomiNest](https://github.com/LuminousCX/LuomiNest)（桌面 AI 陪伴）、[LuomiBlog](https://github.com/luminous-ChenXi/LuomiBlog)（AI 知识库博客）、[AstrNest](https://github.com/luminous-ChenXi/AstrNest)（图床/媒体管理）同属辰汐生态。本项目的角色：以 AI 智能体为内核的学习陪伴 App。

| 项 | 内容 |
|---|---|
| 状态 | **M0 预研阶段**（骨架已初始化，功能开发未开始） |
| 客户端 | Flutter 主工程 + 原生插件（三端一套代码） |
| 架构 | 模块化单体 + 六边形分层（Ports & Adapters） |
| 模型 | 用户自配 Provider（OpenAI 兼容 / Anthropic / Responses API）；默认 DeepSeek |
| 许可 | GPL-3.0 + 禁止商用声明（公开发布时随 v1.0 代码附 LICENSE） |
| 文档 | 见 [docs/00-文档总览与编写约定.md](docs/00-文档总览与编写约定.md) |

## 仓库结构

```
teachenxi/
├── apps/teachenxi/       # 组装根：UI features + Riverpod 注入
├── packages/
│   ├── contracts/        # ★ 契约包（架构师所有）：消息模型/StreamEvent/端口/DTO
│   ├── core_agent/       # Agent Loop、工具注册表、RAG 编排
│   ├── learning_engine/  # 艾宾浩斯调度器、记忆、统计激励
│   ├── provider_kit/     # 三方言适配器、供应商模板表
│   ├── data_layer/       # drift 仓储、向量检索、文件解析
│   └── ui_kit/           # 设计系统、双栏布局、KaTeX 封装
├── plugins/              # 自研平台插件（pub 包不满足时）
├── tools/                # 契约守护、黄金向量生成、CI 脚本
└── docs/                 # 计划书 / 架构与工作流程 / SRS / SAS / DM / API
```

## 快速开始（开发 A/B）

```bash
dart pub global activate melos 6.3.2
melos bootstrap     # 拉起全部包依赖
melos run analyze   # 静态分析
melos run test      # 测试（域层黄金向量必须全绿）
```

> Flutter SDK 版本在 M0 末统一锁定后写入 CI（`ci.yml`）与本 README。

## 文档基线

> 计划书与 SRS/SAS/DM/API 于 **2026-09-16 冻结 v1.0**、09-18 审查修订、**2026-10-28 宽松化修订 v1.1**（里程碑去日历化/评审轻量化/模型口径官网同步，deepseek-flash 原生视觉确认）；《02》为 v0.3 工程手册；变更唯一登记=**CHG-变更历史记录.md**（登记即实施，不设评审会）。**docs/ 目录为内部受控文档，不包含在公开发布物中**。

| 文档 | 标准基线 |
|---|---|
| [01-项目计划书](docs/01-项目计划书.md) | IEEE 1490 风格立项；ADR 决策记录 §12 |
| [02-软件架构与工作流程](docs/02-软件架构与工作流程.md) | 工程工作手册（部署/协作/M0 任务） |
| [SRS-需求规格说明书](docs/SRS-需求规格说明书.md) | ISO/IEC/IEEE 29148:2018 |
| [SAS-软件架构说明书](docs/SAS-软件架构说明书.md) | ISO/IEC/IEEE 42010:2022 |
| [DM-数据模型设计说明书](docs/DM-数据模型设计说明书.md) | UML 2.5.1 / ISO/IEC 9075 约定 |
| [UX-用户体验设计说明书](docs/UX-用户体验设计说明书.md) | WCAG 2.2 AA / Material 3 |
| [CFG-配置基线与供应商清单](docs/CFG-配置基线与供应商清单.md) | ISO/IEC/IEEE 16326:2019 |
| [CHG-变更历史记录](docs/CHG-变更历史记录.md) | ISO/IEC/IEEE 15289:2019（变更唯一登记） |
| [API-接口规格说明书](docs/API-接口规格说明书.md) | OpenAPI 3.1 / RFC 9110 |
