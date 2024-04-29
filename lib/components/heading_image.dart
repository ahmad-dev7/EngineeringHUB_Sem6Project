import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/k_paddings.dart';
import 'package:myapp/controller/my_controller.dart';

class HeadingImage extends StatelessWidget {
  const HeadingImage({super.key});

  @override
  Widget build(BuildContext context) {
    var myCtrl = Get.put(MyController());
    return KHorizontalPadding(
      padding: 40,
      child: Obx(
        () => Opacity(
          opacity: myCtrl.isDarkTheme.value ? 0.9 : 1,
          child: Image.asset('images/logo.png'),
        ),
      ),
    );
  }
}
