import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'constants.dart';

late WindowOptions windowOptions;

Future<void> windowManagerInit() async {
  const totalWindow = 3;
  const size = Size((defaultTabWidth * totalWindow) + (6 * totalWindow), defaultTabHeight);
  windowOptions = const WindowOptions(
    size: size,
    minimumSize: size, maximumSize: size,
    // center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    fullScreen: false,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}
