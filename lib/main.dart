import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/screens/loading_data.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/theme/my_theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: MyTheme.darkTheme, //* Default theme on startup of app
      builder: (context, myTheme) {
        return GetMaterialApp(
          builder: (context, child) => ResponsiveBreakpoints.builder(
            child: child!,
            breakpoints: [
              const Breakpoint(start: 0, end: 550, name: MOBILE),
              const Breakpoint(start: 551, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            ],
          ),
          debugShowCheckedModeBanner: false,
          theme: myTheme,
          home: FirebaseAuth.instance.currentUser == null
              ? const LoginScreen()
              : const LoadData(),
        );
      },
    );
  }
}
