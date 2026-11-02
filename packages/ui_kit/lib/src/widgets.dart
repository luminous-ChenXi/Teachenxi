/// 基础组件：半透明面板、文字标签、状态点。图标一律不在此层引入。
library;

import 'package:flutter/material.dart';

import 'tokens.dart';

/// 半透明面板卡：黑白透色质感的基础容器（圆角 12、发丝描边、微染底色）。
class TkCard extends StatelessWidget {
  const TkCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final body = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(TkRadius.card),
        border: Border.all(color: scheme.outline),
      ),
      padding: padding ?? const EdgeInsets.all(TkSpace.m),
      child: child,
    );
    if (onTap == null) {
      return body;
    }
    return InkWell(
      borderRadius: BorderRadius.circular(TkRadius.card),
      onTap: onTap,
      child: body,
    );
  }
}

/// 文字标签（无图标、无 emoji 的轻量徽章）。
class TkTag extends StatelessWidget {
  const TkTag(this.text, {super.key, this.emphasized = false});

  final String text;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: TkSpace.s,
        vertical: TkSpace.xs,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TkRadius.tag),
        border: Border.all(
          color: emphasized
              ? scheme.primary.withValues(alpha: TkAlpha.hairline * 2)
              : scheme.outline,
        ),
        color: emphasized
            ? scheme.primary.withValues(alpha: TkAlpha.tint)
            : Colors.transparent,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: emphasized ? scheme.primary : null,
            ),
      ),
    );
  }
}

/// 状态点（完成/进行中/滞后），替代一切装饰性图标。
class TkDot extends StatelessWidget {
  const TkDot({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

/// 区块标题 + 可选尾部说明。
class TkSectionHeader extends StatelessWidget {
  const TkSectionHeader(this.title, {super.key, this.trailing});

  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: TkSpace.xs,
        top: TkSpace.xl,
        bottom: TkSpace.s,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: theme.textTheme.titleMedium),
          ),
          if (trailing != null)
            Text(trailing!, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
