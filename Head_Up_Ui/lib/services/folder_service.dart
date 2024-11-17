import 'package:head_up_ui/data/hive_model/folder.dart';

abstract class FolderService {
  Future<bool> checkExistedFolder(Folder folder);

  Future<void> saveFolder(Folder folder);

  Future<Folder?> getFolder(String folderName);
}