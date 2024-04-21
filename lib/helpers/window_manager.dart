import 'dart:developer';

import 'package:flutter/material.dart';

import 'constants.dart';
import 'package:window_manager/window_manager.dart';

import 'shared_pref.dart';

late WindowOptions windowOptions;

Future<void> windowManagerInit() async {
  const size = Size((defaultTabWidth * totalTabs) + (6 * totalTabs), defaultTabHeight);

  windowOptions = const WindowOptions(
    size: size,
    minimumSize: size, maximumSize: size,
    // center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    fullScreen: false,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    final position = await getWindowPosition();
    log(position.toString());
    if (position != null) {
      await windowManager.setPosition(position, animate: true);
    }
  });
}
