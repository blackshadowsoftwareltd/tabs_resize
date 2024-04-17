import 'package:flutter/material.dart';

class ContainerZ extends StatelessWidget {
  const ContainerZ({super.key, required this.color, required this.width});
  final Color? color;
  final double width;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: width,
      color: color ?? Colors.green,
    );
  }
}
