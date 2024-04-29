import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/question_button.dart';
import 'package:myapp/components/signup_form.dart';
import 'package:myapp/components/top_bar.dart';
import 'package:myapp/constants/k_my_page_container.dart';
import 'package:myapp/constants/k_paddings.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
                  const KVerticalSpace(),
                  //* Theme Changer
                  const TopBar(),
                  const KVerticalSpace(),
                  //* Signup form
                  const SignupForm(),
                  const KVerticalSpace(),
                  //* Go to login page
                  QuestionButton(
                    question: 'Already have an account?',
                    action: 'Login',
                    onTap: () => Get.to(() => const LoginScreen()),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
