import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window/providers/window.p.dart';

import 'components.dart';
import 'separator.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final first = ref.watch(tabSizeProvider(0));
    final second = ref.watch(tabSizeProvider(1));
    final separatorFirst = ref.watch(separatorPositionProvider(0));
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Row(
              children: [
                ContainerZ(
                  width: first.width,
                  color: Colors.purple,
                ),
                const Separator(),
                ContainerZ(
                  width: second.width,
                  color: Colors.lightGreen,
                )
              ],
            ),
          ),
          if (separatorFirst != null)
            Positioned(
              left: separatorFirst,
              child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), child: const SeparatorX()),
            ),
        ],
      ),
    );
  }
}
