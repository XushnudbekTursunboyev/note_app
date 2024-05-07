import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:note_app/app/data/models/hive/notes_adapter.dart';
import 'package:note_app/app/data/models/notes_model.dart';

class HiveHelper{

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(NotesModelAdapter());
    await Hive.openBox('notes');
  }

  static Future<void> addNote(NotesModel notesModel) async {
    var box = Hive.box('notes');
    await box.put(notesModel.id, notesModel);
  }

  static Future<void> deleteNote(String id) async {
    final box = Hive.box('notes');
    await box.delete(id);
  }

  static Future<void> editNote(String id, NotesModel updatedNote) async {
    final box = Hive.box('notes');
    final index = box.keys.toList().indexOf(id.toString());

    if (index != -1) {
      print('eeedasdasda');
      await box.putAt(index, updatedNote);
    }
  }

  static List<NotesModel> getAllNotes() {
    final box = Hive.box('notes');
    return box.values.cast<NotesModel>().toList();
  }

  static Future<void> addToArchive(String id, NotesModel notesModel) async {
    final box = Hive.box('notes');
    final index = box.keys.toList().indexOf(id.toString());

    if (index != -1) {
      final obj = box.getAt(index);
      obj.fieldToUpdate = notesModel;
      await box.putAt(index, obj);
    }
  }

  static Future<void> unarchive(String id, NotesModel notesModel) async {
    final box = Hive.box('notes');
    final index = box.keys.toList().indexOf(id.toString());
    if (index != -1) {
      final obj = box.getAt(index);
      obj.fieldToUpdate = notesModel;
      await box.putAt(index, obj);
    }
  }

  Future<List<NotesModel>> getArchiveNotes() async {
    final box = Hive.box<NotesModel>('notes');
    final archiveNotes = box.values.where((note) => !note.isActive).toList();
    return archiveNotes;
  }

  Future<void> deleteArchiveNotes() async {
    final box = Hive.box<NotesModel>('notes');
    final archiveNotesKeys = box.keys.where((key) {
      final note = box.get(key);
      return note != null && !note.isActive;
    }).toList();

    for (var key in archiveNotesKeys) {
      await box.delete(key);
    }
  }

  static void changeAllNotesToInactive() async {
    final box = Hive.box('notes');

    for (var key in box.keys) {
      final note = box.get(key);
      note!.isActive = false;
      await box.put(key, note);
    }
  }

  static Future<List<NotesModel>> searchNotes(String searchQuery) async {
    final box =  Hive.box<NotesModel>('notes');
    List<NotesModel> notes = box.values.where((note) => note.title.contains(searchQuery)).toList();
    box.close();
    return notes;
  }

  static Future<void> clearHive() async{
    final box = Hive.box('notes');
    box.clear();
  }

}