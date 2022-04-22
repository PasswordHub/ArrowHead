import 'package:arrowhead/screens/CreateEditPassword/create_edit_password.dart';
import 'package:arrowhead/screens/Login/login_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

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
            onPressed: () {},
          ),
        ],
      ),
      drawer: const HomePageDrawer(),
      body: Column(
        children: [
          PasswordItem(
            text: 'Instagram',
            imageUrl:
                'https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Instagram-Icon.png/600px-Instagram-Icon.png',
          ),
          PasswordItem(
              text: 'Facebook',
              imageUrl:
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Facebook_icon_2013.svg/1200px-Facebook_icon_2013.svg.png'),
          PasswordItem(
              text: 'Twitter',
              imageUrl:
                  'https://logodownload.org/wp-content/uploads/2014/09/twitter-logo-4.png'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 48, 48, 48),
        child: Icon(
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

class PasswordItem extends StatelessWidget {
  final String text;
  final String imageUrl;

  const PasswordItem({Key? key, this.text = '', this.imageUrl = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size deviceSettings = MediaQuery.of(context).size;
    return Container(
        width: deviceSettings.width,
        child: ListTile(
          leading: Image.network(imageUrl, width: 35, height: 35),
          title: Text(text),
          trailing: IconButton(
            icon: const Icon(Icons.arrow_forward_ios_sharp),
            onPressed: () {},
          ),
        ));
  }
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
