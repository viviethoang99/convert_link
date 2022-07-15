import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../features/note/data/data.dart';

@module
abstract class StorageModule {
  @preResolve
  @lazySingleton
  @Named('noteBox')
  Future<Box<NoteDetailDto>> get noteBox {
    return Hive.openBox<NoteDetailDto>('noteBox');
  }

  @preResolve
  @lazySingleton
  @Named('settingBox')
  Future<Box> get settingBox {
    return Hive.openBox('settingBox');
  }

  @lazySingleton
  Uuid get uuid => const Uuid();
}
