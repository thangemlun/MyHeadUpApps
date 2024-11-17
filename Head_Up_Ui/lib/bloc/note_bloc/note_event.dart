part of 'note_bloc.dart';

@immutable
sealed class NoteEvent {}

class InitialNoteEvent extends NoteEvent{}

class SaveNoteEvent extends NoteEvent{}
