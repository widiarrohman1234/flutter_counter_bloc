// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/auth/cubit/auth_cubit.dart';
import 'package:flutter_counter_bloc/login/bloc/login_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _username = TextEditingController(
    // text: "arrohmanwidi@gmail.com",
  );
  final TextEditingController _password = TextEditingController(
    // text: "12341234",
  );

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      // Listener untuk mendengarkan perubahan state
      listener: (context, state) {
        // jika state login success
        if (state is LoginSuccess) {
          // simpan token global
          context.read<AuthCubit>().setLogin(token: state.login.data!.jwt);

          // show snackbar
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Login succesful")));

          // delay 1 detil, navigator ke home
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushReplacementNamed(context, '/home');
          });
        }

        // jika state login failure
        if (state is LoginFailure) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Login Failed"),
              content: Text("Username atau password salah"),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
      },
      // Builder untuk menampilkan UI
      builder: (context, state) {
        // jika state sedang loading maka tampilkan Circular Progress Indicator
        if (state is LoginLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // jika sudah selesai login, tampilkan halaman
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 32.0),
                    TextField(
                      controller: _username,
                      decoration: const InputDecoration(
                        labelText: "Username",
                        hintText: "Input username",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        hintText: "Input Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          print("login pressed");
                          // gunakan BLoC, bukan if else lagi
                          context.read<LoginBloc>().add(
                            LoginSubmitted(
                              identifier: _username.text,
                              password: _password.text,
                            ),
                          );
                        },
                        child: Text("Login"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
