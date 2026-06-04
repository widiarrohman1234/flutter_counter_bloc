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
<<<<<<< HEAD

=======
>>>>>>> experiment-copy
  late int blocked = 0;
  bool get isBlocked => blocked == 1 ? true : false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

<<<<<<< HEAD
  // initstate
  @override
  void initState() {
    super.initState();
    // load profile
=======
  @override
  void initState() {
    super.initState();
>>>>>>> experiment-copy
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
<<<<<<< HEAD
          appBar: AppBar(title: Text("Profile Page")),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                buildProfileBuilder(),
                SizedBox(height: 20),

                // widget status card
                buildStatusCard(),
                Divider(),

                // form
                buildForm(),

                SizedBox(height: 32),

                buildLogoutButton(context),
=======
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

                SizedBox(height: 20),

                // build danger zone delete account
                buildDangerZone(context),

                SizedBox(height: 32),

                // build logout button
                buildLogoutButton(),
>>>>>>> experiment-copy
              ],
            ),
          ),
        );
      },
    );
  }

<<<<<<< HEAD
  SizedBox buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/login');
        },
        label: Text("Logout"),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: BorderSide(color: Colors.red),
=======
  Container buildDangerZone(BuildContext context) {
    return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red.shade200),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.red.shade50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Danger Zone",
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "These actions may affect your account permanently.",
                      style: TextStyle(color: Colors.grey.shade700),
                    ),

                    const SizedBox(height: 16),

                    /// DELETE ACCOUNT
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                        ),
                        icon: const Icon(Icons.delete_forever),
                        label: const Text("Delete Account"),
                        onPressed: () {
                          // _showDeleteAccountDialog();
                          Navigator.pushNamed(context, '/delete-account');
                        },
                      ),
                    ),
                  ],
                ),
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
>>>>>>> experiment-copy
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
<<<<<<< HEAD

          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'email',
=======
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'Email',
>>>>>>> experiment-copy
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
<<<<<<< HEAD

          SizedBox(height: 8),

=======
          SizedBox(height: 8),
>>>>>>> experiment-copy
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
<<<<<<< HEAD
              onPressed: () {
                print("Update profile ditekan");
              },
              label: Text("Update Profile"),
              icon: Icon(Icons.save),
=======
              label: Text("Update Profile"),
              icon: Icon(Icons.save),
              onPressed: () {
                Navigator.pushNamed(context, '/update-profile');
                print("update profile");
              },
>>>>>>> experiment-copy
            ),
          ),
        ],
      ),
    );
  }

<<<<<<< HEAD
  Card buildStatusCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
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
                isConfirmed ? "Account Verified" : "Account Not Verified",
                style: TextStyle(
                  color: isConfirmed ? Colors.green : Colors.orange,
                ),
              ),
            ),

            if (isBlocked)
              const Chip(label: Text("Blocked"), backgroundColor: Colors.red),
          ],
=======
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
>>>>>>> experiment-copy
        ),
      ),
    );
  }
<<<<<<< HEAD

  Column buildProfileBuilder() {
    return Column(
      children: [
        CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
        SizedBox(height: 12),
        Text(
          usernameController.text,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(emailController.text, style: TextStyle(color: Colors.grey[500])),
      ],
    );
  }
=======
>>>>>>> experiment-copy
}
