import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/ui_kit.dart';

import 'app/home_shell.dart';
import 'state/settings.dart';

/// 应用组装根：UI features + Riverpod 注入（M0-8 UI 原型 demo）。
void main() {
  runApp(const ProviderScope(child: TeachenxiApp()));
}

class TeachenxiApp extends ConsumerWidget {
  const TeachenxiApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    return MaterialApp(
      title: 'Teachenxi',
      theme: TkTheme.light(),
      darkTheme: TkTheme.dark(),
      themeMode: mode,
      home: const HomeShell(),
    );
  }
}
