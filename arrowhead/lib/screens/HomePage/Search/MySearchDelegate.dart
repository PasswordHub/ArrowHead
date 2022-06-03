import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../models/password.dart';
import '../../../providers/password_provider.dart';

class MySearchDelegate extends SearchDelegate<Password> {
  Password? currPassword;
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
        textTheme: const TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
        ));
    return theme;
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () => Navigator.of(context).pop());

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            if (query.isEmpty) {
              Navigator.of(context).pop();
            } else {
              query = '';
            }
          },
        ),
      ];

  @override
  Widget buildSuggestions(BuildContext context) {
    return Consumer<PasswordProvider>(builder: (context, password, child) {
      List<Password> suggestions = password.items.where((searchResult) {
        final result = searchResult.name.toLowerCase();
        final input = query.toLowerCase();
        return result.contains(input);
      }).toList();
      return password.size == 0
          ? const Center(
              child: Text(
                'Nenhuma senha encontrada',
                style: TextStyle(color: Colors.white),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ListView.builder(
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final password = suggestions[index];

                  return ListTile(
                    title: Text(
                      password.name,
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      password.description,
                      style: const TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      query = password.name;
                      currPassword = password;
                      showResults(context);
                    },
                  );
                },
              ),
            );
    });
  }

  @override
  Widget buildResults(BuildContext context) => SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Wrap(
            spacing: 20, // to apply margin in the main axis of the wrap
            runSpacing: 20,
            children: [
              Text("Nome:", style: Theme.of(context).textTheme.bodyText1),
              buildFieldWithClipboardInformation(
                  currPassword?.name ?? '', context),
              Text("Senha:", style: Theme.of(context).textTheme.bodyText1),
              buildFieldWithClipboardInformation(
                  currPassword?.name ?? '', context),
              Text("Url:", style: Theme.of(context).textTheme.bodyText1),
              buildFieldWithClipboardInformation(
                  currPassword?.name ?? '', context),
              Text("Descrição:", style: Theme.of(context).textTheme.bodyText1),
              buildFieldWithClipboardInformation(
                  currPassword?.name ?? '', context),
            ]),
      ));
}

Widget buildFieldWithClipboardInformation(String text, BuildContext context) {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 2),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 224, 224, 224),
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
        autocorrect: false,
        enableSuggestions: false,
        autofocus: false,
        readOnly: true,
        controller: TextEditingController(text: text),
        keyboardType: TextInputType.visiblePassword,
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: IconButton(
                icon: const Icon(Icons.paste),
                color: Colors.black,
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: text));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Texto copiado',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    backgroundColor: Colors.grey,
                  ));
                })),
      ));
}
