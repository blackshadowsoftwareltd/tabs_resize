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
  double t = 0;
  @override
  Future<Size> build() async {
    return await windowManager.getSize();
  }

  Future<void> checkUpdate(Size s) async {
    if (s == state.value) return;
    state = AsyncValue.data(s);
  }

  double actual() {
    return ((state.value?.width ?? 0) - (separatorWidth * (totalTabs - 1))).abs();
  }
}

@Riverpod(keepAlive: false)
class TabSize extends _$TabSize {
  double? position, ratio;
  @override
  Future<Size> build(int i) async {
    final s = ref.watch(winSizeProvider.select((v) => v.value ?? const Size(0, 0)));
    final actual = ref.watch(winSizeProvider.notifier).actual();
    position = null;
    final oldRatio = await getTabRatio(i.toString());

    ratio = oldRatio;
    if (s.width != 0) {
      if (ratio == null) {
        ratio = toRatio(actual / totalTabs, actual);
        log('Ratio $ratio');
      } else {}
    }
    log('$i << $oldRatio >> $ratio # $actual');

    return Size(fromRatio(ratio ?? 0, actual), s.height);
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

  double getPosition() {
    if (position != null) return position!;
    double t = 0;
    for (int l = 0; l < i; l++) {
      t += ref.read(tabSizeProvider(l)).value?.width ?? 0.0;
    }
    log('>> $t');
    return position = t;
  }
}

@Riverpod(keepAlive: false)
class SeparatorPosition extends _$SeparatorPosition {
  double? previous;
  @override
  double? build(int i) {
    ref.watch(winSizeProvider);
    return null;
  }

  Future<void> start(double v) async {
    previous ?? v;
    state = v - 3;
  }

  Future<void> update(double? vz) async {
    // log(vz.toString());
    final nextSize = ref.read(tabSizeProvider(i + 1)).value?.width ?? 0;
    final nextPosition = ref.read(tabSizeProvider(i + 1).notifier).getPosition();

    final v = vz ?? 0;

    double minP = separatorWidth * i;
    for (int l = 0; l < i; l++) {
      minP += ref.read(tabSizeProvider(l)).value?.width ?? 0.0;
    }
    if (v < minP + minimumTabWidth) return;
    log('$v > $nextPosition + $nextSize - $minimumTabWidth = ${nextPosition + nextSize - minimumTabWidth} /= ${v > nextPosition + nextSize - minimumTabWidth} ');
    if (v > nextPosition + nextSize - minimumTabWidth) return;
    state = v - 3;
  }

  Future<void> end() async {
    await Future.delayed(const Duration(milliseconds: 100));
    final nextSize = ref.read(tabSizeProvider(i + 1)).value?.width ?? 0;
    final nextPosition = ref.read(tabSizeProvider(i + 1).notifier).getPosition();
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
    // await saveTabWidth(i.toString(), current);
    // await saveTabWidth((i + 1).toString(), next);
    final s = ref.watch(winSizeProvider.notifier).actual();
    final cr = toRatio(current, s);
    final nr = toRatio(next, s);
    await saveTabRatio(i.toString(), cr);
    await saveTabRatio((i + 1).toString(), nr);
    if (i > 0) {
      await saveTabRatio(0.toString(), 1 - cr - nr);
    } else if (i == 0) {
      await saveTabRatio((totalTabs - 1).toString(), 1.0 - cr - nr);
    }
    state = null;
  }
}

double toRatio(double w, double s) {
  return w / s;
}

double fromRatio(double r, double s) {
  return s * r;
}
