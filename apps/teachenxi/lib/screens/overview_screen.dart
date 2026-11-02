import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/ui_kit.dart';

import '../state/study.dart';

/// 首屏：学习概览（问候、今日待办、科目进度）。
class OverviewScreen extends ConsumerWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjects = ref.watch(subjectsProvider);
    final todos = ref.watch(todosProvider);
    final now = DateTime.now();
    final greet = _greeting(now.hour);
    final weekday =
        const ['一', '二', '三', '四', '五', '六', '日'][now.weekday - 1];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(TkSpace.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(greet, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: TkSpace.s),
            Text(
              '${now.year}年${now.month}月${now.day}日 · 周$weekday',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TkSectionHeader(
              '今日待办',
              trailing: '${todos.where((t) => !t.done).length} 项未完成',
            ),
            TkCard(
              padding: const EdgeInsets.symmetric(vertical: TkSpace.xs),
              child: Column(
                children: [
                  for (var i = 0; i < todos.length; i++)
                    InkWell(
                      onTap: () => _toggle(ref, todos, i),
                      borderRadius: BorderRadius.circular(TkRadius.card),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: TkSpace.m,
                          vertical: TkSpace.xs,
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: todos[i].done,
                              onChanged: (_) => _toggle(ref, todos, i),
                            ),
                            const SizedBox(width: TkSpace.xs),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    todos[i].title,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Text(
                                    todos[i].subject,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            TkSectionHeader('科目进度', trailing: '演示数据'),
            for (final s in subjects)
              Padding(
                padding: const EdgeInsets.only(bottom: TkSpace.s),
                child: TkCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              s.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Text(
                            '${(s.progress * 100).round()}%',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: TkSpace.xs),
                      Text(
                        s.detail,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: TkSpace.s),
                      LinearProgressIndicator(
                        value: s.progress,
                        minHeight: 6,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: TkSpace.xl),
            Center(
              child: Text(
                'M0 UI 原型 · 本页数据为本地演示样例',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggle(WidgetRef ref, List<TodoItem> todos, int i) {
    ref.read(todosProvider.notifier).state = [
      for (var j = 0; j < todos.length; j++)
        if (j == i)
          TodoItem(
            todos[j].title,
            todos[j].subject,
            done: !todos[j].done,
          )
        else
          todos[j],
    ];
  }

  String _greeting(int hour) {
    if (hour < 6) {
      return '夜深了，注意休息';
    }
    if (hour < 11) {
      return '早上好';
    }
    if (hour < 14) {
      return '中午好';
    }
    if (hour < 18) {
      return '下午好';
    }
    return '晚上好';
  }
}
