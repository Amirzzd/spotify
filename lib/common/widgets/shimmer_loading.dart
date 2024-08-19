import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  final Widget? child;
  const ShimmerLoading({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Shimmer.fromColors(
      baseColor: theme.hoverColor,
      highlightColor: theme.hoverColor,
      child: child ??
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          ),
      // direction: ShimmerDirection.ttb,
    );
  }
}
