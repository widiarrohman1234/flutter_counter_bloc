import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text("Menu")),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
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

            ListTile(
              leading: const Icon(Icons.people),
              title: const Text("User"),
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