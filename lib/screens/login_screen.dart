import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/heading_image.dart';
import 'package:myapp/components/login_form.dart';
import 'package:myapp/components/question_button.dart';
import 'package:myapp/components/top_bar.dart';
import 'package:myapp/constants/k_my_page_container.dart';
import 'package:myapp/constants/k_paddings.dart';
import 'package:myapp/screens/signup_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KMyPageContainer(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: ResponsiveBreakpoints.of(context).isDesktop ? 500 : null,
              child: Column(
                children: [
                  const KVerticalSpace(height: 8),
                  //* Theme Changer
                  const TopBar(),
                  const KVerticalSpace(),
                  //* Header image
                  const HeadingImage(),
                  const KVerticalSpace(),
                  //* Login Text
                  const Text('Login'),
                  const KVerticalSpace(),
                  //* Login Form
                  const LoginForm(),
                  const KVerticalSpace(),
                  //* go to signup page
                  QuestionButton(
                    question: 'Don\'t have an account?',
                    action: 'Create account',
                    onTap: () => Get.to(() => const SignupScreen()),
                  ),
                  const KVerticalSpace(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
