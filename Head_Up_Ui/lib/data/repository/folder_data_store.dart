import 'package:head_up_ui/data/hive_model/folder.dart';

abstract class FolderDataStore {
  Future<Folder?> getFolder(String id);
  Future<void> saveFolder(Folder? folder);
  Future<List<Folder>> getAllFolders();
  Future<void> deleteFolder(String id);
}