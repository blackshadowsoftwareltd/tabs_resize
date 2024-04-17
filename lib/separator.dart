import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/window.p.dart';

class Separator extends ConsumerWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final separatorFirst = ref.read(separatorPositionProvider(0).notifier);

    return MouseRegion(
      cursor: SystemMouseCursors.resizeLeftRight,
      onEnter: (_) => print('onEnter'),
      onExit: (_) => print('onExit'),
      // onHover: (_) => print('onHover'),
      child: GestureDetector(
        onHorizontalDragStart: (v) => separatorFirst.startEnd(v.globalPosition.dx),
        onHorizontalDragUpdate: (v) => separatorFirst.update(v.globalPosition.dx),
        onHorizontalDragEnd: (v) => separatorFirst.startEnd(null),
        child: const SeparatorX(),
      ),
    );
  }
}

class SeparatorX extends StatelessWidget {
  const SeparatorX({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: 6,
      decoration: const BoxDecoration(color: Colors.white),
      child: const SeparatorIcon(),
    );
  }
}

class SeparatorIcon extends StatelessWidget {
  const SeparatorIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        horizontal(),
        horizontal(),
      ],
    );
  }

  Widget horizontal() {
    return const ColoredBox(
      color: Colors.black,
      child: SizedBox(
        width: 1,
        height: 30,
      ),
    );
  }
}
