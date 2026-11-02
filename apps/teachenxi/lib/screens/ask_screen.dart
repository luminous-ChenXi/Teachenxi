import 'package:contracts/contracts.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

import '../mock/mock_llm.dart';

/// 提问屏：按 contracts 契约流式呈现 mock 回答（M0-8 拍题/对话原型）。
class AskScreen extends StatefulWidget {
  const AskScreen({super.key});

  @override
  State<AskScreen> createState() => _AskScreenState();
}

class _Msg {
  _Msg({required this.fromUser, required this.text, this.streaming = false});

  final bool fromUser;
  String text;
  bool streaming;
  String? emotion;
}

const _emotionLabels = <String, String>{
  EmotionId.happy: '开心',
  EmotionId.sad: '低落',
  EmotionId.neutral: '平静',
  EmotionId.love: '喜欢',
  EmotionId.surprise: '惊讶',
  EmotionId.angry: '生气',
  EmotionId.think: '思考',
  EmotionId.awkward: '尴尬',
  EmotionId.curious: '好奇',
  EmotionId.shy: '害羞',
  EmotionId.excited: '兴奋',
  EmotionId.confused: '困惑',
};

class _AskScreenState extends State<AskScreen> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final _llm = MockLlm();
  final _messages = <_Msg>[];
  bool _busy = false;

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    if (text.isEmpty || _busy) {
      return;
    }
    _controller.clear();
    setState(() {
      _messages
        ..add(_Msg(fromUser: true, text: text))
        ..add(_Msg(fromUser: false, text: '', streaming: true));
      _busy = true;
    });
    _scrollToBottom();
    try {
      final stream = _llm.chatStream(ChatRequest(messages: [
        {'role': 'user', 'content': text},
      ]));
      await for (final ev in stream) {
        if (!mounted) {
          return;
        }
        final m = _messages.last;
        switch (ev.type) {
          case StreamEventType.content:
            setState(() => m.text += ev.delta ?? '');
            _scrollToBottom();
          case StreamEventType.emotion:
            setState(() => m.emotion = ev.emotion);
          case StreamEventType.error:
            setState(() {
              m.streaming = false;
              m.text += '\n（出错了，请稍后再试）';
            });
            return;
          case StreamEventType.reasoning:
          case StreamEventType.toolCallDelta:
          case StreamEventType.finishReason:
          case StreamEventType.usage:
          case StreamEventType.done:
            break;
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _messages.last.streaming = false;
          _busy = false;
        });
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) {
        return;
      }
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: TkMotion.transition,
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              TkSpace.l, TkSpace.l, TkSpace.l, TkSpace.s,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('提问', style: theme.textTheme.titleLarge),
                const SizedBox(height: TkSpace.xs),
                Text(
                  '本地演示模型 · 不产生网络请求',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Text(
                      '有问题就问：题目、知识点、复习安排都可以。',
                      style: theme.textTheme.bodySmall,
                    ),
                  )
                : ListView.builder(
                    controller: _scroll,
                    padding: const EdgeInsets.symmetric(horizontal: TkSpace.l),
                    itemCount: _messages.length,
                    itemBuilder: (context, i) => _bubble(_messages[i]),
                  ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              TkSpace.l, TkSpace.s, TkSpace.l, TkSpace.l,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    enabled: !_busy,
                    decoration: InputDecoration(
                      hintText: '输入问题',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: TkSpace.m,
                        vertical: TkSpace.m,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(TkRadius.input),
                      ),
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                const SizedBox(width: TkSpace.s),
                TextButton(
                  onPressed: _busy ? null : _send,
                  child: const Text('发送'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubble(_Msg m) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Align(
      alignment: m.fromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: TkSpace.xs),
        padding: const EdgeInsets.all(TkSpace.m),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        decoration: BoxDecoration(
          color: m.fromUser
              ? scheme.primary.withValues(alpha: TkAlpha.tint)
              : scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(TkRadius.card),
          border: Border.all(color: scheme.outline),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!m.fromUser && m.emotion != null)
              Padding(
                padding: const EdgeInsets.only(bottom: TkSpace.xs),
                child: Text(
                  '陪伴情绪：${_emotionLabels[m.emotion] ?? m.emotion}',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            Text(
              m.streaming ? '${m.text}▌' : m.text,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
