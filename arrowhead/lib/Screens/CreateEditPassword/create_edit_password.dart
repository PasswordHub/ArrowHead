import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEditPassword extends StatelessWidget {
  static const routeName = '/create_edit_password';
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Criar senha'),
        backgroundColor: Color.fromARGB(255, 48, 48, 48),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Nome do site'),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                borderRadius: BorderRadius.circular(5)),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                autofocus: false,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('URL'),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                autofocus: false,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('Descricao'),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                autofocus: false,
                maxLines: 15,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('Senha'),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                autofocus: false,
              ),
            ),
          ),
          ElevatedButton(onPressed: () {}, child: Text('Criar senha'))
        ]),
      ),
    );
  }
}
