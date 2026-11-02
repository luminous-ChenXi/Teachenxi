import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 外观设置（M0 原型为内存态；持久化由 data_layer 在 M1 接管）。
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

/// 动效总开关（UX §5：动效可关）。
final motionEnabledProvider = StateProvider<bool>((ref) => true);
