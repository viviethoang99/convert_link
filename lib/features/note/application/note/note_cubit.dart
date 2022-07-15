import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../note.dart';

part 'note_state.dart';

@injectable
class NoteCubit extends Cubit<NoteState> {
  NoteCubit(this._noteRepository) : super(NoteInitial());

  final NoteRepository _noteRepository;

  /// Gets all [NoteDetail] from the [_noteRepository] and emits [NoteSuccess]
  /// state with the albums list.
  ///
  /// Also, [NoteInitial] state will be emitted while the albums are loaded.
  Future<void> loadAllNotes() async {
    emit(NoteInitial());
    final response = await _noteRepository.findAll();
    emit(NoteSuccess(response));
  }

  /// Watches for any updated [ListNoteDetails] from [_noteRepository] and
  /// emits [NoteSuccess] state with all notes list.
  ///
  /// Before watching for any update, it will load all notes by calling
  /// [loadAllNotes] method.
  Future<void> watchAllNotes() async {
    await loadAllNotes();
    _noteRepository.watchAllNotes().map(NoteSuccess.new).listen(emit);
  }

  Future<void> deleteNote(String id) async {
    await _noteRepository.deleteNote(id);
  }

  void deleteAllNote(bool? isDelete) async {
    if (isDelete ?? false) {
      await _noteRepository.deleteAllNotes();
    }
  }
}
