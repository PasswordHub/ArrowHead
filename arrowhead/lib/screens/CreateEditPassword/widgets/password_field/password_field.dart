import 'dart:math';

import 'package:arrowhead/screens/CreateEditPassword/widgets/password_config.dart';
import 'package:flutter/material.dart';

import '../check_list_tile.dart';
import '../my_text_field.dart';

class PasswordTextField extends StatefulWidget {
  static const CHARACTERS_KEY = "characters";
  static const UPPERCASE_CHARACTERS_KEY = "upperCaseCharacters";
  static const SPECIAL_CHARACTERS_KEY = "specialCharacters";
  static const NUMBERS_KEY = "numbers";

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
  Map<String, bool> _passwordStrenght = {};
  Map<String, dynamic> _passwordSettings = {};
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
            text: 'Mínimo de 12 caracteres',
            isCheck:
                _passwordStrenght[PasswordTextField.CHARACTERS_KEY] ?? false),
        CheckListTile(
            text: 'Ao menos 1 letra maiúscula',
            isCheck:
                _passwordStrenght[PasswordTextField.UPPERCASE_CHARACTERS_KEY] ??
                    false),
        CheckListTile(
            text: 'Ao menos 3 caracteres especiais',
            isCheck:
                _passwordStrenght[PasswordTextField.SPECIAL_CHARACTERS_KEY] ??
                    false),
        CheckListTile(
            text: 'Ao menos 3 números',
            isCheck: _passwordStrenght[PasswordTextField.NUMBERS_KEY] ?? false),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: const Icon(Icons.settings),
          minLeadingWidth: 5,
          title: const Text('Editar configurações de senha'),
          onTap: () async {
            final _passwordSettings = await showDialog<Map<String, dynamic>>(
                context: context,
                builder: (context) {
                  return const PasswordDialogConfig();
                });

            this._passwordSettings = _passwordSettings ?? {};

            _generateStrongPassword();
          },
        )
      ],
    );
  }

  _generateStrongPassword() {
    int passwordLength = _passwordSettings[PasswordTextField.CHARACTERS_KEY];
    String _password = "";

    String _lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
    String _upperCaseLetters = _lowerCaseLetters.toUpperCase();
    String _numbers = "0123456789";
    String _special = "@#=+!£\$%&?[](){}";
    String _allowedChars = "";

    _allowedChars += _lowerCaseLetters;
    if (_passwordSettings[PasswordTextField.UPPERCASE_CHARACTERS_KEY]) {
      _allowedChars += _upperCaseLetters;
    }
    if (_passwordSettings[PasswordTextField.NUMBERS_KEY]) {
      _allowedChars += _numbers;
    }
    if (_passwordSettings[PasswordTextField.SPECIAL_CHARACTERS_KEY]) {
      _allowedChars += _special;
    }

    while (!_passwordStrenght.values.contains(false)) {
      _password = "";
      for (int i = 0; i < passwordLength.round(); i++) {
        int randomInt = Random.secure().nextInt(_allowedChars.length);
        _password += _allowedChars[randomInt];
      }
      _updateCurrentPasswordStrenght(_password);
    }

    widget.passwordChange(_password);

    _onPasswordChange(_password);
  }

  _onPasswordChange(String? value) {
    if (value == null) {
      return;
    }
    _updateCurrentPasswordStrenght(value);
  }

  _updateCurrentPasswordStrenght(String password) {
    setState(() {
      _passwordStrenght[PasswordTextField.CHARACTERS_KEY] =
          password.length >= 12;
      _passwordStrenght[PasswordTextField.UPPERCASE_CHARACTERS_KEY] =
          password.contains(RegExp(r'[A-Z]'));

      _passwordStrenght[PasswordTextField.SPECIAL_CHARACTERS_KEY] =
          password.split(RegExp(r'[!@#$*%&]')).length > 3;
      _passwordStrenght[PasswordTextField.NUMBERS_KEY] =
          password.split(RegExp(r'[0-9]')).length > 3;
    });
  }

  String? _validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'O campo senha não pode estar vazio';
    }

    if (_passwordStrenght.values.contains(false)) {
      return 'A sua senha não está segura';
    }

    return null;
  }
}
