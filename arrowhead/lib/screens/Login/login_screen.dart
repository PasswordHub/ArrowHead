import 'package:arrowhead/screens/ForgotPassword/forgot_password_screen.dart';
import 'package:arrowhead/screens/HomePage/home_page.dart';
import 'package:arrowhead/screens/SignUp/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

import '../../models/login.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String invalidEmailMsg = "";
  bool showPassword = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(5.0),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            fullLogo(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 510,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 45),
                        const Text(
                          'E-mail',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Arial',
                              fontSize: 12),
                        ),
                        emailInput(emailController),
                        Text(
                          invalidEmailMsg,
                          style: const TextStyle(
                              color: Colors.red,
                              fontFamily: 'Arial',
                              fontSize: 11),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Senha mestre',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Arial',
                              fontSize: 12),
                        ),
                        passwordInput(passwordController),
                        TextButton(
                          style: const ButtonStyle(
                              alignment: Alignment.centerRight),
                          child: const Text(
                            'Esqueceu a senha?',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(ForgotPasswordScreen.routeName);
                          },
                        ),
                        loginBtn(context),
                        const SizedBox(height: 60),
                        Center(
                          child: signInBtn(Icons.add),
                        ),
                        const Divider(thickness: 0, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget loginBtn(BuildContext context) => Container(
        height: 50,
        padding: const EdgeInsets.only(top: 5),
        child: isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 13, 189, 62)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ))),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Por favor, preencha os campos de email e senha',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );

                    setState(() {
                      isLoading = false;
                    });
                  }

                  try {
                    Provider.of<Auth>(context, listen: false).signIn({
                      Login.EMAIL_KEY: emailController.text,
                      Login.PASSWORD_KEY: passwordController.text
                    });
                  } catch (error) {
                    showDialog(
                        context: context,
                        builder: (ctx) => const FittedBox(
                              child: AlertDialog(
                                title: Text('Um erro ocorreu'),
                                content:
                                    Text('A senha inserida está incorreta'),
                              ),
                            ));
                    setState(() {
                      isLoading = false;
                    });
                  }

                  setState(() {
                    isLoading = false;
                  });
                },
                child: const Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
      );

  /// Botão para a página de cadastro
  Widget signInBtn(IconData icon) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 190, 190, 190).withOpacity(0.4),
            width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon, size: 24),
            const SizedBox(width: 10),
            const Text(
              'Cadastrar',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )
          ]),
          onPressed: () {
            Navigator.of(context).pushNamed(SingupScreen.routeName);
          }),
    );
  }

  Widget emailInput(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 2),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 224, 224, 224),
          border: Border.all(
              color: (invalidEmailMsg != "") ? Colors.red : Colors.transparent),
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
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
            border: InputBorder.none),
        onChanged: ((value) => {
              setState(() {
                invalidEmailMsg = EmailValidator.validate(value)
                    ? ""
                    : "Digite um e-mail válido";
              })
            }),
      ),
    );
  }

  Widget passwordInput(TextEditingController controller) {
    return Container(
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
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
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
          )),
    );
  }

  /// Título e logo do app
  Widget fullLogo() => Column(children: [
        const SizedBox(
          height: 40,
        ),
        Image.asset(
          'assets/images/arrow.png',
          scale: 2,
        ),
        const Center(
            child: Text(
          'Arrow Head',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Rajdhani',
              fontWeight: FontWeight.bold,
              fontSize: 50),
        )),
        const Center(
            child: Text(
          'Password Manager',
          style: TextStyle(
              color: Colors.black, fontFamily: 'Rajdhani', fontSize: 20),
        )),
      ]);
}
