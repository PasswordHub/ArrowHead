import 'package:flutter/material.dart';

class PasswordDialogConfig extends StatefulWidget {
  const PasswordDialogConfig({Key? key}) : super(key: key);

  @override
  State<PasswordDialogConfig> createState() => _PasswordDialogConfigState();
}

class _PasswordDialogConfigState extends State<PasswordDialogConfig> {
  final special_character_key = 'has_special_character';
  final numbers_key = 'has_numbers';
  final uppercase_key = 'has_uppercase';
  final number_of_characters_key = 'number_of_characters';
  var passwordProperties = {};

  @override
  void initState() {
    passwordProperties = {
      special_character_key: true,
      numbers_key: true,
      uppercase_key: true,
      number_of_characters_key: 12.0
    };
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
                  value: passwordProperties[special_character_key],
                  onChanged: (value) {
                    setState(() {
                      passwordProperties[special_character_key] = value;
                    });
                  },
                  title: Text("Caracteres Especiais"),
                ),
                CheckboxListTile(
                  value: passwordProperties[numbers_key],
                  onChanged: (value) {
                    setState(() {
                      passwordProperties[numbers_key] = value;
                    });
                  },
                  title: Text("Números"),
                ),
                CheckboxListTile(
                  value: passwordProperties[uppercase_key],
                  onChanged: (value) {
                    setState(() {
                      passwordProperties[uppercase_key] = value;
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
                  label: "${passwordProperties[number_of_characters_key]}",
                  divisions: 30 - 12,
                  value:
                      passwordProperties[number_of_characters_key].toDouble(),
                  onChanged: (value) {
                    var newValue = value.toInt();
                    setState(() {
                      passwordProperties[number_of_characters_key] = newValue;
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
