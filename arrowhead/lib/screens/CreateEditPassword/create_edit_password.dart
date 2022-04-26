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
              passwordField(),
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
                title: Text('Ao menos 3 caracteres especiais'),
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
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 13, 189, 62),
                    ),
                    child: Text('Criar senha',
                        style: Theme.of(context).textTheme.bodyText2)),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget passwordField() {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(width: deviceSize.width * 0.75, child: MyTextField()),
        Container(
          width: deviceSize.width * 0.10,
          child: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {},
          ),
        )
      ],
    ));
  }
}
