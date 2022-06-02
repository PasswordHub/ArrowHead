import 'package:flutter/material.dart';

class CreateEditPasswordGroup extends StatefulWidget {
  const CreateEditPasswordGroup({Key? key}) : super(key: key);

  @override
  State<CreateEditPasswordGroup> createState() =>
      _CreateEditPasswordGroupState();
}

class _CreateEditPasswordGroupState extends State<CreateEditPasswordGroup> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, dynamic> _formData = {};

  /// Save the created/edited Password and add to the
  /// Password Provider
  void _savePasswordGroup(BuildContext context) {
    if (!(_formKey.currentState?.validate() ?? false)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erro ao salvar a senha!',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }

    /* _formKey.currentState?.save();
    _formData[Password.PASSWORD_KEY] = _passwordController.text;

    if (updatePassword) {
      Provider.of<PasswordProvider>(context, listen: false).update(_formData);
    } else {
      Provider.of<PasswordProvider>(context, listen: false).add(_formData);
    }*/
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final savePasswordGroupButton = SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
          onPressed: () => _savePasswordGroup(context),
          style: ElevatedButton.styleFrom(
            primary: const Color.fromARGB(255, 13, 189, 62),
          ),
          child: Text('Criar senha',
              style: Theme.of(context).textTheme.bodyText2)),
    );
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [savePasswordGroupButton]),
          ),
        ),
      ),
    );
  }
}
