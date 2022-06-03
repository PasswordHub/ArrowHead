import 'package:arrowhead/models/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../Settings/user_settings.dart';
import 'home_page.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Login? currUser = Provider.of<Auth>(context, listen: false).currUser;
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(
            currUser?.name ?? '',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          accountEmail: Text(
            currUser?.email ?? '',
            style: TextStyle(),
          ),
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 48, 48, 48)),
          currentAccountPicture: Container(
            height: 46,
            width: 46,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: const Icon(
              Icons.person,
              size: 45,
              color: Colors.white,
            ),
            alignment: Alignment.center,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.lock),
          title: Text('Senhas', style: Theme.of(context).textTheme.subtitle2),
          onTap: () => Navigator.of(context).pushNamed(HomePage.routeName),
        ),
        /*ListTile(
          leading: Icon(Icons.storage_rounded),
          title: Text('Grupos de Senhas',
              style: Theme.of(context).textTheme.subtitle1),
        ),
        ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configurações',
                style: Theme.of(context).textTheme.subtitle2),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UserSettings()))),*/
        ListTile(
          onTap: () => Provider.of<Auth>(context, listen: false).logout(),
          leading: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: const Text(
            'Sair',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Colors.red, fontSize: 16),
          ),
        )
      ],
    ));
  }
}
