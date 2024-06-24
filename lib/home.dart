import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window/providers/window.p.dart';
import 'package:window_manager/window_manager.dart';

import 'components/components.dart';
import 'helpers/shared_pref.dart';
import 'providers/listener.p.dart';
import 'components/separator.dart';

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
  void onWindowMove() {
    ref.read(wMListenerProvider.notifier).windowMoveEvents();
  }

  @override
  void onWindowMaximize() {
    _enterFullScreen();
    super.onWindowMaximize();
  }

  Future<void> _enterFullScreen() async => await saveWindowFullScreen(true);

  @override
  void onWindowUnmaximize() {
    _leaveFullScreen();
    super.onWindowUnmaximize();
  }

  Future<void> _leaveFullScreen() async => await saveWindowFullScreen(false);

  @override
  Widget build(BuildContext context) {
    ref.watch(isResizingProvider);
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Stack(
        children: [
          Positioned.fill(
            child: Row(
              children: [
                Consumer(builder: (context, state, __) {
                  final first = state.watch(tabSizeProvider(0));
                  final ratio = state.watch(tabSizeProvider(0).notifier).ratio;
                  return first.when(
                    error: (e, _) => Center(
                      child: Text(e.toString()),
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    data: (size) {
                      return ContainerZ(
                        width: size.width,
                        color: Colors.purple,
                        ratio: ratio,
                      );
                    },
                  );
                }),
                const Separator(i: 0),
                Consumer(builder: (context, state, __) {
                  final second = ref.watch(tabSizeProvider(1));
                  final ratio = state.watch(tabSizeProvider(1).notifier).ratio;
                  return second.when(
                    error: (e, _) => Center(
                      child: Text(e.toString()),
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    data: (size) {
                      return ContainerZ(
                        width: size.width,
                        color: Colors.lightGreen,
                        ratio: ratio,
                      );
                    },
                  );
                }),
                const Separator(i: 1),
                Consumer(builder: (context, state, __) {
                  final third = ref.watch(tabSizeProvider(2));
                  final ratio = state.watch(tabSizeProvider(2).notifier).ratio;
                  return third.when(
                    error: (e, _) => Center(
                      child: Text(e.toString()),
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    data: (size) {
                      return ContainerZ(
                        width: size.width,
                        color: Colors.lightGreen,
                        ratio: ratio,
                      );
                    },
                  );
                }),
              ],
            ),
          ),
          for (int i = 0; i < ref.watch(totalTabsProvider); i++)
            if (ref.watch(separatorPositionProvider(i)) != null)
              Positioned(
                left: ref.watch(separatorPositionProvider(i)),
                child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), child: const SeparatorX()),
              )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await clearSharedPref();
        },
        child: const Icon(Icons.clear_all),
      ),
    );
  }
}
