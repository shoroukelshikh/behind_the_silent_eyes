import 'package:behind_silent_eyes/core/theme/colors.dart';
import 'package:flutter/material.dart';

class GradientCard extends StatelessWidget {
  final List<Widget> children;
  final double width;
  final double? height;
  final BorderRadius? borderRadius;
  final Gradient? gradient;

  const GradientCard({
    Key? key,
    required this.children,
    required this.width,
    this.height,
    this.borderRadius,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.cardColor,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}