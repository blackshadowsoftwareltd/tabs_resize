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

  double exceptSeparator(int totalTabs) {
    final t = ref.read(totalTabsProvider);
    final s = state.value?.width ?? 0.0;
    return s - (t * separatorWidth);
  }
}

@riverpod
class TabSize extends _$TabSize {
  double? position;
  @override
  Future<Size> build(int i) async {
    final s = ref.watch(winSizeProvider).value;
    final sw = s?.width ?? 0.0;
    final t = ref.watch(totalTabsProvider);
    final tw = t - 1;
    final size = Size(((sw - (tw * separatorWidth)) / t).abs(), 0);

    position = (size.width * i) + (separatorWidth * i);
    log('${(sw - (tw * separatorWidth)) / t} init - ${size.toString()} Position $position');
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
    final winSize = ref.read(winSizeProvider).value?.width ?? 0.0;
    final totalTabs = ref.read(totalTabsProvider);

    final c = ref.read(tabSizeProvider(i)).value?.width ?? 0.0;
    final v = state ?? 0.0;
    if (i == 0) {
      ref.read(tabSizeProvider(i).notifier).current(v);
      final next = ref.read(tabSizeProvider(i + 1)).value?.width ?? 0.0;
      ref.read(tabSizeProvider(i + 1).notifier).next(next + (c - v));
    } else if (i == totalTabs - 2) {
      final currentPosition = ref.read(tabSizeProvider(i).notifier).position!;
      ref.read(tabSizeProvider(i).notifier).current(v - currentPosition);
      ref.read(tabSizeProvider(i + 1).notifier).next(winSize - v - 6);
    }
    state = null;
    return;
    // final winSize = ref.read(winSizeProvider);
    // final totalTabs = ref.read(totalTabsProvider);
    // for (int x = 0; x < totalTabs; x++) {
    //   if (x == i) {
    //     ref.read(tabSizeProvider(i).notifier).current(state!);
    //     final separat = (totalTabs - 1) * separatorWidth;
    //     final ws = winSize.value?.width ?? 0.0;
    //     final others = ws - state! - separat;
    //     // log('$v others $separat - $ws - $state ($others) : ${(others / (totalTabs - 1))}');
    //     ref.read(tabSizeProvider(1).notifier).others((others / (totalTabs - 1)));
    //   }
    // }
    // previous = state;
    // state = null;
  }
}
