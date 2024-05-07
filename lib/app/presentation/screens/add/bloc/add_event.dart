part of 'add_bloc.dart';

@immutable
sealed class AddEvent {}

class ClickAddEvent extends AddEvent {
  final NotesModel notesModel;

  ClickAddEvent(this.notesModel);
}