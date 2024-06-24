// Obtain shared preferences.
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

Future<void> initSharedPref() async {
  prefs = await SharedPreferences.getInstance();
}

Future<void> clearSharedPref() async {
  await prefs.clear();
}

Future<void> saveWindowFullScreen(bool v) async {
  log('Save Full Screen : $v');
  await prefs.setBool('fullScreen', v);
}

Future<void> saveWindowSize(Size s) async {
  await prefs.setDouble('winSizeW', s.width);
  await prefs.setDouble('winSizeH', s.height);
}

Future<void> saveWindowPosition(Offset o) async {
  await prefs.setDouble('winPosX', o.dx);
  await prefs.setDouble('winPosY', o.dy);
}

// Future<void> saveTabWidth(String tab, double w) async {
//   await prefs.setDouble('winTabW$tab', w);
// }

Future<void> saveTabRatio(String tab, double w) async {
  log('Save tab Ratio : $tab -> $w');
  await prefs.setDouble('Ratio$tab', w);
}

Future<Size?> getWindowSize() async {
  final double? w = prefs.getDouble('winSizeW');
  final double? h = prefs.getDouble('winSizeH');
  if (w == null || h == null) return null;
  return Size(w, h);
}

Future<Offset?> getWindowPosition() async {
  final x = prefs.getDouble('winPosX');
  final y = prefs.getDouble('winPosY');
  if (x == null || y == null) return null;
  return Offset(x, y);
}

Future<double?> getTabRatio(String tab) async {
  return prefs.getDouble('Ratio$tab');
}

bool getWindowFullScreen() {
  return prefs.getBool('fullScreen') ?? false;
}
