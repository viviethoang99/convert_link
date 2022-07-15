import 'package:convert_link/config/config.dart';
import 'package:convert_link/core/core.dart';
import 'package:convert_link/features/note/presentation/list_note/widgets/note_list_empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  group('$ListNoteEmpty', () {
    testWidgets('renders $ListNoteEmpty', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: ListNoteEmpty(),
        ),
      );
      expect(find.byType(ListNoteEmpty), findsOneWidget);
      expect(find.text('Không có bản ghi nào.'), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('tapping the widget should navigate to convert link screen',
        (tester) async {
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
              child: const ListNoteEmpty(),
            ),
          ),
        ],
        errorPageBuilder: (context, state) => MaterialPage(
          child: ErrorScreen(error: state.error),
        ),
      );
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

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      expect(find.byKey(convertScreenKey), findsOneWidget);
    });
  });
}
