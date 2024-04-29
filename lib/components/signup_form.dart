import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/components/action_button.dart';
import 'package:myapp/constants/k_dropdown_search.dart';
import 'package:myapp/constants/k_items_list.dart';
import 'package:myapp/constants/k_paddings.dart';
import 'package:myapp/constants/k_validators.dart';
import 'package:myapp/constants/password_suffix_button.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/model/user_data.dart';
import 'package:myapp/screens/navigation_screen.dart';
import 'package:myapp/services/services.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    var myCtrl = Get.put(MyController());
    var formKey = GlobalKey<FormState>();
    var btnCtrl = RoundedLoadingButtonController();

    String? college;
    String? branch;
    String? semester;
    String? name;
    String? email;
    String? number;
    String? password;

    onSignup() async {
      if (formKey.currentState!.validate()) {
        btnCtrl.start();
        myCtrl.showLoading.toggle();
        var services = BackendServices();
        UserData data = UserData(
          college: college!,
          branch: branch!,
          semester: semester!,
          name: name!,
          email: email!.trim().toLowerCase(),
          phone: number!,
        );
        var res =
            await services.createUser(userData: data, password: password!);
        if (res) {
          Get.put(MyController());
          btnCtrl.success();
          await Future.delayed(Durations.extralong1);
          Get.offAll(() => const NavigationScreen());
        } else {
          btnCtrl.error();
        }

        myCtrl.showLoading.toggle();
      } else {
        print('Form not filled correctly');
      }
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          //* College
          KSearchDropDown(
            buttonHint: 'Select College',
            searchHint: 'Search College',
            itemsList: collegeList,
            onSelect: (val) => college = val,
            validate: collegeValidator,
          ),
          const KVerticalSpace(),
          //* Branch & Semester
          Row(
            children: [
              Flexible(
                flex: 5,
                child: KSearchDropDown(
                  buttonHint: 'Select Branch',
                  searchHint: 'Search Branch',
                  itemsList: branchList,
                  onSelect: (val) => branch = val,
                  validate: branchValidator,
                ),
              ),
              const KHorizontalSpace(),
              Flexible(
                flex: 3,
                child: KSearchDropDown(
                  buttonHint: 'Semester',
                  searchHint: '',
                  itemsList: semesterList,
                  hideSearch: true,
                  onSelect: (val) => semester = val,
                  validate: semesterValidator,
                ),
              ),
            ],
          ),
          const KVerticalSpace(),
          //* Name
          TextFormField(
            onFieldSubmitted: (value) => onSignup(),
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            onChanged: (value) => name = value,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.person),
              hintText: 'Enter your name',
            ),
            validator: nameValidator,
          ),
          const KVerticalSpace(),
          //* Email
          TextFormField(
            onFieldSubmitted: (value) => onSignup(),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => email = value,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.email),
              hintText: 'Enter your email',
            ),
            validator: emailValidator,
          ),
          const KVerticalSpace(),
          //* Phone Number
          TextFormField(
            onFieldSubmitted: (value) => onSignup(),
            onChanged: (value) => number = value,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.phone),
              hintText: 'Enter your phone number',
            ),
            validator: phoneNumberValidator,
          ),
          const KVerticalSpace(),
          //* Password
          Obx(
            () => TextFormField(
              onFieldSubmitted: (value) => onSignup(),
              onChanged: (value) => password = value,
              textInputAction: TextInputAction.done,
              obscureText: myCtrl.hidePassword.value,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                suffixIcon: PasswordSuffixButton(),
                hintText: 'Enter your password',
              ),
              validator: passwordValidator,
            ),
          ),
          const KVerticalSpace(height: 30),
          //* Signup button
          LoadingButton(onTap: onSignup, btnCtrl: btnCtrl, label: 'Signup')
        ],
      ),
    );
  }
}
