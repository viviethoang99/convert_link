import '../../note.dart';

abstract class NoteRepository {
  /// Deletes an [ListNoteDetails] with given [query] from the local source.
  Future<void> deleteNote(String id);

  /// Removes all stored [ListNoteDetails] from the local storage.
  Future<void> deleteAllNotes();

  /// Returns all [ListNoteDetails] stored in the local storage.
  Future<ListNoteDetails> findAll();

  //
  Future<bool> saveNote(NoteDetail note);

  /// Returns stream of [AlbumDetail] by listening to updates in the local
  /// storage.
  Stream<ListNoteDetails> watchAllNotes();

  NoteDetail? findNote(String id);
}
