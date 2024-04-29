import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:myapp/controller/animation_controller.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/screens/navigation_screen.dart';
import 'package:myapp/services/services.dart';

class LoadData extends StatelessWidget {
  const LoadData({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController = Get.put(MyAnimationController());
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'images/loadingDataAnimation.json',
          controller: animationController.controller,
          onLoaded: (composition) => myAnimationPlayer(
            composition,
            animationController,
          ),
        ),
      ),
    );
  }

  myAnimationPlayer(var composition, MyAnimationController controller) {
    controller.controller
      ..duration = composition.duration
      ..forward().whenComplete(
        () {
          final myController = Get.put(MyController());
          BackendServices().getUserData();
          if (myController.isDataLoaded.value) {
            Get.offAll(
              () => const NavigationScreen(),
              transition: Transition.cupertinoDialog,
              duration: const Duration(seconds: 2),
            );
          } else {
            controller.controller.reset();
            myAnimationPlayer(composition, controller);
          }
        },
      );
  }
}
