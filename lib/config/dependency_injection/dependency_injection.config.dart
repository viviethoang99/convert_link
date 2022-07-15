// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i6;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:uuid/uuid.dart' as _i11;

import '../../features/note/application/convert_link/convert_link_cubit.dart'
    as _i12;
import '../../features/note/application/incognito_mode/incognito_mode_cubit.dart'
    as _i13;
import '../../features/note/application/note/note_cubit.dart' as _i14;
import '../../features/note/data/data.dart' as _i4;
import '../../features/note/data/local_sources/incognito_local_source.dart'
    as _i5;
import '../../features/note/data/local_sources/note_local_source.dart' as _i9;
import '../../features/note/data/repositories/incognito_repository_impl.dart'
    as _i8;
import '../../features/note/data/repositories/note_repository_impl.dart'
    as _i10;
import '../../features/note/note.dart' as _i7;
import 'modules/storage_module.dart'
    as _i15; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $registerDependencies(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final storageModule = _$StorageModule();
  await gh.lazySingletonAsync<_i3.Box<_i4.NoteDetailDto>>(
      () => storageModule.noteBox,
      instanceName: 'noteBox',
      preResolve: true);
  await gh.lazySingletonAsync<_i3.Box<dynamic>>(() => storageModule.settingBox,
      instanceName: 'settingBox', preResolve: true);
  gh.factory<_i5.IncognitoLocalSource>(() => _i5.IncognitoLocalSourceImpl(
      get<_i6.Box<dynamic>>(instanceName: 'settingBox')));
  gh.factory<_i7.IncognitoRepository>(
      () => _i8.IncognitoRepositoryImpl(get<_i7.IncognitoLocalSource>()));
  gh.factory<_i9.NoteLocalSource>(() => _i9.NoteLocalSourceImpl(
      get<_i6.Box<_i4.NoteDetailDto>>(instanceName: 'noteBox')));
  gh.factory<_i7.NoteRepository>(() => _i10.NoteRepositoryImpl(
      get<_i7.NoteLocalSource>(), get<_i7.IncognitoLocalSource>()));
  gh.lazySingleton<_i11.Uuid>(() => storageModule.uuid);
  gh.factory<_i12.ConvertLinkCubit>(
      () => _i12.ConvertLinkCubit(get<_i7.NoteRepository>(), get<_i11.Uuid>()));
  gh.factory<_i13.IncognitoModeCubit>(
      () => _i13.IncognitoModeCubit(get<_i7.IncognitoRepository>()));
  gh.factory<_i14.NoteCubit>(() => _i14.NoteCubit(get<_i7.NoteRepository>()));
  return get;
}

class _$StorageModule extends _i15.StorageModule {}
