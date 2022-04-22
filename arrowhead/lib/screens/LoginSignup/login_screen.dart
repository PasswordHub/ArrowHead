import 'package:arrowhead/screens/HomePage/home_page.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screen';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

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
              onPressed: () {},
              child: const Text(
                'Criar conta',
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }

  Widget userInput(TextEditingController userInput, TextInputType keyboardType,
      bool hideText, String hintTxt) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 2),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 224, 224, 224),
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        obscureText: hideText,
        controller: userInput,
        autocorrect: false,
        enableSuggestions: false,
        autofocus: false,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            hintText: hintTxt,
            hintStyle: const TextStyle(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
            border: InputBorder.none),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                        userInput(emailController, TextInputType.emailAddress,
                            false, 'Digite seu email'),
                        const SizedBox(height: 20),
                        const Text(
                          'Senha mestre',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Arial',
                              fontSize: 12),
                        ),
                        userInput(
                            passwordController,
                            TextInputType.visiblePassword,
                            true,
                            "Digite sua senha mestre"),
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
                        Container(
                          height: 50,
                          padding: const EdgeInsets.only(top: 5),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 13, 189, 62)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ))),
                            onPressed: () async {
                              //TODO: login logic
                              Navigator.of(context)
                                  .pushReplacementNamed(HomePage.routeName);
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
                        ),
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
}
