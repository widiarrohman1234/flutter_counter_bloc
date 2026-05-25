import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() =>
      _ChangePasswordPageState();
}

class _ChangePasswordPageState
    extends State<ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();

  final currentPasswordController =
      TextEditingController();

  final newPasswordController =
      TextEditingController();

  final confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> updatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      // TODO:
      // ambil token dari SharedPreferences / SecureStorage
      const token = 'YOUR_TOKEN';

      final response = await http.put(
        Uri.parse(
          'https://api.ppb.widiarrohman.my.id/api/users/update-password',
        ),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'currentPassword':
              currentPasswordController.text,
          'newPassword':
              newPasswordController.text,
          'confirmPassword':
              confirmPasswordController.text,
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode < 200 ||
          response.statusCode >= 300) {
        throw Exception(
          responseBody['message'] ??
              'Gagal mengubah password',
        );
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            responseBody['message'] ??
                'Password berhasil diubah',
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggle,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            obscureText
                ? Icons.visibility_off
                : Icons.visibility,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label wajib diisi';
        }

        if (value.length < 8) {
          return 'Minimal 8 karakter';
        }

        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 40,
                child: Icon(
                  Icons.lock_reset,
                  size: 40,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Update Your Password',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Gunakan password yang kuat dan aman.',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              buildPasswordField(
                label: 'Current Password',
                controller:
                    currentPasswordController,
                obscureText:
                    obscureCurrentPassword,
                onToggle: () {
                  setState(() {
                    obscureCurrentPassword =
                        !obscureCurrentPassword;
                  });
                },
              ),

              const SizedBox(height: 20),

              buildPasswordField(
                label: 'New Password',
                controller: newPasswordController,
                obscureText: obscureNewPassword,
                onToggle: () {
                  setState(() {
                    obscureNewPassword =
                        !obscureNewPassword;
                  });
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller:
                    confirmPasswordController,
                obscureText:
                    obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon:
                      const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword =
                            !obscureConfirmPassword;
                      });
                    },
                    icon: Icon(
                      obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return 'Confirm Password wajib diisi';
                  }

                  if (value !=
                      newPasswordController.text) {
                    return 'Password tidak cocok';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed:
                      isLoading
                          ? null
                          : updatePassword,
                  icon:
                      isLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child:
                                CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                          )
                          : const Icon(Icons.save),
                  label: Text(
                    isLoading
                        ? 'Loading...'
                        : 'Update Password',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
