// Obtain shared preferences.
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

Future<void> initSharedPref() async {
  prefs = await SharedPreferences.getInstance();
}

Future<void> saveWindowSize(Size s) async {
  await prefs.setDouble('winSizeW', s.width);
  await prefs.setDouble('winSizeH', s.height);
}

Future<void> saveWindowPosition(Offset o) async {
  await prefs.setDouble('winPosX', o.dx);
  await prefs.setDouble('winPosY', o.dy);
}

Future<Size> getWindowSize() async {
  final double w = prefs.getDouble('winSizeW') ?? 800;
  final double h = prefs.getDouble('winSizeH') ?? 600;
  return Size(w, h);
}

Future<Offset?> getWindowPosition() async {
  final x = prefs.getDouble('winPosX');
  final y = prefs.getDouble('winPosY');
  if (x == null || y == null) return null;
  return Offset(x, y);
}
