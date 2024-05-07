import 'package:hive/hive.dart';
import 'package:note_app/app/data/models/notes_model.dart';

class NotesModelAdapter extends TypeAdapter<NotesModel> {
  @override
  NotesModel read(BinaryReader reader) {
    return NotesModel.fromJson(reader.readMap().cast());
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, NotesModel obj) {
    writer.writeMap(obj.toJson());
  }
}
