import 'package:flutter/material.dart';

class CreateEditPassword extends StatelessWidget {
  static const routeName = '/create_edit_password';

  const CreateEditPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar senha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Nome do site'),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                borderRadius: BorderRadius.circular(5)),
            child: const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 15, right: 25),
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                autofocus: false,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text('URL'),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 15, right: 25),
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                autofocus: false,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text('Descricao'),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 15, right: 25),
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                autofocus: false,
                maxLines: 15,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text('Senha'),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 15, right: 25),
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                autofocus: false,
              ),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: const Text('Criar senha'))
        ]),
      ),
    );
  }
}
