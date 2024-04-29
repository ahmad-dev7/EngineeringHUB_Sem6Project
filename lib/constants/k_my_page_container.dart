import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:myapp/constants/k_paddings.dart';

class KMyPageContainer extends StatelessWidget {
  final Widget child;
  final double? padding;
  const KMyPageContainer({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: SafeArea(
        child: KHorizontalPadding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
