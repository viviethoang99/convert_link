import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../data.dart';

abstract class NoteLocalSource {
  // /// Deletes an note from the local storage matching the given [query].
  Future<void> deleteNote(String id);

  /// Deletes all notes from the local storage.
  Future<void> deleteAllNotes();

  /// Returns all albums stored in the local storage.
  Future<List<NoteDetailDto>> findAllNotes();

  /// Stores an [note] to the local storage and returns the same [note].
  Future<bool> saveNote(NoteDetailDto note);

  /// Returns a stream of list of [NoteDetailDto] stored in local storage.
  ///
  /// A new event will be emitted whenever an [NoteDetailDto] is updated,
  /// or a new [NoteDetailDto] is stored.
  Stream<List<NoteDetailDto>> watchAllNotes();

  NoteDetailDto? findNote(String id);
}

@Injectable(as: NoteLocalSource)
class NoteLocalSourceImpl implements NoteLocalSource {
  const NoteLocalSourceImpl(@Named('noteBox') this._noteBox);

  final Box<NoteDetailDto> _noteBox;

  @override
  Future<void> deleteAllNotes() => _noteBox.clear();

  @override
  Future<List<NoteDetailDto>> findAllNotes() async {
    return _noteBox.values.toList();
  }

  @override
  Future<bool> saveNote(NoteDetailDto note) async {
    await _noteBox.put(note.id, note);
    return true;
  }

  @override
  Stream<List<NoteDetailDto>> watchAllNotes() {
    return _noteBox.watch().map((_) => _noteBox.values.toList());
  }

  @override
  Future<void> deleteNote(String id) {
    return _noteBox.delete(id);
  }

  @override
  NoteDetailDto? findNote(String id) {
    return _noteBox.get(id);
  }
}
