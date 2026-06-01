// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_counter_bloc/auth/cubit/auth_cubit.dart';
// import 'package:flutter_counter_bloc/profile/bloc/profile_bloc.dart';

// class ProfileEditView extends StatefulWidget {
//   const ProfileEditView({super.key});

//   @override
//   State<ProfileEditView> createState() => _ProfileEditViewState();
// }

// class _ProfileEditViewState extends State<ProfileEditView> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController usernameController = TextEditingController();

//   final TextEditingController emailController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     final token = context.read<AuthCubit>().state.token;

//     context.read<ProfileBloc>().add(LoadProfile(token: token!));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ProfileBloc, ProfileState>(
//       listener: (context, state) {
//         if (state is ProfileSuccess) {
//           final profile = state.profile.data;

//           usernameController.text = profile!.username;
//           emailController.text = profile.email;
//         }

//         if (state is ProfileUpdateSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Profile berhasil diperbarui")),
//           );

//           Navigator.pop(context, true);
//         }

//         if (state is ProfileFailure) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(SnackBar(content: Text(state.message)));
//         }
//       },
//       builder: (context, state) {
//         final isLoading = state is ProfileLoading || state is ProfileUpdating;

//         return Scaffold(
//           appBar: AppBar(title: const Text("Edit Profile")),
//           body: SingleChildScrollView(
//             padding: const EdgeInsets.all(20),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const CircleAvatar(
//                     radius: 50,
//                     child: Icon(Icons.person, size: 50),
//                   ),

//                   const SizedBox(height: 24),

//                   TextFormField(
//                     controller: usernameController,
//                     decoration: InputDecoration(
//                       labelText: "Username",
//                       prefixIcon: const Icon(Icons.person),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return "Username wajib diisi";
//                       }
//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 16),

//                   TextFormField(
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       labelText: "Email",
//                       prefixIcon: const Icon(Icons.email),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return "Email wajib diisi";
//                       }

//                       if (!value.contains('@')) {
//                         return "Format email tidak valid";
//                       }

//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 24),

//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton.icon(
//                       icon: isLoading
//                           ? const SizedBox(
//                               width: 18,
//                               height: 18,
//                               child: CircularProgressIndicator(strokeWidth: 2),
//                             )
//                           : const Icon(Icons.save),
//                       label: Text(isLoading ? "Saving..." : "Save Changes"),
//                       onPressed: isLoading
//                           ? null
//                           : () {
//                               if (_formKey.currentState!.validate()) {
//                                 final token = context
//                                     .read<AuthCubit>()
//                                     .state
//                                     .token;

//                                 context.read<ProfileBloc>().add(
//                                   ProfileUpdateEvent(
//                                     token: token!,
//                                     username: usernameController.text,
//                                     email: emailController.text,
//                                   ),
//                                 );
//                               }
//                             },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
