import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/my_controller.dart';

class PasswordSuffixButton extends StatelessWidget {
  const PasswordSuffixButton({super.key});

  @override
  Widget build(BuildContext context) {
    var myCtrl = Get.put(MyController());
    return Obx(
      () => IconButton(
        onPressed: () => myCtrl.hidePassword.toggle(),
        icon: Icon(
          myCtrl.hidePassword.value ? Icons.visibility_off : Icons.visibility,
        ),
      ),
    );
  }
}
