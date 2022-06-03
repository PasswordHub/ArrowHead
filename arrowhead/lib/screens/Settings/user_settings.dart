import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({Key? key}) : super(key: key);
  static const routeName = '/settings';

  @override
  _UserSettings createState() => _UserSettings();
}

class _UserSettings extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          backgroundColor: const Color.fromARGB(255, 48, 48, 48),
          title: Text(
            'Criar senha',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SettingsGroup(title: "Tela", children: <Widget>[
          SwitchSettingsTile(
            settingKey: 'key-dark-mode',
            title: 'Dark Mode',
            enabledLabel: 'Enabled',
            disabledLabel: 'Disabled',
            leading: const Icon(Icons.palette),
            onChange: (value) {
              debugPrint('jey-dark-mode: $value');
            },
          ),
        ]));
  }
}
