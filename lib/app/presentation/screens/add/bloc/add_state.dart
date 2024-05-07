part of 'add_bloc.dart';

@immutable
sealed class AddState {}

class AddLoadingState extends AddState {}

class AddErrorState extends AddState {
  final String message;
  AddErrorState(this.message);
}

class AddSuccessState extends AddState {}

final class AddInitial extends AddState {}
