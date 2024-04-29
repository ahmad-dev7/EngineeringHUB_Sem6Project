import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/k_my_text.dart';
import 'package:myapp/constants/k_radius.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class ActionButton extends StatelessWidget {
  final Function() onAction;
  final String? label;
  final Widget? child;
  const ActionButton({
    super.key,
    required this.onAction,
    this.label,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    var myCtrl = Get.put(MyController());
    return MaterialButton(
      onPressed: onAction,
      minWidth: double.maxFinite,
      color: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(borderRadius: kRadius()),
      child: Obx(
        () => Visibility(
          visible: !myCtrl.showLoading.value,
          replacement: const CircularProgressIndicator(color: Colors.white),
          child: child ??
              KMyText(
                label ?? 'Submit',
                color: Theme.of(context).colorScheme.background,
              ),
        ),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  final VoidCallback onTap;
  final RoundedLoadingButtonController btnCtrl;
  final Widget? child;
  final String? label;

  const LoadingButton({
    super.key,
    required this.onTap,
    required this.btnCtrl,
    this.child,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      borderRadius: 15,
      controller: btnCtrl,
      animateOnTap: false,
      curve: Curves.fastOutSlowIn,
      duration: Durations.extralong1,
      completionDuration: Durations.extralong1,
      successColor: Theme.of(context).colorScheme.onPrimary,
      elevation: 10,
      color: Theme.of(context).colorScheme.secondary,
      height: 40,
      onPressed: onTap,
      child: child ?? KMyText(label!),
    );
  }
}
