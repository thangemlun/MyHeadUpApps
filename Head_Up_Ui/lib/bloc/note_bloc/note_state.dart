part of 'note_bloc.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteSaveState extends NoteState {}

final class NoteViewState extends NoteState {}
