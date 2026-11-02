/// 统一流式事件契约（provider_kit 三方言适配器统一输出，上游不感知方言）。
/// 事件类型全集（八类）见 docs/API-接口规格说明书.md §3.2。
library contracts;

enum StreamEventType { content, reasoning, toolCallDelta, finishReason, usage, done, emotion, error }

class StreamEvent {
  const StreamEvent(
    this.type, {
    this.delta,
    this.index,
    this.reason,
    this.usage,
    this.emotion,
    this.error,
  });

  final StreamEventType type;

  /// content / toolCallDelta 的文本增量。
  final String? delta;

  /// toolCallDelta 专用：并行多工具调用按 index 区分合并（API §3.1）。
  final int? index;

  /// finishReason：stop / length / toolCalls / error。
  final String? reason;

  /// usage：{promptTokens, completionTokens}。
  final Map<String, int>? usage;

  /// emotion：EmotionId 十二值之一（见 [EmotionId]）。
  final String? emotion;

  final Object? error;
}

/// 情绪语义 ID（12 值，协议冻结：API §3.3；驱动 F11 陪伴形象与 F19 Live2D）。
abstract final class EmotionId {
  static const happy = 'happy';
  static const sad = 'sad';
  static const neutral = 'neutral';
  static const love = 'love';
  static const surprise = 'surprise';
  static const angry = 'angry';
  static const think = 'think';
  static const awkward = 'awkward';
  static const curious = 'curious';
  static const shy = 'shy';
  static const excited = 'excited';
  static const confused = 'confused';

  static const all = <String>[
    happy, sad, neutral, love, surprise, angry, think, awkward, curious, shy, excited, confused,
  ];

  static bool isValid(String v) => all.contains(v);
}
