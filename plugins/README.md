# plugins/ 自研平台插件

pub 包无法满足的平台能力放这里，每个插件一个目录，命名 `teachenxi_<capability>`。

候选清单（按需启动，勿预建）：

| 插件 | 用途 | 触发条件 |
|---|---|---|
| `teachenxi_exact_alarm` | 艾宾浩斯精确提醒（Android 12+ 精确闹钟权限） | F5 实测 flutter_local_notifications 不满足时 |
| `teachenxi_ohos_reminder` | 鸿蒙代理提醒（reminderAgent） | v1.5 鸿蒙专项 |
| `teachenxi_ohos_file` | 鸿蒙文件选择/安全目录适配 | v1.5 鸿蒙专项 |

规范：通道命名 `teachenxi/<capability>`，方法与错误码在 docs/API-接口规格说明书.md §4 登记。
