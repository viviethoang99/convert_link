import 'package:bloc_test/bloc_test.dart';
import 'package:convert_link/features/note/note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$NoteCubit', () {
    late NoteCubit noteCubit;
    late NoteRepository noteRepository;

    setUp(() {
      noteRepository = _MockNoteRepository();
      noteCubit = NoteCubit(noteRepository);
    });

    tearDown((() => noteCubit.close()));

    group('loadAllNotes', () {
      blocTest<NoteCubit, NoteState>(
        'should emit [NoteInitial, NoteSuccess] when all note loaded and '
        'empty list',
        build: () => noteCubit,
        setUp: () => when(noteRepository.findAll).thenAnswer((_) async => []),
        act: (cubit) => cubit.loadAllNotes(),
        expect: () => [NoteInitial(), const NoteSuccess([])],
      );
      final notes = <NoteDetail>[_FakeNoteDetail()];
      blocTest<NoteCubit, NoteState>(
        'should emit [NoteInitial, NoteSuccess] when all note loaded and '
        'is not empty',
        build: () => noteCubit,
        setUp: () =>
            when(noteRepository.findAll).thenAnswer((_) async => notes),
        act: (cubit) => cubit.loadAllNotes(),
        expect: () => [NoteInitial(), NoteSuccess(notes)],
      );
    });

    group('deleteNote', () {
      final notes = <NoteDetail>[_FakeNoteDetail()];
      blocTest<NoteCubit, NoteState>(
        'should emit [ '
        'NoteInitial, '
        'NoteSuccess(notes), '
        'NoteSuccess([])'
        '] when album is loaded and deleted',
        setUp: () {
          when(noteRepository.findAll).thenAnswer((_) async => notes);
          when(() => noteRepository.deleteNote('random-id'))
              .thenAnswer((_) async => notes.removeLast());
        },
        build: () => noteCubit,
        act: (cubit) async {
          await cubit.loadAllNotes();
          await cubit.deleteNote('random-id');
        },
        expect: () => [
          NoteInitial(),
          NoteSuccess(notes),
        ],
      );
    });

    group('watchAllNotes', () {
      final notes = <NoteDetail>[_FakeNoteDetail()];
      blocTest<NoteCubit, NoteState>(
        'should emit ['
        'NoteInitial, '
        'NoteSuccess, '
        'NoteSuccess'
        '] when all note are loaded and a new event is emitted',
        setUp: () {
          when(noteRepository.findAll).thenAnswer((_) async => []);
          when(noteRepository.watchAllNotes)
              .thenAnswer((_) => Stream.value(notes));
        },
        build: () => noteCubit,
        act: (cubit) => cubit.watchAllNotes(),
        expect: () => [
          NoteInitial(),
          const NoteSuccess([]),
          NoteSuccess(notes),
        ],
      );
    });

    group('deleteAllNote', () {
      blocTest<NoteCubit, NoteState>(
        'should emit [ AllAlbumsLoaded ] when all notes are deleted',
        build: () => noteCubit,
        setUp: () => when(noteRepository.deleteAllNotes).thenAnswer(
          (_) => Future.value(),
        ),
        act: (cubit) => cubit.deleteAllNote(true),
        expect: () => [],
      );
    });
  });
}

class _MockNoteRepository extends Mock implements NoteRepository {}

class _FakeNoteDetail extends Fake implements NoteDetail {}
