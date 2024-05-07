part of 'main_bloc.dart';

@immutable
sealed class MainState {}

class MainLoadingState extends MainState {}

class MainErrorState extends MainState {
  final String message;
  MainErrorState(this.message);
}

class MainSuccessState extends MainState {
  final List<NotesModel> notes;

  MainSuccessState(this.notes);
}


final class MainInitial extends MainState {}
