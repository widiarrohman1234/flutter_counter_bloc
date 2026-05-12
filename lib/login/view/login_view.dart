import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      // jika tombol login di klik maka tampil loading
                      // jika username test dan password 1234 maka ke home dan muncul snacbar
                      // jika gagal, maka tampil dialog
                      if (_username.text == "test" &&
                          _password.text == "1234") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Login succesful")),
                        );
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.pushReplacementNamed(context, '/home');
                        });
                      } else {
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
                    child: Text("Login"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
