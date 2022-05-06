import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Carregando...',
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(
          height: 15,
        ),
        const Center(
          child: CircularProgressIndicator(),
        ),
      ],
    )));
  }
}
