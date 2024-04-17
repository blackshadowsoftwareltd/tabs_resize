import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../constants.dart';

part 'window.p.g.dart';

@riverpod
class TabSize extends _$TabSize {
  @override
  Size build(int i) => const Size(defaultTabWidth, 0);

  void update(double v) {
    if (v < minimumTabWidth) return;
    state = Size.fromWidth(v);
  }
}

@riverpod
class SeparatorPosition extends _$SeparatorPosition {
  @override
  double? build(int i) => null;

  void startEnd(double? v) {
    log(v.toString());
    if (v == null) {
      ref.read(tabSizeProvider(i).notifier).update(state!);
      state = null;
    } else {
      state = v - 3;
    }
  }

  void update(double? v) {
    log(v.toString());
    if (v! < minimumTabWidth) return;

    state = v;
  }
}
