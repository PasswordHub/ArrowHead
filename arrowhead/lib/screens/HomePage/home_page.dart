import 'package:arrowhead/models/password.dart';
import 'package:arrowhead/providers/password_provider.dart';
import 'package:arrowhead/screens/CreateEditPassword/create_edit_password.dart';
import 'package:arrowhead/screens/HomePage/drawer.dart';
import 'package:arrowhead/screens/HomePage/password_information.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'Search/MySearchDelegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Senhas salvas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 48, 48, 48),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search',
            color: Colors.white,
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(),
              );
            },
          ),
        ],
      ),
      drawer: const HomePageDrawer(),
      body: FutureBuilder(
          future:
              Provider.of<PasswordProvider>(context, listen: false).fetchData(),
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : buildScaffold(context)),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 48, 48, 48),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(CreateEditPassword.routeName);
        },
      ),
    );
  }

  Widget buildScaffold(BuildContext context) {
    return Consumer<PasswordProvider>(
        builder: (context, passwords, _) => passwords.size == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/emptybox.png',
                      scale: 1.5,
                    ),
                    Text(
                      'Nenhuma senha adicionada',
                      style:
                          TextStyle(color: Color.fromARGB(255, 153, 153, 153)),
                    ),
                  ],
                ),
              )
            : (ListView.builder(
                itemCount: passwords.size,
                itemBuilder: (context, index) {
                  return buildPassword(passwords.items[index], context);
                },
              )));
  }

  _delete(BuildContext context, Password password) => showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Deseja Continuar?'),
          content: Text(
              'Tem certeza que deseja remover a senha "${password.name}"?'),
          backgroundColor: Colors.white,
          actions: [
            // The "Yes" button
            TextButton(
                onPressed: () {
                  // Remove the password
                  Provider.of<PasswordProvider>(context, listen: false)
                      .remove(password.toJson);
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: const Text('Sim',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold))),
            TextButton(
                onPressed: () {
                  // Close the dialog
                  Navigator.of(context).pop();
                },
                child: const Text('Não',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)))
          ],
        );
      });

  _showPasswordInfo(Password password) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (context) => PasswordInfo(password: password)));
  }

  _editPassword(Password password) {
    Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (context) => CreateEditPassword(password: password)));
  }

  Widget buildPassword(Password password, BuildContext context) => ListTile(
        onTap: () => _showPasswordInfo(password),
        onLongPress: () async =>
            await Clipboard.setData(ClipboardData(text: password.password)),
        title: Text(password.name),
        subtitle: Text(password.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.blueGrey,
              ),
              onPressed: () => _editPassword(password),
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () => _delete(context, password),
            )
          ],
        ),
      );
}
