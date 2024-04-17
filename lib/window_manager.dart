import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'constants.dart';

late WindowOptions windowOptions;

Future<void> windowManagerInit() async {
  windowOptions = const WindowOptions(
    size: Size((defaultTabWidth * 2) + 6, 600),
    // center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}

