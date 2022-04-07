import 'package:arrowhead/Screens/CreateEditPassword/create_edit_password.dart';
import 'package:arrowhead/Screens/HomePage/home_page.dart';
import 'package:flutter/material.dart';
import 'Screens/LoginSignup/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ArrowHead',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        HomePage.routeName: (ctx) => HomePage(),
        CreateEditPassword.routeName: (ctx) => CreateEditPassword()
      },
    );
  }
}
