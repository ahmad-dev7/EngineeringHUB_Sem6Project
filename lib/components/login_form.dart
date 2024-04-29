import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/action_button.dart';
import 'package:myapp/constants/k_paddings.dart';
import 'package:myapp/constants/k_validators.dart';
import 'package:myapp/constants/password_suffix_button.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/screens/navigation_screen.dart';
import 'package:myapp/services/services.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    String? email;
    String? password;
    var btnCtrl = RoundedLoadingButtonController();
    var formKey = GlobalKey<FormState>();
    var myCtrl = Get.put(MyController());
    onLogin() async {
      if (formKey.currentState!.validate()) {
        btnCtrl.start();
        myCtrl.showLoading.toggle();
        var services = BackendServices();
        var response = await services.loginUser(
          email: email!,
          password: password!,
        );
        if (response) {
          Get.put(MyController());
          btnCtrl.success();
          await Future.delayed(Durations.extralong1);
          Get.offAll(() => const NavigationScreen());
        } else {
          Get.snackbar(
            'Error',
            'Wrong credentials',
            maxWidth: 500,
            colorText: Colors.white,
            backgroundColor: Colors.redAccent,
          );
          btnCtrl.error();
          await Future.delayed(Durations.extralong4);
          myCtrl.hidePassword.value = false;
          btnCtrl.reset();
        }
        myCtrl.showLoading.toggle();
      }
    }

    //* Login Form
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            onFieldSubmitted: (_) => onLogin(),
            textInputAction: TextInputAction.next,
            validator: (value) => emailValidator(value),
            onChanged: (value) => email = value,
            decoration: const InputDecoration(
              hintText: 'Enter email id',
              prefixIcon: Icon(Icons.email),
            ),
          ),
          const KVerticalSpace(),
          Obx(
            () => TextFormField(
              onFieldSubmitted: (_) => onLogin(),
              textInputAction: TextInputAction.done,
              validator: (value) => passwordValidator(value),
              onChanged: (value) => password = value,
              obscureText: myCtrl.hidePassword.value,
              decoration: const InputDecoration(
                hintText: 'Enter password',
                prefixIcon: Icon(Icons.lock),
                suffixIcon: PasswordSuffixButton(),
              ),
            ),
          ),
          const KVerticalSpace(),
          LoadingButton(onTap: onLogin, btnCtrl: btnCtrl, label: 'Login')
        ],
      ),
    );
  }
}
