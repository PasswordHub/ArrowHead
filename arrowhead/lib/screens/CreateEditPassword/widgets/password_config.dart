import 'package:arrowhead/screens/CreateEditPassword/widgets/password_field/password_field.dart';
import 'package:flutter/material.dart';

class PasswordDialogConfig extends StatefulWidget {
  final Map<String, dynamic> _passwordProperties;
  const PasswordDialogConfig(this._passwordProperties, {Key? key})
      : super(key: key);

  @override
  State<PasswordDialogConfig> createState() => _PasswordDialogConfigState();
}

class _PasswordDialogConfigState extends State<PasswordDialogConfig> {
  final Map<String, dynamic> passwordProperties = {};

  @override
  void initState() {
    passwordProperties.addAll(widget._passwordProperties);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white),
          width: deviceSize.width * 0.7,
          height: deviceSize.height * 0.53,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Gerador de Senhas',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                CheckboxListTile(
                  value: passwordProperties[
                      PasswordTextField.SPECIAL_CHARACTERS_KEY],
                  onChanged: (value) {
                    setState(() {
                      passwordProperties[
                          PasswordTextField.SPECIAL_CHARACTERS_KEY] = value;
                    });
                  },
                  title: Text("Caracteres Especiais"),
                ),
                CheckboxListTile(
                  value: passwordProperties[PasswordTextField.NUMBERS_KEY],
                  onChanged: (value) {
                    setState(() {
                      passwordProperties[PasswordTextField.NUMBERS_KEY] = value;
                    });
                  },
                  title: Text("Números"),
                ),
                CheckboxListTile(
                  value: passwordProperties[
                      PasswordTextField.UPPERCASE_CHARACTERS_KEY],
                  onChanged: (value) {
                    setState(() {
                      passwordProperties[
                          PasswordTextField.UPPERCASE_CHARACTERS_KEY] = value;
                    });
                  },
                  title: Text("Maiúsculos"),
                ),
                Text(
                  "N° de caracteres",
                  style: TextStyle(color: Colors.black),
                ),
                Slider(
                  min: 12,
                  max: 30,
                  label:
                      "${passwordProperties[PasswordTextField.CHARACTERS_KEY]}",
                  divisions: 30 - 12,
                  value: passwordProperties[PasswordTextField.CHARACTERS_KEY]
                      .toDouble(),
                  onChanged: (value) {
                    var newValue = value.toInt();
                    setState(() {
                      passwordProperties[PasswordTextField.CHARACTERS_KEY] =
                          newValue;
                    });
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 13, 189, 62)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ))),
                      onPressed: () {
                        Navigator.of(context).pop(passwordProperties);
                      },
                      child: Text("Salvar",
                          style: TextStyle(color: Colors.black))),
                )
              ],
            ),
          )),
    );
  }
}
