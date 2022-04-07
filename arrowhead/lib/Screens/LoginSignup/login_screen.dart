import 'package:arrowhead/Screens/home_page.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login-screen';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  Widget login(IconData icon) {
    return Container(
      height: 50,
      width: 115,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          TextButton(onPressed: () {}, child: Text('Sign up')),
        ],
      ),
    );
  }

  Widget userInput(TextEditingController userInput, TextInputType keyboardType,
      bool hideText) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade200,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextField(
          obscureText: hideText,
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          keyboardType: keyboardType,
        ),
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
                  fontFamily: 'Rajdhani',
                  fontWeight: FontWeight.bold,
                  fontSize: 50),
            )),
            const Center(
                child: Text(
              'Password Manager',
              style: TextStyle(fontFamily: 'Rajdhani', fontSize: 20),
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
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 45),
                        const Text('Email'),
                        userInput(
                            emailController, TextInputType.emailAddress, false),
                        const Text('Password'),
                        userInput(passwordController,
                            TextInputType.visiblePassword, true),
                        TextButton(
                          child: const Text(
                            'Forgot password ?',
                          ),
                          onPressed: () {
                            //TODO: forgot password logic
                          },
                        ),
                        Container(
                          height: 55,
                          padding: const EdgeInsets.only(
                              top: 5, left: 70, right: 70),
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
                              'Login',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                        Center(
                          child: login(Icons.add),
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
