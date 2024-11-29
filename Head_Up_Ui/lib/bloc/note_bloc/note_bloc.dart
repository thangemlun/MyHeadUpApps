import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc() : super(NoteInitial()) {
    on<NoteEvent>((event, emit) async {
      switch (event) {
        case InitialNoteEvent():
          emit(NoteInitial());
          await Future.delayed(Duration(milliseconds: 500));
          emit(NoteViewState());
        case SaveNoteEvent():
          emit(NoteSaveState());
        default:
      }
    });
  }
}
