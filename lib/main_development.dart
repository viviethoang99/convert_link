import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';
import 'bootstrap.dart';
import 'config/config.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await registerDependencies();
  AppRouter.setUrlPathStrategy();
  await bootstrap(() => const App());
}
