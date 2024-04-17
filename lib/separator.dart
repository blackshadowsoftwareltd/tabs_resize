import 'package:flutter/material.dart';

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: 5,
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        horizontal(),
        const SizedBox(width: 1),
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
