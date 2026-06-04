import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_counter_bloc/profile/model/profile_model.dart';
import 'package:flutter_counter_bloc/profile/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc({required this.profileRepository}) : super(ProfileInitial()) {
<<<<<<< HEAD
    on<ProfileEvent>(_onProfileEvent);
  }

  Future<void> _onProfileEvent(
    ProfileEvent event,
=======
    on<LoadProfile>(_onProfileEvent);
  }

  Future<void> _onProfileEvent(
    LoadProfile event,
>>>>>>> experiment-copy
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    try {
<<<<<<< HEAD
      final ProfileModel profile = await profileRepository.getProfile(
        token: (event as LoadProfile).token,
      );

=======
      final profile = await profileRepository.getProfile(token: event.token);
>>>>>>> experiment-copy
      emit(ProfileSuccess(profile: profile));
    } catch (e) {
      emit(ProfileFailure(message: e.toString()));
    }
  }
}
