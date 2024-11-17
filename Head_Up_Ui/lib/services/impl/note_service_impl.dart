import 'package:head_up_ui/data/hive_model/folder.dart';
import 'package:head_up_ui/data/hive_model/note.dart';
import 'package:head_up_ui/exception/item_not_found_exception.dart';
import 'package:head_up_ui/services/folder_service.dart';
import 'package:head_up_ui/services/impl/folder_service_impl.dart';
import 'package:head_up_ui/services/note_service.dart';

class NoteServiceImpl implements NoteService {
  final FolderService folderService = FolderServiceImpl();

  @override
  Future<void> saveNote(Note note, String folderName) async {
    // TODO: implement saveNote
    try {
      var folder = await folderService.getFolder(folderName);
      if (folder == null) {
        throw ItemNotFoundException("Folder name not found !!!");
      }
      // check create or update
      if (_checkIsUpdateNote(folder, note)) {
        var fnote = folder.notes.firstWhere((n) => n.id == note.id);
        fnote
          ..title = note.title
          ..contentPlain = note.contentPlain
          ..contentJson = note.contentJson
          ..updatedAt = DateTime.now();
      } else {
        folder.notes.add(note);
      }

      folderService.saveFolder(folder);
    } catch (e) {
      throw e;
    }
  }

  bool _checkIsUpdateNote(Folder folder, Note note) {
    return folder.notes.any((n) {
      return n.id == note.id;
    });
  }
}
