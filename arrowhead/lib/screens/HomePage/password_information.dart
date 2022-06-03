import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/password.dart';

class PasswordInfo extends StatelessWidget {
  static const routeName = '/password-info';

  final Password? password;
  const PasswordInfo({Key? key, this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            password?.name ?? '',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
                spacing: 20, // to apply margin in the main axis of the wrap
                runSpacing: 20,
                children: [
                  Text("Nome:", style: Theme.of(context).textTheme.bodyText1),
                  buildFieldWithClipboardInformation(
                      password?.name ?? '', context),
                  Text("Senha:", style: Theme.of(context).textTheme.bodyText1),
                  buildFieldWithClipboardInformation(
                      password?.password ?? '', context),
                  Text("Url:", style: Theme.of(context).textTheme.bodyText1),
                  buildFieldWithClipboardInformation(
                      password?.url ?? '', context),
                  Text("Descrição:",
                      style: Theme.of(context).textTheme.bodyText1),
                  buildFieldWithClipboardInformation(
                      password?.description ?? '', context),
                ]),
          ),
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
}
