import 'package:bloc_test/bloc_test.dart';
import 'package:convert_link/features/note/note.dart';
import 'package:convert_link/features/note/presentation/list_note/widgets/note_list_empty.dart';
import 'package:convert_link/features/note/presentation/list_note/widgets/note_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$NoteListView', () {
    late NoteCubit noteCubit;
    late NoteDetails noteDetails;

    setUpAll(() => registerFallbackValue(NoteInitial()));

    setUp(() {
      noteCubit = _MockNoteCubit();
      noteDetails = [_FakeNoteDetail()];
    });
    testWidgets('renders $AppBarListNote when list is empty', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: noteCubit,
            child: const Scaffold(
              body: NoteListView(),
            ),
          ),
        ),
      );
      expect(find.byType(NoteListView), findsOneWidget);
      expect(find.byType(ListNoteEmpty), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets('renders $AppBarListNote when list is not empty',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: noteCubit,
            child: Scaffold(
              body: NoteListView(
                noteDetails: noteDetails,
              ),
            ),
          ),
        ),
      );
      expect(find.byType(NoteListView), findsOneWidget);
      expect(find.byType(ListNoteEmpty), findsNothing);
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}

class _MockNoteCubit extends MockCubit<NoteState> implements NoteCubit {}

class _FakeNoteDetail extends Fake implements NoteDetail {
  @override
  final String id = '1';
  @override
  final String content = 'Hello world';
  @override
  final DateTime createAt = DateTime.now();
}
