import 'package:flutter/material.dart';

class ContainerZ extends StatelessWidget {
  const ContainerZ({super.key, required this.color, required this.width, required this.ratio});
  final Color? color;
  final double width;
  final double? ratio;
  @override
  Widget build(BuildContext context) {
    //  log(width.toString());
    final size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: size.height,
      width: width,
      color: color ?? Colors.green,
      // child: Image.network(_img, fit: BoxFit.cover),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Width: $width'),
          Text('Ratio: $ratio'),
        ],
      ),
    );
  }
}

const _img =
    'https://images.unsplash.com/photo-1713118774750-e1878e76b067?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw5OXx8fGVufDB8fHx8fA%3D%3D';
