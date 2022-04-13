import 'widgets/my_text_field.dart';
import 'package:flutter/material.dart';

class CreateEditPassword extends StatefulWidget {
  static const routeName = '/create_edit_password';

  const CreateEditPassword({Key? key}) : super(key: key);

  @override
  State<CreateEditPassword> createState() => _CreateEditPasswordState();
}

class _CreateEditPasswordState extends State<CreateEditPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    //final deviceSize = MediaQuery.of(context).size;
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
              Text('Nome do site',
                  style: Theme.of(context).textTheme.bodyText1),
              MyTextField(),
              const SizedBox(height: 10),
              Text('URL', style: Theme.of(context).textTheme.bodyText1),
              MyTextField(),
              const SizedBox(height: 10),
              Text('Descricao', style: Theme.of(context).textTheme.bodyText1),
              MyTextField(keyboardType: TextInputType.multiline),
              const SizedBox(height: 10),
              Text('Senha', style: Theme.of(context).textTheme.bodyText1),
              MyTextField(),
              const ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                contentPadding: EdgeInsets.all(0),
                title: Text('Mínimo 12 caracteres'),
              ),
              const ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                contentPadding: EdgeInsets.all(0),
                title: Text('Ao menos 1 letra maiúscula'),
              ),
              const ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                contentPadding: EdgeInsets.all(0),
                title: Text('Ao menos 3 caacteres especiais'),
              ),
              const ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                contentPadding: EdgeInsets.all(0),
                title: Text('Ao menos 3 números'),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Criar senha',
                        style: Theme.of(context).textTheme.bodyText2)),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
