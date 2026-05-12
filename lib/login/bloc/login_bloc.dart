import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>(_onLoginEvent);
  }

  void _onLoginEvent(LoginEvent event, Emitter<LoginState> emit) async {
    if (event is LoginSubmitted) {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 2));
      if (event.username == 'test' && event.password == '1234') {
        emit(LoginSuccess());
      } else {
        emit(const LoginFailure(message: 'Invalid user or password'));
      }
    }
  }
}
