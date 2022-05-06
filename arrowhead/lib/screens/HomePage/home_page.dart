import 'package:arrowhead/Data/password_data.dart';
import 'package:arrowhead/models/password.dart';
import 'package:arrowhead/screens/CreateEditPassword/create_edit_password.dart';
import 'package:arrowhead/screens/Login/login_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Password> passwords;
  String query = '';

  @override
  void initState() {
    super.initState();

    passwords = allPasswords;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Senhas salvas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 48, 48, 48),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: new Icon(Icons.search),
            tooltip: 'Search',
            color: Colors.white,
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(passwords),
              );
            },
          ),
        ],
      ),
      drawer: const HomePageDrawer(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: passwords.length,
              itemBuilder: (context, index) {
                final password = passwords[index];

                return buildPassword(password);
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 48, 48, 48),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(CreateEditPassword.routeName);
        },
      ),
    );
  }
}

Widget buildPassword(Password password) => ListTile(
      leading: Image.network(
        password.url,
        width: 35,
        height: 35,
      ),
      title: Text(password.name),
      subtitle: Text(password.description),
      trailing: Icon(Icons.arrow_forward_ios),
    );

class MySearchDelegate extends SearchDelegate {
  final List<Password> passwords;

  MySearchDelegate(this.passwords);

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
      textTheme: const TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      )
    );
    return theme;
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white,),
        onPressed: () => close(context, null),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear, color: Colors.white,),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
        ),
      ];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Password> suggestions = passwords.where((searchResult) {
      final result = searchResult.name.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final password = suggestions[index];

        return ListTile(
          leading: Image.network(
            password.url,
            width: 35,
            height: 35,
          ),
          title: Text(password.name, style: const TextStyle(color: Colors.black),),
          onTap: () {
            query = password.name;
            showResults(context);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
        ),
      );
}

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const UserAccountsDrawerHeader(
          accountName: Text(
            "Bill Gates",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          accountEmail: Text(
            "billgates123@email.com",
            style: TextStyle(),
          ),
          decoration: BoxDecoration(color: Color.fromARGB(255, 48, 48, 48)),
          currentAccountPicture: CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage(
                "https://scontent.fplu3-1.fna.fbcdn.net/v/t1.18169-9/23473074_10155031875776961_8482140412038626648_n.jpg?stp=cp0_dst-jpg_e15_p320x320_q65&_nc_cat=107&ccb=1-5&_nc_sid=7aed08&_nc_ohc=5T1yXKlmgmAAX8KDiPU&_nc_ht=scontent.fplu3-1.fna&oh=00_AT_Me8zbq2IdVW42F5vt5Eam_gXGOXknl5pLc0RvZhCG1Q&oe=62865BDE"),
            backgroundColor: Colors.transparent,
          ),
        ),
        ListTile(
          leading: Icon(Icons.lock),
          title: Text('Senhas', style: Theme.of(context).textTheme.subtitle2),
        ),
        ListTile(
          leading: Icon(Icons.storage_rounded),
          title: Text('Gurpos de Senhas',
              style: Theme.of(context).textTheme.subtitle2),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings', style: Theme.of(context).textTheme.subtitle2),
        ),
        ListTile(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          },
          leading: const Icon(
            Icons.logout,
            color: Colors.red,
          ),
          title: const Text(
            'logout',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        )
      ],
    ));
  }
}
