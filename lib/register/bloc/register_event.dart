part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String username;
  final String password;

<<<<<<< HEAD
  const RegisterSubmitted({
    required this.email,
    required this.username,
    required this.password,
  });
=======
  const RegisterSubmitted({required this.email, required this.username, required this.password});

>>>>>>> experiment-copy
  @override
  List<Object> get props => [email, username, password];
}
