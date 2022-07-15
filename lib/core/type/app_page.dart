enum AppPage {
  convert(
    path: '/',
    name: 'CONVERT_SCREEN',
  ),
  listNotes(
    path: '/listNotes',
    name: 'LIST_NOTES_SCREEN',
  ),
  setting(
    path: '/setting',
    name: 'SETTING_SCREEN',
  ),
  detail(
    path: 'detail/:fid',
    name: 'detail',
  ),
  error(
    path: '/error',
    name: 'ERROR_SCREEN',
  );

  const AppPage({
    required this.path,
    required this.name,
  });

  final String path;
  final String name;
}
