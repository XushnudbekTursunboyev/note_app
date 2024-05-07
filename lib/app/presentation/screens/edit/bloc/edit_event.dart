part of 'edit_bloc.dart';

@immutable
sealed class EditEvent {}

class ClickEditEvent extends EditEvent {
  final NotesModel notesModel;

  ClickEditEvent(this.notesModel);
}
