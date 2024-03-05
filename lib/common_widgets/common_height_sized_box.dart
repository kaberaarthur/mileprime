import 'package:flutter/material.dart';

class CommonHeightSizedBox extends StatelessWidget {
  final double height;

  const CommonHeightSizedBox({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
