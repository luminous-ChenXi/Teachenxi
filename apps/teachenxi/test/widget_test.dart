import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:teachenxi/main.dart';

void main() {
  testWidgets('M0 demo：底部导航四屏可达', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TeachenxiApp()));
    await tester.pump();

    expect(find.text('概览'), findsOneWidget);

    Future<void> goto(String label) async {
      await tester.tap(
        find.descendant(
          of: find.byType(NavigationBar),
          matching: find.text(label),
        ),
      );
      await tester.pumpAndSettle();
    }

    await goto('复习');
    expect(find.text('错题本'), findsOneWidget);

    await goto('提问');
    expect(find.textContaining('本地演示模型'), findsOneWidget);

    await goto('设置');
    expect(find.text('设置与关于'), findsOneWidget);
  });
}
