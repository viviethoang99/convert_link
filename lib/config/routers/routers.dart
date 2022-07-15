import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/core.dart';
import '../../features/note/note.dart';

class AppRouter {
  const AppRouter._();

  static final router = GoRouter(
    initialLocation: AppPage.convert.path,
    routes: <GoRoute>[
      GoRoute(
        path: AppPage.convert.path,
        name: AppPage.convert.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ConvertLinkScreen(),
        ),
      ),
      GoRoute(
        path: AppPage.listNotes.path,
        name: AppPage.listNotes.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ListNoteScreen(),
        ),
        routes: [
          GoRoute(
            path: AppPage.detail.path,
            name: AppPage.detail.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: ConvertLinkScreen(id: state.params['fid']),
            ),
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      child: ErrorScreen(
        error: state.error,
      ),
    ),
    redirect: (state) => null,
    navigatorBuilder: (context, state, child) {
      return child;
    },
    debugLogDiagnostics: true,
  );

  static void setUrlPathStrategy() {
    GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key, this.error}) : super(key: key);

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const CloseButton()),
      body: const Center(
        child: Text('Something went wrong!'),
      ),
    );
  }
}
