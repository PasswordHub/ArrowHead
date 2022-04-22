import 'package:arrowhead/providers/theme_provider.dart';
import 'package:arrowhead/screens/CreateEditPassword/create_edit_password.dart';
import 'package:arrowhead/screens/HomePage/home_page.dart';
import 'package:arrowhead/screens/SignUp/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/Login/login_screen.dart';

void main() {
  runApp(const ArrowHead());
}

class ArrowHead extends StatelessWidget {
  const ArrowHead({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: ThemeProvider())],
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
      home: LoginScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SingupScreen.routeName: (ctx) => SingupScreen(),
        HomePage.routeName: (ctx) => HomePage(),
        CreateEditPassword.routeName: (ctx) => CreateEditPassword()
      },
    );
  }
}
