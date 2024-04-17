import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:window/providers/window.p.dart';
import 'package:window_manager/window_manager.dart';

import '../constants.dart';

part 'listener.p.g.dart';

@riverpod
class WMListener extends _$WMListener {
  @override
  void build() => windowManager.listeners;
}

Future<void> windowEvents(WidgetRef ref, String e) async {
  log(e);
  if (e.contains('resize')) {
    final t = ref.read(totalTabsProvider);
    final s = await windowManager.getSize();
    log(s.width.toString());
    for (int i = 0; i < t; i++) {
      final size = Size(((s.width - ((t - 1) * separatorWidth)) / 2).abs(), s.height);
      ref.read(tabSizeProvider(i).notifier).reSize(size);
    }
  }
}
