import 'package:flutter/material.dart';
import 'package:myapp/constants/k_radius.dart';

class KDropdownWrapper extends StatelessWidget {
  final Widget child;
  const KDropdownWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.background,
          width: 1,
        ),
        borderRadius: kRadius(),
      ),
      child: child,
    );
  }
}
