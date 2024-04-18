import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:window/window_manager.dart';
import 'package:window_manager/window_manager.dart';

import '../constants.dart';

part 'window.p.g.dart';

@riverpod
class TotalTabs extends _$TotalTabs {
  @override
  int build() => 3;
}

@riverpod
class WinSize extends _$WinSize {
  @override
  Future<Size> build() async => await windowManager.getSize();
}

@riverpod
class TabSize extends _$TabSize {
  @override
  Future<Size> build(int i) async {
    final s = ref.watch(winSizeProvider).value;
    final sw = s?.width ?? 0.0;
    final t = ref.watch(totalTabsProvider);
    final tw = t - 1;
     final size = Size(((sw - (tw * separatorWidth)) / t).abs(), 0);
    log('${(sw - (tw * separatorWidth)) / t} init - ${size.toString()}');
    return size;
  }

  void reSize(Size s) {
    ref.invalidateSelf(); 
  }

  void current(double v) { 
    state = AsyncValue.data(Size(v, state.value!.height));
  }

  void forwordUpdate(double v) {
    if (v < minimumTabWidth || v - windowOptions.size!.width < minimumTabWidth) return;
    log(v.toString());
    state = AsyncValue.data(Size(v, state.value!.height));
  }

  void others(double v) {
    state = AsyncValue.data(Size(v, state.value!.height));
  }
}

@riverpod
class SeparatorPosition extends _$SeparatorPosition {
  @override
  double? build(int i) => null;

  Future<void> startEnd(double? v) async {
    if (v == null) {
      await Future.delayed(const Duration(milliseconds: 100));
      final totalTabs = ref.read(totalTabsProvider);
      final winSize = ref.read(winSizeProvider);
      for (int x = 0; x < totalTabs; x++) {
        if (x == i) {
          ref.read(tabSizeProvider(i).notifier).current(state!);
          final separat = (totalTabs - 1) * separatorWidth;
          final ws = winSize.value?.width ?? 0.0;
          final others = ws - state! - separat;
          log('$v others $separat - $ws - $state ($others) : ${(others / (totalTabs - 1))}');
          ref.read(tabSizeProvider(1).notifier).others((others / (totalTabs - 1)));
        }
      }
      state = null;
    } else {
      state = v;
    }
  }

  Future<void> update(double? v) async {
    if (v! < minimumTabWidth || windowOptions.size!.width - v < minimumTabWidth) return;
    state = v;
  }
}
