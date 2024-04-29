import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/side_bar.dart';
import 'package:myapp/constants/k_bottombar_items.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/screens/chat_screen.dart';
import 'package:myapp/screens/notes_screen.dart';
import 'package:myapp/screens/profile_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var myCtrl = Get.put(MyController());
    var screens = [
      const ChatScreen(),
      const NotesScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: ResponsiveBreakpoints.of(context).isMobile
          ? Obx(() => screens[myCtrl.activeScreen.value])
          : Row(
              children: [
                const SideBar(),
                Expanded(
                  flex: 4,
                  child: Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: screens[myCtrl.activeScreen.value],
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: ResponsiveBreakpoints.of(context).isDesktop
          ? null
          : Obx(
              () => SalomonBottomBar(
                currentIndex: myCtrl.activeScreen.value,
                onTap: (val) => myCtrl.activeScreen.value = val,
                items: kBottomBarItems(context),
              ),
            ),
    );
  }
}
