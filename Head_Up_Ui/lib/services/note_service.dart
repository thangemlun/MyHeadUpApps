import 'package:head_up_ui/data/hive_model/note.dart';

abstract class NoteService {
  Future<void> saveNote(Note note, String folderName);
}