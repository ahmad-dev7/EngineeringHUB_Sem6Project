import 'package:flutter/material.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/theme/theme_changer.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: KMyText('EngineeringHub',
          size: 20, color: Theme.of(context).colorScheme.secondary),
      trailing: const ThemeChanger(),
    );
  }
}
