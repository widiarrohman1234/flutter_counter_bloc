import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text("BLoC Cubit")),
          ListTile(
            title: Text("Home"),
            subtitle: const Text('Software Engineer'),
            leading: const Icon(Icons.home, size: 40, color: Colors.blue),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),
          const Divider(),
          ListTile(
            title: Text("Counter"),
            subtitle: const Text('Software Engineer'),
            leading: const Icon(Icons.numbers, size: 40, color: Colors.blue),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/counter');
            },
          ),
          const Divider(),
          ListTile(
            title: Text("Post List"),
            subtitle: const Text('Software Engineer'),
            leading: const Icon(Icons.newspaper, size: 40, color: Colors.blue),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/posts');
            },
          ),
          // const Divider(),
          // ListTile(
          //   title: Text("Login"),
          //   subtitle: const Text('Software Engineer'),
          //   leading: const Icon(Icons.newspaper, size: 40, color: Colors.blue),
          //   trailing: const Icon(Icons.arrow_forward_ios),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.pushNamed(context, '/login');
          //   },
          // ),
        ],
      ),
    );
  }
}
