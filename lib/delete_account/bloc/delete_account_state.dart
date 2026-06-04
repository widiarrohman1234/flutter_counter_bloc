part of 'delete_account_bloc.dart';

sealed class DeleteAccountState extends Equatable {
  const DeleteAccountState();
  
  @override
  List<Object> get props => [];
}

final class DeleteAccountInitial extends DeleteAccountState {}

final class DeleteAccountLoading extends DeleteAccountState {}

final class DeleteAccountSuccess extends DeleteAccountState {
  final DeleteAccountModel deleteAccountModel;

  const DeleteAccountSuccess({required this.deleteAccountModel});

  @override
  List<Object> get props => [deleteAccountModel];
}

final class DeleteAccountFailure extends DeleteAccountState {
  final String error;

  const DeleteAccountFailure({required this.error});

  @override
  List<Object> get props => [error];
}
