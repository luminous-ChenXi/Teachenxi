import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 学习域演示样例（M0 UI 原型均为本地静态数据，不接真实数据层）。

class SubjectProgress {
  const SubjectProgress(this.name, this.detail, this.progress);

  final String name;
  final String detail;
  final double progress;
}

class TodoItem {
  const TodoItem(this.title, this.subject, {this.done = false});

  final String title;
  final String subject;
  final bool done;
}

class WrongQuestion {
  const WrongQuestion(this.subject, this.stem, this.mastery, this.reviewHint);

  final String subject;
  final String stem;
  final double mastery;
  final String reviewHint;
}

const _subjects = <SubjectProgress>[
  SubjectProgress('数学二', '高等数学 · 线性代数', 0.42),
  SubjectProgress('英语二', '真题精读 · 核心词汇', 0.31),
  SubjectProgress('408 统考', '数据结构 · 组成原理', 0.25),
  SubjectProgress('政治', '马原 · 毛中特', 0.12),
];

final subjectsProvider = Provider<List<SubjectProgress>>((ref) => _subjects);

final todosProvider = StateProvider<List<TodoItem>>((ref) => const [
      TodoItem('线性代数：特征值与相似对角化复盘', '数学二'),
      TodoItem('英语二 2018 Text2 精读', '英语二'),
      TodoItem('数据结构：AVL 树旋转练习', '408 统考', done: true),
    ]);

const _wrongBook = <WrongQuestion>[
  WrongQuestion('数学二', '设 A 可相似对角化，求可逆矩阵 P 与对角阵（真题变式）', 0.6,
      '建议明天重做'),
  WrongQuestion('408 统考', 'LRU 页面置换算法的缺页次数计算', 0.4, '建议 3 天后重做'),
  WrongQuestion('英语二', '长难句拆分：倒装结构与同位语从句', 0.75, '建议本周复习'),
  WrongQuestion('政治', '矛盾的同一性与斗争性辨析', 0.2, '建议明天背诵'),
];

final wrongBookProvider = Provider<List<WrongQuestion>>((ref) => _wrongBook);
