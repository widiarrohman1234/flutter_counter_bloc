import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/login/bloc/login_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.indigo],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.flutter_dash,
                        size: 35,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 12),

                    Text(
                      "BLoC Cubit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),

                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        if (state is LoginSuccess) {
                          final data = state.login.data!.user;
                          return Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.white70,
                                size: 16,
                              ),
                              SizedBox(height: 6),
                              Text(
                                data!.username,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          );
                        }
                        return Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.white70,
                              size: 16,
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Unauthorized",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: Text("Home"),
            subtitle: const Text('Software Engineer'),
            leading: const Icon(Icons.home, size: 40, color: Colors.blue),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
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
          const Divider(),
          ListTile(
            title: Text("Product"),
            subtitle: const Text('Melihat halaman produk'),
            leading: const Icon(
              Icons.store_outlined,
              size: 40,
              color: Colors.blue,
            ),
            trailing: const Icon(Icons.logout),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/products');
            },
          ),
          const Divider(),
          // profile
          ListTile(
            title: Text("Profile"),
            subtitle: const Text('Melihat halaman profile'),
            trailing: const Icon(Icons.arrow_forward_ios),
            leading: const Icon(
              Icons.account_circle_outlined,
              size: 40,
              color: Colors.blue,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          
        ],
      ),
    );
  }
}
