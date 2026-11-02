import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  test('主题由令牌组装，种子色为靛蓝且明暗两态齐全', () {
    final light = TkTheme.light();
    final dark = TkTheme.dark();

    expect(light.colorScheme.primary, TkColors.accentLight);
    expect(dark.colorScheme.primary, TkColors.accentDark);
    expect(light.brightness, Brightness.light);
    expect(dark.brightness, Brightness.dark);
    expect(light.textTheme.bodyMedium!.fontSize, TkFont.body);
  });

  test('透明度令牌全部落在 (0,1) 区间', () {
    for (final a in [
      TkAlpha.hairline,
      TkAlpha.veil,
      TkAlpha.panel,
      TkAlpha.panelStrong,
      TkAlpha.tint,
    ]) {
      expect(a, greaterThan(0));
      expect(a, lessThan(1));
    }
  });
}
