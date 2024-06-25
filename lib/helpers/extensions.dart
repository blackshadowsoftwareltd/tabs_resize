import 'package:screen_retriever/screen_retriever.dart';

extension DisplayExt on Display {
  String get displayInfo {
    return 'Display: $id\n$name\n$scaleFactor\n$size\n$visiblePosition\n$visibleSize';
  }
}
