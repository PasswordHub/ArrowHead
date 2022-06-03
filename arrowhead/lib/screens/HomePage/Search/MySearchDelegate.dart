import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/password.dart';
import '../../../providers/password_provider.dart';

class MySearchDelegate extends SearchDelegate<Password> {
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
                      showResults(context);
                    },
                  );
                },
              ),
            );
    });
  }

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
        ),
      );
}
