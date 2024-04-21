import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:window/helpers/shared_pref.dart';
import 'package:window_manager/window_manager.dart';

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
    log('Window Moved');
    if (startTime == null) {
      final position = await windowManager.getPosition();
      await saveWindowPosition(position);
    } else if (DateTime.now().difference(startTime!).inSeconds > windowMoveSaveAfter) {
      startTime = null;
    }
  }
}

Future<void> windowEvents(WidgetRef ref, String e) async {
  log('Window Event: $e');
}
