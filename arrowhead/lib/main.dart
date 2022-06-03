import 'package:arrowhead/providers/auth_provider.dart';
import 'package:arrowhead/providers/password_provider.dart';
import 'package:arrowhead/providers/theme_provider.dart';
import 'package:arrowhead/screens/CreateEditPassword/create_edit_password.dart';
import 'package:arrowhead/screens/ForgotPassword/forgot_password_confimation_screen.dart';
import 'package:arrowhead/screens/ForgotPassword/forgot_password_screen.dart';
import 'package:arrowhead/screens/HomePage/home_page.dart';
import 'package:arrowhead/screens/HomePage/password_information.dart';
import 'package:arrowhead/screens/Settings/user_settings.dart';
import 'package:arrowhead/screens/SignUp/signup_screen.dart';
import 'package:arrowhead/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/CreateEditPassword/create_edit_password.dart';
import '/screens/HomePage/home_page.dart';
import 'firebase_options.dart';
import 'screens/Login/login_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ArrowHead());
}

class ArrowHead extends StatelessWidget {
  const ArrowHead({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeProvider()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, PasswordProvider>(
          create: (context) => PasswordProvider(),
          update: (context, authData, previousPasswordProvider) =>
              PasswordProvider.loggedIn(authData.id),
        )
      ],
      child: const MyMaterialApp(),
    );
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ArrowHead',
      theme: theme.themeData,
      home: Consumer<Auth>(
          builder: (ctx, authData, _) => authData.isLoggedIn
              ? const HomePage()
              : FutureBuilder(
                  future: authData.tryAutoLogin(),
                  builder: (ctx, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const LoginScreen(),
                )),
      routes: {
        LoginScreen.routeName: (ctx) => const LoginScreen(),
        SingupScreen.routeName: (ctx) => const SingupScreen(),
        ForgotPasswordScreen.routeName: (ctx) => ForgotPasswordScreen(),
        ForgotPasswordConfirmationScreen.routeName: (ctx) =>
            ForgotPasswordConfirmationScreen(),
        HomePage.routeName: (ctx) => HomePage(),
        CreateEditPassword.routeName: (ctx) => CreateEditPassword()
        PasswordInfo.routeName: (ctx) => const PasswordInfo(),
      },
    );
  }
}
