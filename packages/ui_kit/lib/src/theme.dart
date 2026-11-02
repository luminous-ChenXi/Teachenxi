/// 由令牌组装明暗两套主题；全仓组件只消费 Theme，不允许自行配色。
library;

import 'package:flutter/material.dart';

import 'tokens.dart';

abstract final class TkTheme {
  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final ink = isLight ? TkColors.inkLight : TkColors.inkDark;
    final inkSoft = isLight ? TkColors.inkSoftLight : TkColors.inkSoftDark;
    final paper = isLight ? TkColors.paperLight : TkColors.paperDark;
    final accent = isLight ? TkColors.accentLight : TkColors.accentDark;
    final danger = isLight ? TkColors.dangerLight : TkColors.dangerDark;

    final scheme = ColorScheme(
      brightness: brightness,
      primary: accent,
      onPrimary: isLight ? Colors.white : TkColors.inkLight,
      secondary: inkSoft,
      onSecondary: paper,
      error: danger,
      onError: isLight ? Colors.white : TkColors.inkLight,
      surface: paper,
      onSurface: ink,
      surfaceContainerHighest:
          ink.withValues(alpha: TkAlpha.veil),
      onSurfaceVariant: inkSoft,
      outline: ink.withValues(alpha: TkAlpha.hairline),
      outlineVariant: ink.withValues(alpha: TkAlpha.hairline * 0.6),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: paper,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: ink,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: TkFont.title,
          fontWeight: FontWeight.w600,
          color: ink,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: paper.withValues(alpha: TkAlpha.panel),
        surfaceTintColor: Colors.transparent,
        indicatorColor: accent.withValues(alpha: TkAlpha.tint),
        elevation: 0,
        height: 64,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(fontSize: TkFont.caption, color: ink),
        ),
        iconTheme: WidgetStatePropertyAll(IconThemeData(color: ink)),
      ),
      dividerTheme: DividerThemeData(
        color: ink.withValues(alpha: TkAlpha.hairline),
        thickness: 1,
        space: 1,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: TkFont.title,
          fontWeight: FontWeight.w600,
          color: ink,
        ),
        titleMedium: TextStyle(
          fontSize: TkFont.body + 2,
          fontWeight: FontWeight.w600,
          color: ink,
        ),
        bodyMedium: TextStyle(fontSize: TkFont.body, color: ink),
        bodySmall: TextStyle(fontSize: TkFont.caption, color: inkSoft),
        labelLarge: TextStyle(
          fontSize: TkFont.body,
          fontWeight: FontWeight.w500,
          color: ink,
        ),
      ),
    );
  }
}
