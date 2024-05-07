import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_app/app/data/models/notes_model.dart';
import 'package:note_app/app/data/sources/locale/hive_helper.dart';

part 'edit_event.dart';
part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc() : super(EditInitial()) {
    on<ClickEditEvent>((event, emit) async{
      try{
        emit(EditLoadingState());
        final result = await HiveHelper.editNote(event.notesModel.id ,event.notesModel);
        emit(EditSuccessState());
      } catch(e) {
        print("edit ${e.toString()}");
        emit(EditErrorState(e.toString()));
      }
    });
  }
}
