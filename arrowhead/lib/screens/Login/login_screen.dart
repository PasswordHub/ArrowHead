import 'package:arrowhead/providers/theme_provider.dart';
import 'package:arrowhead/screens/HomePage/home_page.dart';
import 'package:arrowhead/screens/SignUp/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String invalidEmailMsg = "";
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
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
                              fontSize: 10),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Senha mestre',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Arial',
                              fontSize: 12),
                        ),
                        passwordInput(passwordController),
                        TextButton(
                          style: ButtonStyle(alignment: Alignment.centerRight),
                          child: const Text(
                            'Esqueceu a senha?',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          onPressed: () {
                            //TODO: forgot password logic
                          },
                        ),
                        loginBtn(),
                        const SizedBox(height: 60),
                        Center(
                          child: signInBtn(Icons.add),
                        ),
                        Divider(thickness: 0, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget loginBtn() => Container(
        height: 50,
        padding: const EdgeInsets.only(top: 5),
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 13, 189, 62)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ))),
          onPressed: () async {
            //TODO: login logic
            Navigator.of(context).pushReplacementNamed(HomePage.routeName);
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
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 190, 190, 190).withOpacity(0.4),
            width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SingupScreen.routeName);
              },
              child: const Text(
                'Criar conta',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              )),
        ],
      ),
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
                icon: Icon(
                    ((showPassword) ? Icons.remove_red_eye : Icons.password))),
          )),
    );
  }

  /// Título e logo do app
  Widget fullLogo() => Column(children: [
        const SizedBox(
          height: 100,
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
