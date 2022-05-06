import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgot-password-screen';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                      SizedBox(height: 20),
                      const Text(
                        "Esqueceu a senha?",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      RichText(
                          text: const TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 19, 19, 19),
                              ),
                              children: [
                            TextSpan(
                                text:
                                    "Infelizmente, por questões de segurança, sua senha "),
                            TextSpan(
                                text: "não pode ser recuperada. ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text:
                                    "Nós criptografamos seus dados utilizando sua senha mestre, portanto ela não pode ser alterada."),
                          ])),
                      SizedBox(
                        height: 15,
                      ),
                      RichText(
                          text: const TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 19, 19, 19),
                              ),
                              children: [
                            TextSpan(
                                text:
                                    "Se você quer criar outra conta ou acha que sua senha caiu em mãos erradas, uma opção é "),
                            TextSpan(
                                text: "apagar sua conta: ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ])),
                      SizedBox(height: 40),
                      emailInput(emailController, "Confirme seu e-mail"),
                      SizedBox(height: 10),
                      deleteBtn()
                    ]))));
  }

  Widget emailInput(TextEditingController controller, String title) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.black, fontFamily: 'Arial', fontSize: 12),
          ),
          SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 2),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 224, 224, 224),
                border: Border.all(
                    color: (invalidEmailMsg != "")
                        ? Colors.red
                        : Colors.transparent),
                borderRadius: BorderRadius.circular(15)),
            child: TextField(
              controller: controller,
              autocorrect: false,
              enableSuggestions: true,
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: "Digite seu e-mail",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  border: InputBorder.none),
              onChanged: ((value) => {
                    setState(() {
                      invalidEmailMsg =
                          EmailValidator.validate(value) || value.isEmpty
                              ? ""
                              : "Digite um e-mail válido";
                    })
                  }),
            ),
          )
        ]);
  }

  Widget deleteBtn() => Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 5),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ))),
          onPressed: () async {
            // TODO: login logic
            // Navigator.of(context).pushReplacementNamed(HomePage.routeName);
          },
          child: const Text(
            'Apagar sua conta',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      );
}
