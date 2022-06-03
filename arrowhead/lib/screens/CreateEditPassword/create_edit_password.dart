import 'package:arrowhead/providers/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/password.dart';
import 'widgets/my_text_field.dart';
import 'widgets/password_field/password_field.dart';

class CreateEditPassword extends StatefulWidget {
  static const routeName = '/create_edit_password';

  final Password? password;

  const CreateEditPassword({Key? key, this.password}) : super(key: key);

  @override
  State<CreateEditPassword> createState() => _CreateEditPasswordState();
}

class _CreateEditPasswordState extends State<CreateEditPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, dynamic> _formData = {};
  final TextEditingController _passwordController = TextEditingController();
  bool updatePassword = false;
  bool isLoading = false;

  @override
  void initState() {
    if (widget.password != null) {
      _passwordController.text = widget.password?.password ?? "";
      _formData.addAll(widget.password?.toJson ?? {});
    }

    super.initState();
  }

  /// Save the created/edited Password and add to the
  /// Password Provider
  void _savePassword(BuildContext context) {
    setState(() {
      isLoading = true;
    });
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
      setState(() {
        isLoading = false;
      });
    } else {
      _formKey.currentState?.save();
      _formData[Password.PASSWORD_KEY] = _passwordController.text;

      if (updatePassword) {
        Provider.of<PasswordProvider>(context, listen: false)
            .update(_formData)
            .then((value) => {
                  setState(() {
                    isLoading = false;
                  }),
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Senha alterada com sucesso!',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      backgroundColor: Colors.green,
                    ),
                  ),
                  Navigator.of(context).pop()
                })
            .catchError((error) => {
                  setState(() {
                    isLoading = false;
                  }),
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Erro ao alterar senha.\n' + error.toString(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      backgroundColor: Colors.green,
                    ),
                  )
                });
      } else {
        Provider.of<PasswordProvider>(context, listen: false)
            .add(_formData)
            .then((value) => {
                  setState(() {
                    isLoading = false;
                  }),
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Senha criada com sucesso!',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      backgroundColor: Colors.green,
                    ),
                  ),
                  Navigator.of(context).pop()
                })
            .catchError((error) => {
                  setState(() {
                    isLoading = false;
                  }),
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Erro ao criar senha.\n' + error.toString(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      backgroundColor: const Color.fromARGB(255, 13, 189, 62),
                    ),
                  )
                });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final savePasswordButton = SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: () => _savePassword(context),
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(255, 13, 189, 62),
        ),
        child: !isLoading
            ? Text(
                'Criar senha',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              )
            : const SizedBox(
                width: 23,
                height: 23,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Criar senha',
          style: TextStyle(color: Colors.white),
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
                  'Nome do site',
                  _formData[Password.NAME_KEY] ?? '',
                  _onSavePasswordName,
                  _validatePasswordName,
                  inputType: TextInputType.name),
              ...passwordInfoTextField('URL', _formData[Password.URL_KEY] ?? '',
                  _onSavePasswordUrl, _validatePasswordUrl,
                  inputType: TextInputType.url),
              ...passwordInfoTextField(
                  'Descrição (opcional)',
                  _formData[Password.DESCRIPTION_KEY] ?? '',
                  _onSavePasswordDescription,
                  null,
                  inputType: TextInputType.multiline),
              PasswordTextField(
                passwordController: _passwordController,
                onSaved: _onSavePassword,
                passwordChange: _onSavePassword,
              ),
              const SizedBox(
                height: 20,
              ),
              savePasswordButton
            ]),
          ),
        ),
      ),
    );
  }

  List<Widget> passwordInfoTextField(String text, String initialValue,
      Function(String?) onSaved, String? Function(String?)? validator,
      {TextInputType inputType = TextInputType.none}) {
    return [
      Text(text, style: Theme.of(context).textTheme.bodyText1),
      MyTextField(
        initialValue: initialValue,
        keyboardType: inputType,
        validator: validator,
        onSaved: onSaved,
      ),
      const SizedBox(height: 10)
    ];
  }

  _onSavePasswordName(String? value) {
    if (value == null) {
      return;
    }

    _formData[Password.NAME_KEY] = value;
  }

  _onSavePasswordUrl(String? value) {
    if (value == null) {
      return;
    }

    _formData[Password.URL_KEY] = value;
  }

  _onSavePasswordDescription(String? value) {
    if (value == null) {
      return;
    }

    _formData[Password.DESCRIPTION_KEY] = value;
  }

  _onSavePassword(String? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _passwordController.text = value;
    });
  }

  String? _validatePasswordUrl(String? url) {
    if (url == null || url.isEmpty) {
      return 'O campo URL não pode estar vazio';
    }

    if (!Uri.parse(url).isAbsolute) {
      return 'Por favor, insira uma URL válida';
    }

    return null;
  }

  String? _validatePasswordName(String? name) {
    if (name == null || name.isEmpty) {
      return 'O campo nome não pode estar vazio';
    }
    return null;
  }
}
