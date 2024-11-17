import 'package:head_up_ui/data/hive_model/note.dart';

abstract class NoteDataStore {
  Future<Note?> getNote(String id, String folderName);
  Future<void> saveNote(Note? note, String folderName);
  Future<List<Note>> getAllNotes(String folderName);
  Future<void> deleteNote(String id, String folderName);
}