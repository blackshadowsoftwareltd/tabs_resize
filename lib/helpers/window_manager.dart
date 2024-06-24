import 'dart:developer';

import 'package:flutter/material.dart';

import 'constants.dart';
import 'package:window_manager/window_manager.dart';

import 'shared_pref.dart';

late WindowOptions windowOptions;

Future<void> windowManagerInit() async {
  const min = Size((defaultTabWidth * totalTabs) + (6 * totalTabs), defaultTabHeight);
  final size = await getWindowSize() ?? min;
  if (getWindowFullScreen()) {
    await windowManager.maximize();
  } else {
    await setWindowPosition();
  }

  windowOptions = WindowOptions(
    size: size,
    minimumSize: min,
    // maximumSize: size,
    // center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    fullScreen: false,
  );
  await windowManager.waitUntilReadyToShow(windowOptions, () async {});
}

Future<void> setWindowPosition() async {
  final position = await getWindowPosition();
  log(position.toString());
  if (position != null) {
    await windowManager.setPosition(position, animate: true);
  }
}
