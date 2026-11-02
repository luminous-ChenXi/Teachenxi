import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui_kit/ui_kit.dart';

import '../state/study.dart';

/// 复习屏：错题本（筛选 + 掌握度）。
class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  String _filter = '全部';

  static const _filters = <String>['全部', '数学二', '英语二', '408 统考', '政治'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wrongBook = ref.watch(wrongBookProvider);
    final items = wrongBook
        .where((w) => _filter == '全部' || w.subject == _filter)
        .toList();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(TkSpace.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('错题本', style: theme.textTheme.titleLarge),
            const SizedBox(height: TkSpace.xs),
            Text('演示样例 · M1 接入本地数据层', style: theme.textTheme.bodySmall),
            const SizedBox(height: TkSpace.m),
            Wrap(
              spacing: TkSpace.s,
              runSpacing: TkSpace.s,
              children: [
                for (final f in _filters) _chip(context, f),
              ],
            ),
            TkSectionHeader(
              '待复习',
              trailing: '${items.length} 条',
            ),
            for (final w in items)
              Padding(
                padding: const EdgeInsets.only(bottom: TkSpace.s),
                child: TkCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          TkTag(w.subject),
                          const Spacer(),
                          Text(w.reviewHint, style: theme.textTheme.bodySmall),
                        ],
                      ),
                      const SizedBox(height: TkSpace.s),
                      Text(w.stem, style: theme.textTheme.bodyMedium),
                      const SizedBox(height: TkSpace.m),
                      Row(
                        children: [
                          Text('掌握度', style: theme.textTheme.bodySmall),
                          const SizedBox(width: TkSpace.s),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: w.mastery,
                              minHeight: 6,
                            ),
                          ),
                          const SizedBox(width: TkSpace.s),
                          Text(
                            '${(w.mastery * 100).round()}%',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            if (items.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: TkSpace.xxl),
                child: Center(
                  child: Text('该科目暂无待复习错题', style: theme.textTheme.bodySmall),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _chip(BuildContext context, String label) {
    final scheme = Theme.of(context).colorScheme;
    final selected = _filter == label;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      showCheckmark: false,
      backgroundColor: Colors.transparent,
      selectedColor: scheme.primary.withValues(alpha: TkAlpha.tint),
      side: BorderSide(color: scheme.outline),
      labelStyle: Theme.of(context).textTheme.bodySmall,
      onSelected: (_) => setState(() => _filter = label),
    );
  }
}
