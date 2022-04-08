import 'package:arrowhead/screens/CreateEditPassword/create_edit_password.dart';
import 'package:arrowhead/screens/LoginSignup/login_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Senhas salvas'),
        backgroundColor: Color.fromARGB(255, 48, 48, 48),
      ),
      drawer: HomePageDrawer(),
      body: Column(
        children: [
          PasswordItem(
            text: 'Instagram',
          ),
          PasswordItem(text: 'Facebook'),
          PasswordItem(text: 'Twitter'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 48, 48, 48),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(CreateEditPassword.routeName);
        },
      ),
    );
  }
}

class PasswordItem extends StatelessWidget {
  final String text;
  const PasswordItem({Key? key, this.text = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSettings = MediaQuery.of(context).size;
    return Container(
        width: deviceSettings.width,
        child: ListTile(
          leading: const Icon(Icons.add_a_photo_rounded),
          title: Text(text),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_sharp),
            onPressed: () {},
          ),
        ));
  }
}

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 48, 48, 48)),
            child: Center(
              child: CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
                radius: 35,
              ),
            )),
        const ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          },
          leading: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: const Text(
            'logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        )
      ],
    ));
  }
}
