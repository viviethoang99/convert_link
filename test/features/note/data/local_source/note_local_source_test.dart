import 'package:convert_link/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$NoteLocalSource', () {
    late Box<NoteDetailDto> notesBox;
    late NoteLocalSourceImpl noteLocalSourceImpl;

    setUp(() {
      notesBox = _MockNoteBox();
      noteLocalSourceImpl = NoteLocalSourceImpl(notesBox);
    });

    group('deleteNote', () {
      test('should delete a note from the storage', () async {
        const id = 'random-key';
        when(() => notesBox.delete(id)).thenAnswer((_) => Future.value());

        await notesBox.delete(id);

        verify(() => notesBox.delete(id)).called(1);
      });
    });

    group('deleteAllNotes', () {
      test('should delete all notes from the $Box', () async {
        when(notesBox.clear).thenAnswer((_) async => 0);

        await noteLocalSourceImpl.deleteAllNotes();

        verify(notesBox.clear).called(1);
      });
    });

    group('findNote', () {
      test('should find and return note by id', () async {
        const id = 'random-key';
        final note = _FakeNoteDetailDto();
        when(() => notesBox.get(id)).thenReturn(note);

        final response = noteLocalSourceImpl.findNote(id);

        expect(response, note);
      });
    });

    group('findAllNotes', () {
      test('should return all stored notes', () async {
        final notes = <NoteDetailDto>[_FakeNoteDetailDto()];
        when(() => notesBox.values).thenReturn(notes);

        final response = await noteLocalSourceImpl.findAllNotes();

        expect(response, notes);
      });
    });

    group('saveNote', () {
      test('should store an album to the storage', () async {
        const id = 'random-key';
        final note = _MockNoteDetailDto();
        when(() => note.id).thenReturn(id);
        when(() => notesBox.put(id, note)).thenAnswer((_) => Future.value());

        final response = await noteLocalSourceImpl.saveNote(note);

        expect(response, true);
        verify(() => notesBox.put(id, note)).called(1);
      });
    });

    group('watchAllNotes', () {
      test('should emit list of notes when a new album is stored', () async {
        final notes = <NoteDetailDto>[_FakeNoteDetailDto()];
        final event = BoxEvent(0, _FakeNoteDetailDto(), false);

        when(() => notesBox.values).thenReturn(notes);
        when(notesBox.watch).thenAnswer((_) => Stream.value(event));

        await expectLater(
          noteLocalSourceImpl.watchAllNotes(),
          emitsInOrder([equals(notes), emitsDone]),
        );
      });
    });
  });
}

class _MockNoteBox extends Mock implements Box<NoteDetailDto> {}

class _MockNoteDetailDto extends Mock implements NoteDetailDto {}

class _FakeNoteDetailDto extends Fake implements NoteDetailDto {}
