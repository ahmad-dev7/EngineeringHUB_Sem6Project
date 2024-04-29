import 'package:flutter/material.dart';
import 'package:myapp/constants/k_paddings.dart';
import 'package:myapp/constants/side_bar_button.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.all(10),
        color: Theme.of(context).colorScheme.primary,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KVerticalSpace(height: 45),
            SideBarButton(
              value: 0,
              label: 'Chat',
              icon: Icons.chat,
            ),
            KVerticalSpace(height: 45),
            SideBarButton(
              value: 1,
              label: 'Notes',
              icon: Icons.note,
            ),
            KVerticalSpace(height: 45),
            SideBarButton(
              value: 2,
              label: 'Profile',
              icon: Icons.person,
            ),
          ],
        ),
      ),
    );
  }
}
