/// Provider 中立核心端口（provider_kit 三方言适配器实现）。
/// 方言定稿（2026-09-16）：openai_compat / anthropic / responses 三种；
/// 中转网关=base_url 指向中转端点，由 openai_compat 覆盖，不设独立方言；
/// webhook 异步回调为 v2 预留（届时新增枚举值须 ADR）。
library contracts;

import '../messages/stream_event.dart';

enum ProviderDialect { openaiCompat, anthropic, responses }

class ProviderCapabilities {
  const ProviderCapabilities({
    this.toolCalls = false,
    this.vision = false,
    this.reasoning = false,
    this.embedding = false,
    this.streaming = true,
  });
  final bool toolCalls;
  final bool vision;
  final bool reasoning;
  final bool embedding;
  final bool streaming;
}

class ChatRequest {
  const ChatRequest({required this.messages, this.tools, this.model, this.temperature, this.maxTokens});
  final List<Map<String, Object?>> messages;
  final List<Map<String, Object?>>? tools;
  final String? model;
  final double? temperature;
  final int? maxTokens;
}

/// 云端模型端口（网络路径）。
abstract interface class LlmPort {
  ProviderCapabilities get capabilities;
  Stream<StreamEvent> chatStream(ChatRequest request);

  /// 云端嵌入路径（生态模式可选）。端侧默认路径见 [EmbeddingPort]。
  Future<List<double>> embed(String text);
}
