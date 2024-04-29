import 'package:day_night_themed_switch/day_night_themed_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/my_controller.dart';
import 'package:myapp/theme/my_theme.dart';

class ThemeChanger extends StatelessWidget {
  const ThemeChanger({super.key});

  @override
  Widget build(BuildContext context) {
    var myCtrl = Get.put(MyController());
    return SizedBox(
      height: 50,
      width: 80,
      child: ThemeSwitcher.withTheme(
        builder: (_, switcher, theme) {
          return Obx(
            () => DayNightSwitch(
              value: myCtrl.isDarkTheme.value,
              onChanged: (val) {
                switcher.changeTheme(
                  isReversed: theme.brightness == Brightness.light,
                  theme: theme.brightness == Brightness.light
                      ? MyTheme.darkTheme
                      : MyTheme.lightTheme,
                );
                myCtrl.isDarkTheme.value = val;
              },
            ),
          );
        },
      ),
    );
  }
}
