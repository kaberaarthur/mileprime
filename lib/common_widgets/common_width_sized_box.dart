import 'package:flutter/material.dart';

class CommonWidthSizedBox extends StatelessWidget {
  final double width;

  const CommonWidthSizedBox({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
