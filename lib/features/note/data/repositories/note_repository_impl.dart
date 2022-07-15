import 'package:injectable/injectable.dart';

import '../../note.dart';

@Injectable(as: NoteRepository)
class NoteRepositoryImpl implements NoteRepository {
  const NoteRepositoryImpl(
    this._localSource,
    this._incognitoLocalSource,
  );

  final NoteLocalSource _localSource;
  final IncognitoLocalSource _incognitoLocalSource;

  @override
  Future<void> deleteAllNotes() => _localSource.deleteAllNotes();

  @override
  Future<void> deleteNote(String id) {
    return _localSource.deleteNote(id);
  }

  @override
  Future<ListNoteDetails> findAll() async {
    final repository = await _localSource.findAllNotes();
    repository.sort((a, b) => b.createAt.compareTo(a.createAt));
    return repository.toEntities();
  }

  @override
  Future<bool> saveNote(NoteDetail note) async {
    final isSave = _incognitoLocalSource.getStatus();
    if (!isSave) {
      await _localSource.saveNote(NoteDetailDto.toNote(note));
      return true;
    }
    return false;
  }

  @override
  Stream<ListNoteDetails> watchAllNotes() {
    return _localSource.watchAllNotes().map((repository) {
      repository.sort((a, b) => b.createAt.compareTo(a.createAt));
      return repository.toEntities();
    });
  }

  @override
  NoteDetail? findNote(String id) {
    final data = _localSource.findNote(id);
    if (data == null) return null;
    return data.toEntity();
  }
}
