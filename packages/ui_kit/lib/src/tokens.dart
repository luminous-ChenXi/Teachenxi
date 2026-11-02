/// Teachenxi 设计令牌 —— 《UX-用户体验设计说明书》§5 的代码落地基线。
/// 颜色纪律：全仓 UI 颜色只允许来自本文件与 [TkTheme]；
/// 黑白为基底、半透明为质感，靛蓝（种子色）仅作点缀。
library;

import 'package:flutter/material.dart';

/// 基础色板。UI 代码不得直接写 Color(0x...)，一律消费 [TkColors] 与 [TkAlpha]。
abstract final class TkColors {
  /// 种子色：靛蓝（UX §5）。浅色态 Indigo 700，深色态 Indigo 300。
  static const Color accentLight = Color(0xFF3F51B1);
  static const Color accentDark = Color(0xFF7986CB);

  /// 近黑 / 近白文字与图形。
  static const Color inkLight = Color(0xFF17181C);
  static const Color inkDark = Color(0xFFE9EAEC);

  /// 次级文字。
  static const Color inkSoftLight = Color(0xFF5B5F66);
  static const Color inkSoftDark = Color(0xFF9AA0A6);

  /// 纸面基底。
  static const Color paperLight = Color(0xFFFAFAF8);
  static const Color paperDark = Color(0xFF0F1012);

  /// 错误态（Material 规范红，仅用于错误，不作装饰）。
  static const Color dangerLight = Color(0xFFB3261E);
  static const Color dangerDark = Color(0xFFF2B8B5);
}

/// 透明度令牌：“透色”质感统一走这里，避免散落的 magic alpha。
abstract final class TkAlpha {
  /// 描边。
  static const double hairline = 0.12;

  /// 面板底色微染。
  static const double veil = 0.04;

  /// 悬浮面板（底部导航磨砂）。
  static const double panel = 0.72;

  /// 强面板。
  static const double panelStrong = 0.88;

  /// 指示色淡染（导航指示器、强调标签底）。
  static const double tint = 0.12;
}

/// 间距令牌（UX：全部为 4 的倍数）。
abstract final class TkSpace {
  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

/// 圆角令牌（UX：卡片 12dp、输入框 8dp）。
abstract final class TkRadius {
  static const double card = 12;
  static const double input = 8;
  static const double tag = 6;
}

/// 字号令牌（UX：正文 14sp、标题 20sp、代码与公式 13sp）。
abstract final class TkFont {
  static const double body = 14;
  static const double title = 20;
  static const double caption = 12;
  static const double code = 13;
}

/// 动效时长（UX：转场 200ms / 流式淡入 80ms / 表情切换 150ms；支持全局关闭）。
abstract final class TkMotion {
  static const Duration transition = Duration(milliseconds: 200);
  static const Duration fadeIn = Duration(milliseconds: 80);
  static const Duration emotion = Duration(milliseconds: 150);
  static const Duration mockStreamTick = Duration(milliseconds: 80);
}
