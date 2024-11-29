import 'dart:collection';

import 'package:head_up_ui/data/hive_model/folder.dart';
import 'package:head_up_ui/data/repository/folder_data_store.dart';
import 'package:head_up_ui/exception/http_custom_exception.dart';
import 'package:hive/hive.dart';
import 'package:localstorage/localstorage.dart';

class FolderDataStoreImpl extends FolderDataStore {
  final storage = localStorage;

  @override
  Future<void> deleteFolder(String id) async {
    // TODO: implement deleteFolder
    throw UnimplementedError();
  }

  @override
  Future<List<Folder>> getAllFolders() async {
    // TODO: implement getAllFolders
    var box = await getBox();
    return box.values.map((value) {
      LinkedHashMap<dynamic, dynamic> valueMap = value;
      var map = valueMap.cast<String, dynamic>();
      return Folder.fromMap(map);
    }).toList();
  }

  @override
  Future<Folder?> getFolder(String id) async {
    // TODO: implement getFolder
    var box = await getBox();
    var folder = box.get(id, defaultValue: null);
    if (folder == null) {
      return null;
    }
    LinkedHashMap<dynamic, dynamic> valueMap = folder;
    var map = valueMap.cast<String, dynamic>();
    return Folder.fromMap(map);
  }

  @override
  Future<void> saveFolder(Folder? folder) async {
    // TODO: implement saveFolder
    var box = await getBox();
    await box.put(folder?.folderName, folder?.toMap());
  }

  Future<Box> getBox() async {
    try {
      String? noteId = await storage.getItem("NOTE-ID");
      return Hive.box(noteId ?? "");
    } catch (e) {
      throw HttpCustomException("Error get storage : ${e.toString()}");
    }
  }
}
