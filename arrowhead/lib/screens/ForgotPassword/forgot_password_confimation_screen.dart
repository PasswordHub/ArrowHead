import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordConfirmationScreen extends StatefulWidget {
  static const routeName = '/forgot-password-confirmation-screen';

  @override
  _ForgotPasswordConfirmationScreenState createState() =>
      _ForgotPasswordConfirmationScreenState();
}

class _ForgotPasswordConfirmationScreenState
    extends State<ForgotPasswordConfirmationScreen> {
  final emailController = TextEditingController();

  String invalidEmailMsg = "";
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: (() => {Navigator.of(context).pop()}),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 10),
                      const Text(
                        "Apagar sua conta",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 40),
                      RichText(
                          text: const TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 19, 19, 19),
                              ),
                              children: [
                            TextSpan(
                                text:
                                    "Digite o código de verificação enviado para o email "),
                            TextSpan(
                                text: "jorgebenjor@gmail.com:",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ])),
                      SizedBox(height: 40),
                      SizedBox(height: 10),
                      continueBtn()
                    ]))));
  }

  Widget continueBtn() => Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 5),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ))),
          onPressed: () async {
            // TODO: login logic
            // Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          },
          child: const Text(
            'Continuar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      );
}
