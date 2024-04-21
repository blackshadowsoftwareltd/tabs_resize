import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:window_manager/window_manager.dart';

import '../helpers/constants.dart';
import '../helpers/shared_pref.dart';

part 'window.p.g.dart';

@riverpod
class TotalTabs extends _$TotalTabs {
  @override
  int build() => totalTabs;
}

@riverpod
class WinSize extends _$WinSize {
  @override
  Future<Size> build() async {
    return await windowManager.getSize();
  }

  // double exceptSeparator(int totalTabs) {
  //   final t = ref.read(totalTabsProvider);
  //   final s = state.value?.width ?? 0.0;
  //   return s - (t * separatorWidth);
  // }
}

@riverpod
class TabSize extends _$TabSize {
  double? position;
  @override
  Future<Size> build(int i) async {
    final s = ref.watch(winSizeProvider).value ?? const Size(0, 0);
    final t = ref.watch(totalTabsProvider);

    // final old = await getTabWidth(i.toString());
    // if (old != null) {
    //   return Size(old, s?.height ?? 0.0);
    // }
    final exceptSep = s.width - (separatorWidth * (t - 1));

    final size = Size(exceptSep / t, s.height);
    print('Tabs Ref Initialized $i : $size');

    position = (size.width * i) + (separatorWidth * i);
    return size;
  }

  void reSize(Size s) {
    ref.invalidateSelf();
  }

  void current(double v) {
    state = AsyncValue.data(Size(v, state.value!.height));
  }

  // void forwordUpdate(double v) {
  //   if (v < minimumTabWidth || v - windowOptions.size!.width < minimumTabWidth) return;
  //   log(v.toString());
  //   state = AsyncValue.data(Size(v, state.value!.height));
  // }

  void next(double v) {
    final p = (state.value?.width ?? 0) - v;
    position = position! + p;
    log('Current state ${state.value?.width ?? 0} - v $v = $position');
    state = AsyncValue.data(Size(v, state.value!.height));
  }
}

@riverpod
class SeparatorPosition extends _$SeparatorPosition {
  double? previous;
  @override
  double? build(int i) => null;

  Future<void> start(double v) async {
    previous ?? v;
    state = v - 3;
  }

  Future<void> update(double? vz) async {
    final nextSize = ref.read(tabSizeProvider(i + 1)).value?.width ?? 0;
    final nextPosition = ref.read(tabSizeProvider(i + 1).notifier).position!;

    final v = vz ?? 0;

    double minP = separatorWidth * i;
    for (int l = 0; l < i; l++) {
      minP += ref.read(tabSizeProvider(l)).value?.width ?? 0.0;
    }
    if (v < minP + minimumTabWidth) return;
    if (v > nextPosition + nextSize - minimumTabWidth) return;
    state = v - 3;
  }

  Future<void> end() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final nextSize = ref.read(tabSizeProvider(i + 1)).value?.width ?? 0;
    final nextPosition = ref.read(tabSizeProvider(i + 1).notifier).position!;
    final v = state ?? 0.0;

    double minP = separatorWidth * i;
    for (int l = 0; l < i; l++) {
      minP += ref.read(tabSizeProvider(l)).value?.width ?? 0.0;
    }
    final current = v - minP;
    final next = nextPosition + nextSize - v - 6;

    ref.read(tabSizeProvider(i).notifier).current(current);
    ref.read(tabSizeProvider(i + 1).notifier).next(next);
    await saveTabWidth(i.toString(), current);
    await saveTabWidth((i + 1).toString(), next);
    state = null;
  }
}
