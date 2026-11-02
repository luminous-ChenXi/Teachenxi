import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/ui_kit.dart';

import '../state/settings.dart';

/// 设置与关于。
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final mode = ref.watch(themeModeProvider);
    final motion = ref.watch(motionEnabledProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(TkSpace.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('设置与关于', style: theme.textTheme.titleLarge),
            TkSectionHeader('外观'),
            TkCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('主题模式', style: theme.textTheme.bodyMedium),
                  const SizedBox(height: TkSpace.s),
                  SizedBox(
                    width: double.infinity,
                    child: SegmentedButton<ThemeMode>(
                      showSelectedIcon: false,
                      segments: const [
                        ButtonSegment(
                          value: ThemeMode.system,
                          label: Text('跟随系统'),
                        ),
                        ButtonSegment(
                          value: ThemeMode.light,
                          label: Text('浅色'),
                        ),
                        ButtonSegment(
                          value: ThemeMode.dark,
                          label: Text('深色'),
                        ),
                      ],
                      selected: {mode},
                      onSelectionChanged: (s) =>
                          ref.read(themeModeProvider.notifier).state = s.first,
                    ),
                  ),
                ],
              ),
            ),
            TkSectionHeader('动效'),
            TkCard(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('界面动效', style: theme.textTheme.bodyMedium),
                        const SizedBox(height: TkSpace.xs),
                        Text(
                          '关闭后转场与流式提示即时呈现（UX：动效可关）',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: motion,
                    onChanged: (v) =>
                        ref.read(motionEnabledProvider.notifier).state = v,
                  ),
                ],
              ),
            ),
            TkSectionHeader('关于'),
            TkCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Teachenxi 0.1.0-demo', style: theme.textTheme.titleMedium),
                  const SizedBox(height: TkSpace.xs),
                  Text(
                    'AI 个人学习智能体 · M0 UI 原型。'
                    '本版含四屏演示：概览、提问、复习、设置；'
                    '完整信息架构（知识库、统计、平板双栏）自 M1 起补齐。',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(height: TkSpace.s),
                  Text('数据口径：本地优先，学习数据仅存设备内。',
                      style: theme.textTheme.bodySmall),
                  const SizedBox(height: TkSpace.xs),
                  Text('开源协议：GPL-3.0', style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            const SizedBox(height: TkSpace.xl),
          ],
        ),
      ),
    );
  }
}
