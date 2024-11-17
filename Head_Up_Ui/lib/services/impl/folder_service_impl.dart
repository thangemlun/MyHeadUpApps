import 'package:flutter/cupertino.dart';
import 'package:head_up_ui/data/hive_model/folder.dart';
import 'package:head_up_ui/data/repository/folder_data_store.dart';
import 'package:head_up_ui/data/repository/impl/folder_data_store_impl.dart';
import 'package:head_up_ui/services/folder_service.dart';
import 'package:head_up_ui/util/toastification_util.dart';
import 'package:toastification/toastification.dart';

class FolderServiceImpl implements FolderService {

  final FolderDataStore folderStorage = FolderDataStoreImpl();

  @override
  Future<bool> checkExistedFolder(Folder folder) async {
    // TODO: implement saveFolder
    Folder? oldOne = await folderStorage.getFolder(folder.folderName);
    if (oldOne != null) {
      ToastificationUtil.toast("Folder name existed", ToastificationType.error, Alignment.topRight);
      return false;
    }
    return true;
  }

  @override
  Future<void> saveFolder(Folder folder) async {
    // TODO: implement saveFolder
    try {
      await folderStorage.saveFolder(folder);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<Folder?> getFolder(String folderName) async {
    // TODO: implement getFolder
    try {
      Folder? folder = await folderStorage.getFolder(folderName);
      return folder;
    } catch (e) {
      print(e);
    }
  }

}