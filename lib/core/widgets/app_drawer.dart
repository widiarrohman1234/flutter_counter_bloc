import 'package:flutter/material.dart';
import 'package:flutter_counter_bloc/counter/view/counter_page.dart';
import 'package:flutter_counter_bloc/home/view/home_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text("Menu")),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.countertops),
            title: const Text("Counter"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/counter');
            },
          ),
        ],
      ),
    );
  }
}
