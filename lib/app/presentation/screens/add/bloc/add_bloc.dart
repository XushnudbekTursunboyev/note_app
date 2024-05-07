import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_app/app/data/models/notes_model.dart';
import 'package:note_app/app/data/sources/locale/hive_helper.dart';

part 'add_event.dart';
part 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  AddBloc() : super(AddInitial()) {
    on<ClickAddEvent>((event, emit) async{
      try{
        emit(AddLoadingState());
        final result = await HiveHelper.addNote(event.notesModel);
        emit(AddSuccessState());
      } catch(e) {
        emit(AddErrorState(e.toString()));
      }
    });
  }
}
