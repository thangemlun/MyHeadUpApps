import 'package:head_up_ui/data/hive_model/note.dart';


class Folder {

  static var skeletonData = Folder(
      folderName: "demo",notes: [], updatedTime: DateTime.now(), createdTime: DateTime.now());

  final String folderName;
  final List<Note> notes;
  final DateTime createdTime;
  final DateTime updatedTime;

  Folder({
    required this.folderName,
    required this.notes,
    required this.createdTime,
    required this.updatedTime
  });

  Map<String, dynamic> toMap() {
    return {
      'folderName': folderName,
      'notes': notes,
      'createdTime' : createdTime,
      'updatedTime' : updatedTime
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
        folderName: map['folderName'],
        notes: (map['notes'] as List<dynamic>).map((e) => e as Note).toList(),
        createdTime: map['createdTime'],
        updatedTime: map['updatedTime']
    );
  }

  static List<Note> _toNotes(List<dynamic> noteListMap) {
    return noteListMap.map((map) {
      var mapNote = map as Map<String, dynamic>;
      return Note.fromMap(mapNote);
    }).toList();
  }

}