import 'package:bloc_test/bloc_test.dart';
import 'package:convert_link/features/note/note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

void main() {
  group('$ConvertLinkCubit', (() {
    late ConvertLinkCubit convertLinkCubit;
    late NoteRepository noteRepository;
    late Uuid uuid;

    setUp(() {
      noteRepository = _MockNoteRepository();
      uuid = const Uuid();
      convertLinkCubit = ConvertLinkCubit(noteRepository, uuid);
    });

    tearDown((() => convertLinkCubit.close()));

    group('initLoading', () {
      blocTest<ConvertLinkCubit, ConvertLinkState>(
        'do not emit if no id is passed in',
        build: () => convertLinkCubit,
        act: (cubit) => cubit.initLoading(null),
        expect: () => [],
      );
      blocTest<ConvertLinkCubit, ConvertLinkState>(
        'will emit if an id is passed in',
        setUp: () => when(() => noteRepository.findNote('random-id'))
            .thenReturn(_MockNoteDetail()),
        build: () => convertLinkCubit,
        act: (cubit) => cubit.initLoading('random-id'),
        verify: (bloc) => expect(bloc.state.userInput.isNotEmpty, true),
      );
    });
  }));
}

class _MockNoteRepository extends Mock implements NoteRepository {}

class _MockNoteDetail extends Mock implements NoteDetail {
  @override
  final String id = '1';
  @override
  final String content = 'random';
  @override
  final DateTime createAt = DateTime.now();
}
