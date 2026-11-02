# Teachenxi App（M0 UI 原型 demo）

四屏底部导航原型：概览 / 提问 / 复习 / 设置。设计令牌与主题在 `packages/ui_kit`；
对话屏按 `contracts` 的 `LlmPort` 契约接入 `lib/mock/mock_llm.dart` 本地假模型，不产生网络请求。

## 运行

```bash
# 仓库根
dart pub global activate melos 6.3.2 && melos bootstrap   # 或直接逐包 pub get
cd apps/teachenxi
flutter pub get
flutter run                    # 需要连接设备或模拟器
```

## 构建（Android debug 包）

```bash
cd apps/teachenxi
flutter build apk --debug
# 产物：build/app/outputs/flutter-apk/app-debug.apk
```

## 结构

- `lib/app/home_shell.dart` 底部导航壳（IndexedStack + 磨砂导航栏）
- `lib/screens/` 四屏；`lib/state/` Riverpod 演示状态；`lib/mock/` 假 LlmPort
- 颜色纪律：全仓 UI 颜色只允许来自 `ui_kit` 的 `TkColors/TkAlpha`，黑白透色基底，靛蓝种子色仅点缀（UX §5）

## 说明

- UX 全量信息架构为六分区，demo 裁剪为四屏（知识库、统计自 M1 补齐）
- 动效开关为内存态，持久化由 data_layer 在 M1 接管
