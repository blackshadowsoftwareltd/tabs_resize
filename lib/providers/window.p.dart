import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:window_manager/window_manager.dart';
import '../helpers/constants.dart';
import '../helpers/shared_pref.dart';
part 'window.p.g.dart';

@Riverpod(keepAlive: true)
class TotalTabs extends _$TotalTabs {
  @override
  int build() => totalTabs;
}

@Riverpod(keepAlive: true)
class WinSize extends _$WinSize {
  @override
  Future<Size> build() async {
    return await windowManager.getSize();
  }
}

@Riverpod(keepAlive: false)
class TabSize extends _$TabSize {
  double? position;
  @override
  Future<Size> build(int i) async {
    position ??= 0;
    final oldWidth = await getTabWidth(i.toString());
    log('Old tab $i $oldWidth P $position');
    final s = ref.watch(winSizeProvider).value;

    final t = ref.watch(totalTabsProvider);

    final exceptSep = s?.width == null ? 0 : s!.width - (separatorWidth * (t - 1));

    final size = oldWidth != null ? Size(oldWidth.abs(), s?.height ?? 0) : Size((exceptSep / t).abs(), s?.height ?? 0);
    // final size = Size((exceptSep / t).abs(), s?.height ?? 0);
    for (int l = 0; l < i; l++) {
      final w = ref.read(tabSizeProvider(l)).value?.width ?? 0.0;
      position = s?.width == null ? 0 : (position ?? 0) + w;
    }
    log('New tab-1 $i ${size.width} P $position');
    // position = position ?? 0 + (separatorWidth * i);
    log('New tab-2 $i ${size.width} P $position');
    return size;
  }

  void reSize(Size s) {
    ref.invalidateSelf();
  }

  void current(double v) {
    state = AsyncValue.data(Size(v, state.value!.height));
  }

  void next(double v) {
    final p = (state.value?.width ?? 0) - v;
    position = position! + p;
    log('Current state ${state.value?.width ?? 0} - v $v = $position');
    state = AsyncValue.data(Size(v, state.value!.height));
  }
}

@Riverpod(keepAlive: false)
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
    log('NS $nextSize NP $nextPosition V $v');
    double minP = separatorWidth * i;
    for (int l = 0; l < i; l++) {
      minP += ref.read(tabSizeProvider(l)).value?.width ?? 0.0;
    }
    final current = v - minP;
    final next = nextPosition + nextSize - v + (separatorWidth * i);
    log('Current $current Next $next');
    ref.read(tabSizeProvider(i).notifier).current(current);
    ref.read(tabSizeProvider(i + 1).notifier).next(next);
    await saveTabWidth(i.toString(), current);
    await saveTabWidth((i + 1).toString(), next);
    state = null;
  }
}
