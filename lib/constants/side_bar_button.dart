import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/controller/my_controller.dart';

class SideBarButton extends StatelessWidget {
  final int value;
  final String label;
  final IconData icon;
  const SideBarButton(
      {super.key,
      required this.value,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    var myCtrl = Get.put(MyController());
    return Obx(
      () => ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: myCtrl.activeScreen.value == value
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.background,
        ),
        onPressed: () => myCtrl.activeScreen.value = value,
        icon: Icon(
          icon,
          color: myCtrl.activeScreen.value == value
              ? Theme.of(context).colorScheme.onBackground
              : Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
        ),
        label: KMyText(
          label,
          color: myCtrl.activeScreen.value == value
              ? Theme.of(context).colorScheme.onBackground
              : Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
        ),
      ),
    );
  }
}
