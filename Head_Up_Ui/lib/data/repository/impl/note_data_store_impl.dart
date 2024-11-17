import 'package:head_up_ui/data/hive_model/note.dart';
import 'package:head_up_ui/data/repository/folder_data_store.dart';
import 'package:head_up_ui/data/repository/impl/folder_data_store_impl.dart';
import 'package:head_up_ui/data/repository/note_data_store.dart';
import 'package:hive/hive.dart';

class NoteDataStoreImpl extends NoteDataStore {

  late final FolderDataStore folderStorage;

  NoteDataStoreImpl() {
    folderStorage = FolderDataStoreImpl();
  }

  @override
  Future<Note?> getNote(String id, String folderName) async {
    // TODO: implement getNote
    var box = Hive.box(folderName);
    var noteMap = box.get(id);

    if (noteMap != null) {
      return Note.fromMap(noteMap);
    }
    return null;
  }

  @override
  Future<void> saveNote(Note? note, String folderName) async {
    // TODO: implement saveNote
    var box = Hive.box(folderName);
    await box.put(note?.id, note?.toMap());
  }

  Future<List<Note>> getAllNotes(String folderName) async {
    var box = Hive.box(folderName);
    return box.values.toList().cast<Note>();
  }

  Future<void> deleteNote(String id, String folderName) async {
    var box = Hive.box(folderName);
    await box.delete(id); // Xóa note theo id
  }

}