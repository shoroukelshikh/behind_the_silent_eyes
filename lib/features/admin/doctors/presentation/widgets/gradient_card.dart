import 'package:flutter/material.dart';

class GradientCard extends StatelessWidget {
  final List<Widget> children; // The content of the Column
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final Gradient? gradient;

  const GradientCard({
    Key? key,
    required this.children,
    required this.width ,
    required this.height ,
    this.borderRadius,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient ??
            LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0B2F60),
                Color(0xFF707E90),
              ],
            ),
        borderRadius: borderRadius ?? BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Column only as big as its children
        children: children,
      ),
    );
  }
}