import 'package:flutter/material.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

SalomonBottomBarItem kGetBottomBarItems({
  required IconData icon,
  required String text,
  required IconData activeIcon,
  required BuildContext context,
}) {
  return SalomonBottomBarItem(
    icon: Icon(icon),
    title: KMyText(text, color: Theme.of(context).colorScheme.secondary),
    activeIcon: Icon(activeIcon),
    selectedColor: Theme.of(context).colorScheme.secondary,
    unselectedColor: Colors.blueGrey.withOpacity(.8),
  );
}

List<SalomonBottomBarItem> kBottomBarItems(BuildContext context) {
  return [
    kGetBottomBarItems(
      context: context,
      icon: Icons.chat_bubble_outline_outlined,
      text: 'Chat',
      activeIcon: Icons.chat_bubble,
    ),
    kGetBottomBarItems(
      context: context,
      icon: Icons.note_add_outlined,
      text: 'Notes',
      activeIcon: Icons.note_add,
    ),
    kGetBottomBarItems(
      context: context,
      icon: Icons.person_2_outlined,
      text: 'Profile',
      activeIcon: Icons.person_2,
    ),
  ];
}
