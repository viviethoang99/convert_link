import 'package:bloc_test/bloc_test.dart';
import 'package:convert_link/features/note/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  group('$AppBarListNote', () {
    late NoteCubit noteCubit;

    setUpAll(() => registerFallbackValue(NoteInitial()));

    setUp(() {
      noteCubit = _MockNoteCubit();
    });
    testWidgets('renders $AppBarListNote when NoteInitial', (tester) async {
      when(() => noteCubit.state).thenReturn(NoteInitial());
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: noteCubit,
            child: const Scaffold(
              appBar: AppBarListNote(),
            ),
          ),
        ),
      );
      expect(find.byType(AppBarListNote), findsOneWidget);
      expect(find.text('Xoá toàn bộ ghi chú'), findsNothing);
      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('renders $AppBarListNote when NoteSuccess list is empty',
        (tester) async {
      when(() => noteCubit.state).thenReturn(const NoteSuccess([]));
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: noteCubit,
            child: const Scaffold(
              appBar: AppBarListNote(),
            ),
          ),
        ),
      );
      expect(find.byType(AppBarListNote), findsOneWidget);
      expect(find.text('Xoá toàn bộ ghi chú'), findsNothing);
      expect(find.byType(TextButton), findsNothing);
    });

    testWidgets('renders $AppBarListNote when NoteSuccess list is not empty',
        (tester) async {
      when(() => noteCubit.state).thenReturn(NoteSuccess([_FakeNoteDetail()]));
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: noteCubit,
            child: const Scaffold(
              appBar: AppBarListNote(),
            ),
          ),
        ),
      );
      expect(find.byType(AppBarListNote), findsOneWidget);
      expect(find.text('Xoá toàn bộ ghi chú'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('renders dialog when on tap', (tester) async {
      when(() => noteCubit.state).thenReturn(NoteSuccess([_FakeNoteDetail()]));
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: noteCubit,
            child: const Scaffold(
              appBar: AppBarListNote(),
            ),
          ),
        ),
      );
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);

      // Content
      expect(find.text('Xoá toàn bộ ghi chú'), findsWidgets);
      expect(
        find.text(
            'Bạn chắc muốn xoá toàn bộ ghi chú trong ứng dụng của mình chứ?'),
        findsOneWidget,
      );
      expect(find.text('Không xoá nữa'), findsOneWidget);
      expect(find.text('Xoá chứ'), findsOneWidget);

      // Check button
      expect(find.byType(TextButton), findsWidgets);
    });

    testWidgets('on tap clear all data', (tester) async {
      when(() => noteCubit.state).thenReturn(NoteSuccess([_FakeNoteDetail()]));
      when(() => noteCubit.deleteAllNote(true))
          .thenAnswer((_) => Future.value());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: noteCubit,
            child: const Scaffold(
              appBar: AppBarListNote(),
            ),
          ),
        ),
      );

      // Show Dialog
      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsOneWidget);

      // On tap clear all data
      await tester.tap(find.text('Xoá chứ'));
      await tester.pumpAndSettle();

      // Check dialog close
      expect(find.byType(AlertDialog), findsNothing);

      verify(() => noteCubit.deleteAllNote(true)).called(1);
    });
  });
}

class _MockNoteCubit extends MockCubit<NoteState> implements NoteCubit {}

class _FakeNoteDetail extends Fake implements NoteDetail {}
