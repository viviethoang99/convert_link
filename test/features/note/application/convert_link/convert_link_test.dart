import 'package:bloc_test/bloc_test.dart';
import 'package:convert_link/features/note/note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:uuid/uuid.dart';

part 'convert_link_fixture.dart';

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
            .thenAnswer((_) => _listData.first),
        build: () => convertLinkCubit,
        act: (cubit) => cubit.initLoading('random-id'),
        verify: (bloc) => expect(bloc.state.originalUrl.isNotEmpty, true),
      );
    });
  }));
}

class _MockNoteRepository extends Mock implements NoteRepository {}
