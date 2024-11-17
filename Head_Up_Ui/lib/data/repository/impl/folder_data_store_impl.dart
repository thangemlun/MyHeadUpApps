import 'dart:collection';

import 'package:head_up_ui/data/hive_model/folder.dart';
import 'package:head_up_ui/data/repository/folder_data_store.dart';
import 'package:head_up_ui/environment/app_properties.dart';
import 'package:hive/hive.dart';

class FolderDataStoreImpl extends FolderDataStore {
  @override
  Future<void> deleteFolder(String id) async {
    // TODO: implement deleteFolder
    throw UnimplementedError();
  }

  @override
  Future<List<Folder>> getAllFolders() async {
    // TODO: implement getAllFolders
    var box = Hive.box(AppProperties.APP_BOX);

    return box.values.map((value) {
      LinkedHashMap<dynamic, dynamic> valueMap = value;
      var map = valueMap.cast<String, dynamic>();
      return Folder.fromMap(map);
    }).toList();
  }

  @override
  Future<Folder?> getFolder(String id) async {
    // TODO: implement getFolder
    var box = Hive.box(AppProperties.APP_BOX);
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
   var box = Hive.box(AppProperties.APP_BOX);
   await box.put(folder?.folderName, folder?.toMap());
  }

}