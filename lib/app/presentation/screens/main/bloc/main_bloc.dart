import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_app/app/data/models/notes_model.dart';
import 'package:note_app/app/data/sources/locale/hive_helper.dart';
import 'package:note_app/app/di/di.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<MainInitialEvent>((event, emit) async{
      try{
        emit(MainLoadingState());
        final result = HiveHelper.getAllNotes();
        List<NotesModel> notes = [];
        result.forEach((element) {
          if(element.isActive)
          notes.add(element);
        });
        print("+++++++++++${result}");
        emit(MainSuccessState(notes));
      }catch(e){
        print("-------------${e}");
        emit(MainErrorState(e.toString()));
      }
    });


    on<DeleteNote>((event, emit) async{
      try{
        emit(MainLoadingState());
        final res = HiveHelper.deleteNote(event.id);
        final result = HiveHelper.getAllNotes();
        List<NotesModel> notes = [];
        result.forEach((element) {
          if(element.isActive)
            notes.add(element);
        });
        print("+++++++++++${result}");
        emit(MainSuccessState(notes));
      }catch(e){
        print("-------------${e}");
        emit(MainErrorState(e.toString()));
      }
    });

    on<DeleteAllNotes>((event, emit) async{
      try{
        emit(MainLoadingState());
        final res = HiveHelper.clearHive();

        emit(MainSuccessState([]));
      }catch(e){
        print("-------------${e}");
        emit(MainErrorState(e.toString()));
      }
    });

    on<SearchEvent>((event, emit) async{
      try{
        emit(MainLoadingState());
        final result = HiveHelper.getAllNotes();

        List<NotesModel> notes = [];
        result.forEach((element) {
          if(element.title.contains(event.text))
            notes.add(element);
        });

        emit(MainSuccessState(notes));
      }catch(e){
        print("-------------${e}");
        emit(MainErrorState(e.toString()));
      }
    });
  }
}
