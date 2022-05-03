import 'package:flutter/material.dart';

import 'widgets/my_text_field.dart';
import 'widgets/password_field/password_field.dart';

class CreateEditPassword extends StatefulWidget {
  static const routeName = '/create_edit_password';

  const CreateEditPassword({Key? key}) : super(key: key);

  @override
  State<CreateEditPassword> createState() => _CreateEditPasswordState();
}

class _CreateEditPasswordState extends State<CreateEditPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _formData = {};
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final savePasswordButton = SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 13, 189, 62),
          ),
          child: Text('Criar senha',
              style: Theme.of(context).textTheme.bodyText2)),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Criar senha',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ...passwordInfoTextField(
                  'Nome do site', _formData['name'] ?? '', _onSavePasswordName),
              ...passwordInfoTextField(
                  'URL', _formData['url'] ?? '', _onSavePasswordUrl),
              ...passwordInfoTextField('Descrição',
                  _formData['description'] ?? '', _onSavePasswordDescription,
                  inputType: TextInputType.multiline),
              PasswordTextField(
                passwordController: _passwordController,
                onSaved: _onSavePassword,
                passwordChange: _onSavePassword,
              ),
              savePasswordButton
            ]),
          ),
        ),
      ),
    );
  }

  List<Widget> passwordInfoTextField(
      String text, String initialValue, Function(String?) onSaved,
      {TextInputType inputType = TextInputType.none}) {
    return [
      Text(text, style: Theme.of(context).textTheme.bodyText1),
      MyTextField(
        initialValue: initialValue,
        keyboardType: inputType,
        onSaved: onSaved,
      ),
      const SizedBox(height: 10)
    ];
  }

  _onSavePasswordName(String? value) {
    if (value == null) {
      return;
    }

    _formData['name'] = value;
  }

  _onSavePasswordUrl(String? value) {
    if (value == null) {
      return;
    }

    _formData['name'] = value;
  }

  _onSavePasswordDescription(String? value) {
    if (value == null) {
      return;
    }

    _formData['name'] = value;
  }

  _onSavePassword(String? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _passwordController.text = value;
    });
  }
}
