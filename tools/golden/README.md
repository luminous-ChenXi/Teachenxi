# tools/golden/ 黄金测试向量

DeepTutor Python 参考实现（`reference/DeepTutor/deeptutor/learning/`）批量生成的调度器/掌握度
测试用例（JSON），Dart 实现（packages/learning_engine）必须全部通过——移植正确性的可证明依据。

- 生成脚本：M0-9 任务产出（`tools/gen_golden.py`）
- 用例文件：`scheduler_cases.json` / `mastery_cases.json`
- 用例结构：`{id, type, history:[{result, score}], expect:{interval, stage, mastery}}`
- CI：`melos run test` 内 learning_engine 的 golden 测试组必须全绿
