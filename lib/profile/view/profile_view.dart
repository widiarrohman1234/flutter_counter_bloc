import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_counter_bloc/auth/cubit/auth_cubit.dart';
import 'package:flutter_counter_bloc/profile/bloc/profile_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late int confirmed = 1;
  bool get isConfirmed => confirmed == 1 ? true : false;
  late int blocked = 0;
  bool get isBlocked => blocked == 1 ? true : false;


  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // load profile
    final token = context.read<AuthCubit>().state.token;
    context.read<ProfileBloc>().add(LoadProfile(token: token!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        // jika state login success
        if (state is ProfileSuccess) {
          final profile = state.profile.data;

          usernameController.text = profile!.username;
          emailController.text = profile.email;
          confirmed = profile.confirmed;
          blocked = profile.blocked;
        }

        // jika state login failure
        if (state is ProfileFailure) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Load Profile Failed"),
              content: Text("$state.message"),
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
        return Scaffold(
          appBar: AppBar(title: const Text("Profile")),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // build profile builder
                buildProfileBuilder(),

                SizedBox(height: 20),

                // build status card
                buildStatusCard(),

                Divider(),

                // build form
                buildForm(),

                SizedBox(height: 32),

                // build logout button
                buildLogoutButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Column buildProfileBuilder() {
    return Column(
      children: [
        const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
        const SizedBox(height: 12),
        // username
        Text(
          usernameController.text,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(emailController.text, style: TextStyle(color: Colors.grey[500])),
      ],
    );
  }

  Card buildStatusCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // icon
            Icon(
              isConfirmed ? Icons.verified : Icons.warning,
              color: isConfirmed ? Colors.green : Colors.orange,
            ),
            // text
            Expanded(
              child: Text(
                isConfirmed ? 'Account Verified' : 'Account Not Verified',
                style: TextStyle(
                  color: isConfirmed ? Colors.green : Colors.orange,
                ),
              ),
            ),
            if (isBlocked)
              const Chip(label: Text('Blocked'), backgroundColor: Colors.red),
          ],
        ),
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Username wajib diisi";
              }
              return null;
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email wajib diisi";
              }
              return null;
            },
          ),
          SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              label: Text("Update Profile"),
              icon: Icon(Icons.save),
              onPressed: () {
                print("update profile");
              },
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        icon: Icon(Icons.logout),
        label: Text("Logout"),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/login');
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
