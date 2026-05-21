import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/register/bloc/register_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));

          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushReplacementNamed(context, '/login');
          });
        }

        if (state is RegisterFailure) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Register Failed"),
              content: Text(state.message),
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
      builder: (context, state) {
        if (state is RegisterLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: AppBar(title: Text("Register")),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Register Page",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 32.0),
                    // email
                    TextField(
                      controller: _email,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        hintText: "Input email",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    // username
                    TextField(
                      controller: _username,
                      decoration: const InputDecoration(
                        labelText: "Username",
                        hintText: "Input username",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8.0),
                    // password
                    TextField(
                      controller: _password,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        hintText: "Input password",
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 8.0),
                    // tombol register
                    SizedBox(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<RegisterBloc>().add(
                            RegisterSubmitted(
                              email: _email.text,
                              username: _username.text,
                              password: _password.text,
                            ),
                          );
                        },
                        child: Text("Register"),
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
