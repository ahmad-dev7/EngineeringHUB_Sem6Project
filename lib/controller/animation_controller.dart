import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAnimationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void onInit() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    super.onInit();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
