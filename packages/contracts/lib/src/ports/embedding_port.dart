/// 端侧嵌入端口（ADR-006/FR-F02-02）：本地 ONNX 模型（BGE-small-zh）实现，
/// 零云依赖、数据不出设备——教材 RAG 的默认嵌入路径。
/// 云端路径（生态模式可选）见 LlmPort.embed；两路径嵌入维度不同，
/// 切换需按 embeddingSignature 重嵌入（DM §3.3）。
library contracts;

/// 嵌入签名：模型名+维度+量化版本；随 documents.embedding_signature 记录，
/// 变更触发重嵌入任务（索引版本化，借鉴 DeepTutor 签名机制）。
class EmbeddingSignature {
  const EmbeddingSignature({required this.model, required this.dimensions, required this.quantization});
  final String model;
  final int dimensions;
  final String quantization;

  @override
  String toString() => '$model/${dimensions}d/$quantization';
}

abstract interface class EmbeddingPort {
  EmbeddingSignature get signature;
  Future<List<double>> embed(String text);
  Future<List<List<double>>> embedBatch(List<String> texts);
}
