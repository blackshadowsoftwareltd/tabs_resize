import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window/providers/window.p.dart';
import 'package:window_manager/window_manager.dart';

import 'components.dart';
import 'providers/listener.p.dart';
import 'separator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowEvent(String e) {
    windowEvents(ref, e);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(winSizeProvider);
    // log(MediaQuery.of(context).size.width.toString());

    final separatorFirst = ref.watch(separatorPositionProvider(0));
    final separatorSecond = ref.watch(separatorPositionProvider(1));
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Stack(
        children: [
          Positioned.fill(
            child: Row(
              children: [
                Consumer(builder: (context, state, __) {
                  final first = state.watch(tabSizeProvider(0));
                  return first.when(
                    error: (e, _) => Center(
                      child: Text(e.toString()),
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    data: (size) {
                      return ContainerZ(
                        width: size.width,
                        color: Colors.purple,
                      );
                    },
                  );
                }),
                const Separator(i: 0),
                Consumer(builder: (context, state, __) {
                  final second = ref.watch(tabSizeProvider(1));
                  return second.when(
                    error: (e, _) => Center(
                      child: Text(e.toString()),
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    data: (size) {
                      return ContainerZ(
                        width: size.width,
                        color: Colors.lightGreen,
                      );
                    },
                  );
                }),
                const Separator(i: 1),
                Consumer(builder: (context, state, __) {
                  final third = ref.watch(tabSizeProvider(2));
                  return third.when(
                    error: (e, _) => Center(
                      child: Text(e.toString()),
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    data: (size) {
                      return ContainerZ(
                        width: size.width,
                        color: Colors.lightGreen,
                      );
                    },
                  );
                }),
              ],
            ),
          ),
          if (separatorFirst != null)
            Positioned(
              left: separatorFirst,
              child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), child: const SeparatorX()),
            ),
          if (separatorSecond != null)
            Positioned(
              left: separatorSecond,
              child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), child: const SeparatorX()),
            ),
        ],
      ),
    );
  }
}
