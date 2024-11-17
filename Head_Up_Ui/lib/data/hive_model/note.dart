import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note {

  static var skeletonDataShort = Note(
    contentJson: "demo SHORT",
    contentPlain: "demo 123 456 789 10 11 12",
    title: "demo",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(), id: 'aabbcc'
  );

  static var skeletonDataLong = Note(
      contentJson: "demo LONG",
      contentPlain: "Bootstrap 5 is evolving with each release to better utilize CSS variables for global theme styles, individual components, and even utilities. We provide dozens of variables for colors, font styles, and more at a :root level for use anywhere. On components and utilities, CSS variables are scoped to the relevant class and can easily be modified.",
      title: "demo",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(), id: 'aabbcc'
  );

  static var listNoteSkeleton = List.of([skeletonDataShort, skeletonDataShort, skeletonDataShort]);
  @HiveField(0)
  final String id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late  String contentJson;
  @HiveField(3)
  late String contentPlain;
  @HiveField(4)
  final DateTime createdAt;
  @HiveField(5)
  late DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.contentJson,
    required this.contentPlain,
    required this.createdAt,
    required this.updatedAt,
  });

  // Chuyển Note thành Map để lưu vào Hive
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'contentJson': contentJson,
      'contentPlain': contentPlain,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      contentJson: map['contentJson'],
      contentPlain: map['contentPlain'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}