import 'package:bloc_test/bloc_test.dart';
import 'package:convert_link/config/config.dart';
import 'package:convert_link/core/core.dart';
import 'package:convert_link/features/note/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late NoteCubit noteCubit;
  late IncognitoModeCubit incognitoModeCubit;

  setUpAll(() => registerFallbackValue(NoteInitial()));

  setUp(() {
    noteCubit = _MockNoteCubit();
    incognitoModeCubit = _MockIncognitoCubit();
    getIt.registerFactory(() => noteCubit);
  });

  testWidgets('Renders $ListNoteScreen', (tester) async {
    when(noteCubit.watchAllNotes).thenAnswer((_) async => Future.value());
    when(() => noteCubit.state).thenReturn(NoteInitial());
    when(() => incognitoModeCubit.state).thenReturn(IncognitoModeState.on);

    const convertScreenKey = Key('CONVERT_SCREEN');

    final router = GoRouter(
      initialLocation: AppPage.listNotes.path,
      routes: <GoRoute>[
        GoRoute(
          path: AppPage.convert.path,
          name: AppPage.convert.nameRouter,
          pageBuilder: (context, state) => const MaterialPage(
            child: SizedBox.shrink(
              key: convertScreenKey,
            ),
          ),
        ),
        GoRoute(
          path: AppPage.listNotes.path,
          name: AppPage.listNotes.nameRouter,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: BlocProvider.value(
              value: incognitoModeCubit,
              child: const ListNoteScreen(),
            ),
          ),
        ),
      ],
      errorPageBuilder: (context, state) => MaterialPage(
        child: ErrorScreen(error: state.error),
      ),
    );
    await tester.runAsync((() async {
      await tester.pumpWidget(
        MaterialApp.router(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          debugShowCheckedModeBanner: false,
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
        ),
      );
      await tester.pump();
    })).then((_) {
      expect(find.byType(SpeedDialWidget), findsOneWidget);
      expect(find.byType(AppBarListNote), findsOneWidget);
      expect(find.byType(NotesWidget), findsOneWidget);
    });
  });
}

class _MockNoteCubit extends MockCubit<NoteState> implements NoteCubit {}

class _MockIncognitoCubit extends MockCubit<IncognitoModeState>
    implements IncognitoModeCubit {}
