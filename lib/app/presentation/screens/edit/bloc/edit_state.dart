part of 'edit_bloc.dart';

@immutable
sealed class EditState {}

class EditLoadingState extends EditState {}

class EditErrorState extends EditState {
  final String message;
  EditErrorState(this.message);
}

class EditSuccessState extends EditState {}

final class EditInitial extends EditState {}
