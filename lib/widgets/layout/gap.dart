import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  final double gap;
  final bool h;
  const Gap(this.gap, {Key? key, this.h = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (h) {
      return SizedBox(width: gap);
    }
    return SizedBox(height: gap);
  }
}
