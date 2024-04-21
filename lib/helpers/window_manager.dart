import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'constants.dart';
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

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();

    final position = await getWindowPosition();
    print('Get : $position');

    if (position != null) {
      windowManager.setPosition(position, animate: true);
    }
  });
}
