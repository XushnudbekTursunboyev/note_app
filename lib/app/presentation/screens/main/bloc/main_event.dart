part of 'main_bloc.dart';

@immutable
sealed class MainEvent {}

class MainInitialEvent extends MainEvent {

}

class SearchEvent extends MainEvent {
  final String text;

  SearchEvent(this.text);
}

class DeleteAllNotes extends MainEvent{

}

class DeleteNote extends MainEvent {
  final String id;

  DeleteNote(this.id);
}