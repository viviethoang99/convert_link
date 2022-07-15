import 'package:convert_link/features/note/note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$NoteRepositoryImpl', () {
    late NoteLocalSource noteLocalSource;
    late IncognitoLocalSource incognitoLocalSource;
    late NoteRepositoryImpl noteRepositoryImpl;

    setUp(() {
      noteLocalSource = _MockNoteLocalSource();
      incognitoLocalSource = _MockIncognitoLocalSource();
      noteRepositoryImpl = NoteRepositoryImpl(
        noteLocalSource,
        incognitoLocalSource,
      );
    });

    group('deleteAllNotes', () {
      test('should delete all notes from the local source', () {
        when(noteLocalSource.deleteAllNotes)
            .thenAnswer((_) async => Future.value());

        noteRepositoryImpl.deleteAllNotes();

        verify(noteRepositoryImpl.deleteAllNotes).called(1);
      });
    });

    group('deleteNote', () {
      test('should delete all albums from the local source', () {
        when(() => noteLocalSource.deleteNote('random-id'))
            .thenAnswer((_) => Future.value());

        noteRepositoryImpl.deleteNote('random-id');

        verify(() => noteRepositoryImpl.deleteNote('random-id')).called(1);
      });
    });

    group('findAll', () {
      test('should return AlbumDetails stored in local source', () async {
        final list = <NoteDetail>[_FakeNoteDetail()];
        final listDto = <NoteDetailDto>[
          _FakeNoteDetailDto(list.first),
        ];
        when(noteLocalSource.findAllNotes).thenAnswer((_) async => listDto);

        final repository = await noteRepositoryImpl.findAll();

        expect(repository, list);
      });
    });

    group('saveNote', () {
      test('Should not be saved if the user has enabled incognito mode',
          () async {
        final note = _FakeNoteDetail();
        when(incognitoLocalSource.getStatus).thenReturn(true);
        final reponsitory = await noteRepositoryImpl.saveNote(note);
        expect(reponsitory, false);
      });
      // test('User notes should be saved if incognito mode is not enabled',
      //     () async {
      //   final note = _FakeNoteDetail();
      //   when(incognitoLocalSource.getStatus).thenReturn(false);
      //   when(() => noteLocalSource.saveNote(NoteDetailDto.toNote(note)))
      //       .thenAnswer((_) async => true);

      //   final response = await noteRepositoryImpl.saveNote(note);

      //   expect(response, true);
      // });
    });

    group('watchAllNotes', () {
      test('should emit Notes by watching all notes in the local storage',
          () async {
        final list = <NoteDetail>[_FakeNoteDetail()];
        final listDto = <NoteDetailDto>[
          _FakeNoteDetailDto(list.first),
        ];
        when(noteLocalSource.watchAllNotes).thenAnswer(
          (_) => Stream.value(listDto),
        );
        await expectLater(
          noteRepositoryImpl.watchAllNotes(),
          emitsInOrder([list, emitsDone]),
        );
      });
    });

    group('findNote', () {
      test('should return NoteDetail when found', () async {
        final note = _FakeNoteDetail();
        final noteDto = _FakeNoteDetailDto(note);
        when(() => noteLocalSource.findNote('random-id'))
            .thenAnswer((_) => noteDto);

        final repository = noteRepositoryImpl.findNote('random-id');

        expect(repository, note);
      });

      test('should return null when not found', () async {
        when(() => noteLocalSource.findNote('random-id'))
            .thenAnswer((_) => null);

        final repository = noteRepositoryImpl.findNote('random-id');

        expect(repository, null);
      });
    });
  });
}

class _MockNoteLocalSource extends Mock implements NoteLocalSource {}

class _MockIncognitoLocalSource extends Mock implements IncognitoLocalSource {}

class _FakeNoteDetail extends Fake implements NoteDetail {
  @override
  final String id = '1';
  @override
  final String content = 'dasdsa';
  @override
  final DateTime createAt = DateTime(2020);

  @override
  List<Object?> get props => [id, content];
}

class _FakeNoteDetailDto extends Fake implements NoteDetailDto {
  _FakeNoteDetailDto(this.note);

  final NoteDetail note;

  @override
  NoteDetail toEntity() => note;
}