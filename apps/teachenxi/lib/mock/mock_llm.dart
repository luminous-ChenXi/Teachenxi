import 'package:contracts/contracts.dart';
import 'package:ui_kit/ui_kit.dart';

/// 演示用 LlmPort 假实现：按 contracts 契约逐段吐字，不发起网络请求。
/// 真实三方言适配器由 provider_kit 在 M0-3 落地后替换。
class MockLlm implements LlmPort {
  @override
  ProviderCapabilities get capabilities =>
      const ProviderCapabilities(streaming: true, reasoning: false);

  @override
  Stream<StreamEvent> chatStream(ChatRequest request) async* {
    final prompt = _lastUserPrompt(request);
    final reply = _draftReply(prompt);
    for (final chunk in _chunk(reply)) {
      await Future<void>.delayed(TkMotion.mockStreamTick);
      yield StreamEvent(StreamEventType.content, delta: chunk);
    }
    yield const StreamEvent(StreamEventType.emotion, emotion: EmotionId.happy);
    yield const StreamEvent(StreamEventType.finishReason, reason: 'stop');
    yield const StreamEvent(StreamEventType.done);
  }

  @override
  Future<List<double>> embed(String text) async => List<double>.filled(8, 0);

  String _lastUserPrompt(ChatRequest request) {
    for (final m in request.messages.reversed) {
      if (m['role'] == 'user') {
        return '${m['content'] ?? ''}';
      }
    }
    return '';
  }

  String _draftReply(String prompt) {
    if (prompt.contains('特征值') || prompt.contains('相似')) {
      return '相似对角化的判定分三步：\n'
          '一、求特征多项式，解出全部特征值；\n'
          '二、对每个 k 重特征值，检查线性无关特征向量个数是否等于 k；\n'
          '三、全部相等时可对角化，把 n 个线性无关的特征向量按列拼成 P。\n'
          '建议先重做昨天那道真题变式，再对照第五章例 3 检查步骤。';
    }
    if (prompt.contains('计划') || prompt.contains('安排')) {
      return '按当前进度，今天建议这样安排：\n'
          '上午整块时间给数学二的错题重做；\n'
          '下午做英语二一篇真题精读，整理长难句；\n'
          '晚上用 40 分钟过 408 的 LRU 与页面置换；\n'
          '政治放在碎片时间听强化课。';
    }
    if (prompt.trim().isEmpty) {
      return '请输入你的问题，例如：特征值与相似对角化的判定步骤。';
    }
    return '这是本地演示回答（未接真实模型）。你的问题是：「$prompt」。'
        '正式版本将经 provider_kit 三方言适配器接入模型服务，'
        '并按 contracts 契约流式返回。';
  }

  Iterable<String> _chunk(String text) sync* {
    for (var i = 0; i < text.length; i += 6) {
      final end = (i + 6 < text.length) ? i + 6 : text.length;
      yield text.substring(i, end);
    }
  }
}
