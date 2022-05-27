import 'dart:math';

import 'package:arrowhead/screens/CreateEditPassword/widgets/password_config.dart';
import 'package:flutter/material.dart';

import '../check_list_tile.dart';
import '../my_text_field.dart';

class PasswordTextField extends StatefulWidget {
  final Function(String?) onSaved;
  final Function(String?) passwordChange;
  final TextEditingController passwordController;
  const PasswordTextField(
      {Key? key,
      required this.passwordController,
      required this.onSaved,
      required this.passwordChange})
      : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final Map<String, bool> _passwordChecks = {};
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Senha', style: Theme.of(context).textTheme.bodyText1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: MyTextField(
              textController: widget.passwordController,
              onSaved: widget.onSaved,
              onChanged: _onPasswordChange,
              validator: _validatePassword,
            )),
            SizedBox(
              width: deviceSize.width * 0.10,
              child: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _generateStrongPassword,
              ),
            )
          ],
        ),
        CheckListTile(
            text: 'Mínimo 12 caracteres',
            isCheck: _passwordChecks['12characters'] ?? false),
        CheckListTile(
            text: 'Ao menos 1 letra maiúscula',
            isCheck: _passwordChecks['1upperCaseCharacter'] ?? false),
        CheckListTile(
            text: 'Ao menos 3 caracteres especiais',
            isCheck: _passwordChecks['3specialCharacters'] ?? false),
        CheckListTile(
            text: 'Ao menos 3 números',
            isCheck: _passwordChecks['3numbers'] ?? false),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: const Icon(Icons.settings),
          minLeadingWidth: 5,
          title: const Text('Editar configurações de senha'),
          onTap: () async {
            final password_data = await showDialog(
                context: context,
                builder: (context) {
                  return PasswordDialogConfig();
                });

            print(password_data);
          },
        )
      ],
    );
  }

  _generateStrongPassword() {
    int passwordLength = 30;

    String _lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
    String _upperCaseLetters = _lowerCaseLetters.toUpperCase();
    String _numbers = "0123456789";
    String _special = "@#=+!£\$%&?[](){}";
    String _allowedChars = "";
    _allowedChars += _lowerCaseLetters;
    _allowedChars += _upperCaseLetters;
    _allowedChars += _numbers;
    _allowedChars += _special;

    int i = 0;
    String _result = "";
    while (i < passwordLength.round()) {
      int randomInt = Random.secure().nextInt(_allowedChars.length);
      _result += _allowedChars[randomInt];
      i++;
    }
    widget.passwordChange(_result);

    _onPasswordChange(_result);
  }

  _onPasswordChange(String? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _passwordChecks['12characters'] = value.length >= 12;
      _passwordChecks['1upperCaseCharacter'] = value.contains(RegExp(r'[A-Z]'));

      _passwordChecks['3specialCharacters'] =
          value.split(RegExp(r'[!@#$*%&]')).length > 3;
      _passwordChecks['3numbers'] = value.split(RegExp(r'[0-9]')).length > 3;
    });
  }

  String? _validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'O campo senha não pode estar vazio';
    }

    if (_passwordChecks.values.contains(false)) {
      return 'A sua senha não está segura';
    }

    return null;
  }
}
