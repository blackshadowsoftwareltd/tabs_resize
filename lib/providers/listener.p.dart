import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:window/helpers/shared_pref.dart';
import 'package:window/providers/window.p.dart';
import 'package:window_manager/window_manager.dart';

import '../helpers/constants.dart';

part 'listener.p.g.dart';

DateTime? startTime = DateTime.now();
const windowMoveSaveAfter = 3;

@riverpod
class WMListener extends _$WMListener {
  @override
  void build() {
    windowManager.listeners;
  }

  Future<void> windowMoveEvents() async {
    // log('Window Moved');
    if (startTime == null) {
      final position = await windowManager.getPosition();
      final size = await windowManager.getSize();
      await saveWindowPosition(position);
      ref.read(isResizingProvider.notifier).setDebounce(size);
    } else if (DateTime.now().difference(startTime!).inSeconds > windowMoveSaveAfter) {
      startTime = null;
    }
  }
}

Future<void> windowEvents(WidgetRef ref, String e) async {
  // log('Window Event: $e');
}

@Riverpod(keepAlive: true)
class IsResizing extends _$IsResizing {
  Timer? debounceTimer;
  @override
  bool build() {
    ref.onDispose(() => debounceTimer?.cancel());
    return false;
  }

  void toggle() => state = !state;

  void cancelDebounce() {
    debounceTimer!.cancel();
    debounceTimer = null;
  }

  void setDebounce(Size s) {
    if (debounceTimer?.isActive == true) cancelDebounce();

    debounceTimer = Timer(debounceDuration, () async => await ref.read(winSizeProvider.notifier).checkUpdate(s));
  }
}
