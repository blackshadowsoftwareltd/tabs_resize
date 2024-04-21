import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/window.p.dart';

class Separator extends ConsumerWidget {
  const Separator({super.key, required this.i});
  final int i;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(separatorPositionProvider(i));
    final separatorFirst = ref.read(separatorPositionProvider(i).notifier);

    return MouseRegion(
      cursor: SystemMouseCursors.resizeLeftRight,
      // onEnter: (_) => print('onEnter'),
      // onExit: (_) => print('onExit'),
      // onHover: (_) => print('onHover'),
      child: GestureDetector(
        onHorizontalDragStart: (v) async => await separatorFirst.start(v.globalPosition.dx),
        onHorizontalDragUpdate: (v) async => await separatorFirst.update(v.globalPosition.dx),
        onHorizontalDragEnd: (v) async => await separatorFirst.end(),
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
