import 'package:flutter/material.dart';

import 'components.dart';
import 'separator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          ContainerZ(
            width: 200,
            color: Colors.purple,
          ),
          Separator(),
          ContainerZ(
            width: 250,
            color: Colors.lightGreen,
          )
        ],
      ),
    );
  }
}
