import 'package:arrowhead/models/login.dart';
import 'package:arrowhead/screens/HomePage/home_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class SingupScreen extends StatefulWidget {
  static const routeName = '/signup-screen';

  const SingupScreen({Key? key}) : super(key: key);

  @override
  _SingupScreenState createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String invalidEmailMsg = "";
  bool showPassword = false;
  bool isLoading = false;

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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Criar conta",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              userInput(nameController, "Nome completo",
                  "Digite seu nome completo", TextInputType.name),
              const SizedBox(height: 20),
              emailInput(emailController, "E-mail"),
              const SizedBox(height: 5),
              (invalidEmailMsg != "")
                  ? Text(invalidEmailMsg,
                      style: const TextStyle(
                          color: Colors.red, fontFamily: 'Arial', fontSize: 11))
                  : const SizedBox(),
              const SizedBox(height: 20),
              userInput(phoneController, "Telefone",
                  "Digite seu número de telefone", TextInputType.number),
              const SizedBox(height: 20),
              passwordInput(passwordController, "Senha mestre"),
              const SizedBox(height: 10),
              Padding(
                  padding: EdgeInsets.all(5),
                  child: RichText(
                      text: const TextSpan(
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 19, 19, 19),
                          ),
                          children: [
                        TextSpan(
                            text:
                                "A sua senha mestre será responsável pelo seu login e pela criptografia dos dados. É importante não esquecer ou perder sua senha, pois "),
                        TextSpan(
                            text: "não é possível recuperá-la.",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ]))),
              const SizedBox(height: 20),
              passwordInput(
                  confirmPasswordController, "Confirmar senha mestre"),
              const SizedBox(height: 40),
              signUpBtn()
            ]),
      )),
    );
  }

  Widget signUpBtn() => Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 5),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 13, 189, 62)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ))),
          child: !isLoading
              ? const Text(
                  'Finalizar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(
                  width: 23,
                  height: 23,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
          onPressed: () async {
            try {
              setState(() {
                isLoading = true;
              });

              Provider.of<Auth>(context, listen: false)
                  .signUp({
                    Login.EMAIL_KEY: emailController.text,
                    Login.PASSWORD_KEY: passwordController.text,
                    Login.NAME_KEY: nameController.text
                  })
                  .then((value) => {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Conta criada com sucesso!",
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        setState(() {
                          isLoading = true;
                        }),
                        Navigator.of(context)
                            .pushReplacementNamed(HomePage.routeName)
                      })
                  .catchError((error) => {
                        setState(() {
                          isLoading = false;
                        }),
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Erro! Informações inválidas \n" +
                                  error.toString(),
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                          ),
                        ),
                      });
            } on PlatformException catch (error) {
              var message =
                  'Um erro ocorreu, por favor confira usas credenciais';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    message,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
              setState(() {
                isLoading = false;
              });
            } catch (error) {
              var message = 'Erro interno.';
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    message,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
              setState(() {
                isLoading = false;
              });
            }
          },
        ),
      );

  Widget userInput(TextEditingController controller, String title, String hint,
      TextInputType keyboard) {
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
                borderRadius: BorderRadius.circular(15)),
            child: TextField(
              controller: controller,
              autocorrect: false,
              enableSuggestions: true,
              autofocus: false,
              keyboardType: keyboard,
              decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  border: InputBorder.none),
            ),
          )
        ]);
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

  Widget passwordInput(TextEditingController controller, String title) {
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
                borderRadius: BorderRadius.circular(15)),
            child: TextField(
              obscureText: !showPassword,
              controller: controller,
              autocorrect: false,
              enableSuggestions: false,
              autofocus: false,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                hintText: "Digite sua senha mestre",
                hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                border: InputBorder.none,
                suffixIcon: IconButton(
                    onPressed: (() {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    }),
                    color: Colors.black,
                    icon: Icon(((showPassword)
                        ? Icons.visibility
                        : Icons.visibility_off))),
              ),
            ),
          )
        ]);
  }
}
