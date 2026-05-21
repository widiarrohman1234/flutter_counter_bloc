import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_counter_bloc/register/models/register_model.dart';
import 'package:flutter_counter_bloc/register/repository/register_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;

  RegisterBloc({required this.registerRepository}) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }
  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final RegisterModel register = await registerRepository.register(
        email: event.email,
        username: event.username,
        password: event.password,
      );

      emit(RegisterSuccess(message: register.message));
    } catch (e) {
      emit(RegisterFailure(message: e.toString()));
    }
  }
}
