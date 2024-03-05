import 'package:flutter/material.dart';

class CommonSizedBox extends StatelessWidget {
  final double width; final double height;

  const CommonSizedBox({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,height: height,
    );
  }
}
