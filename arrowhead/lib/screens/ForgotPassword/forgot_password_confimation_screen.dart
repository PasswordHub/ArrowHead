import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class ForgotPasswordConfirmationScreen extends StatefulWidget {
  static const routeName = '/forgot-password-confirmation-screen';

  final String? email;

  const ForgotPasswordConfirmationScreen({Key? key, this.email})
      : super(key: key);

  @override
  _ForgotPasswordConfirmationScreenState createState() =>
      _ForgotPasswordConfirmationScreenState();
}

class _ForgotPasswordConfirmationScreenState
    extends State<ForgotPasswordConfirmationScreen> {
  final emailController = TextEditingController();

  String invalidEmailMsg = "";
  bool showPassword = false;
  String? userEmail = "";

  String code = "";

  @override
  void initState() {
    if (widget.email != null) {
      userEmail = widget.email;
    }
    super.initState();
  }

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
                          text: TextSpan(
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 19, 19, 19),
                              ),
                              children: [
                            const TextSpan(
                                text:
                                    "Digite o código de verificação enviado para o email "),
                            TextSpan(
                                text: userEmail,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ])),
                      SizedBox(height: 40),
                      Center(
                        child: VerificationCode(
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Theme.of(context).primaryColor),
                          keyboardType: TextInputType.number,
                          // underlineColor: Colors.blue
                          length: 4,
                          cursorColor: Colors.blue,
                          onCompleted: (String value) {
                            setState(() {
                              code = value;
                            });
                          },
                          onEditing: (bool value) {
                            setState(() {
                              // _onEditing = value;
                            });
                            // if (!_onEditing) FocusScope.of(context).unfocus();
                          },
                        ),
                      ),
                      SizedBox(height: 40),
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
            print(code);
            if (code.length != 4) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Código inválido!',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext ctx) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Text('Confirmação'),
                      content: const Text(
                          'Você confirma que deseja APAGAR a sua conta? Essa é uma ação irreversível!'),
                      actions: [
                        // The "Yes" button
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Sim',
                              style: TextStyle(color: Colors.red),
                            )),
                        TextButton(
                            onPressed: () {
                              // Close the dialog
                              Navigator.of(context).pop();
                            },
                            child: const Text('Não',
                                style: TextStyle(color: Colors.black)))
                      ],
                    );
                  });
            }
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
