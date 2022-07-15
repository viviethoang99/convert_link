enum AppPage {
  convert(
    path: '/',
    nameRouter: 'CONVERT_SCREEN',
  ),
  listNotes(
    path: '/listNotes',
    nameRouter: 'LIST_NOTES_SCREEN',
  ),
  setting(
    path: '/setting',
    nameRouter: 'SETTING_SCREEN',
  ),
  detail(
    path: 'detail/:fid',
    nameRouter: 'detail',
  ),
  error(
    path: '/error',
    nameRouter: 'ERROR_SCREEN',
  );

  const AppPage({
    required this.path,
    required this.nameRouter,
  });

  final String path;
  final String nameRouter;
}
