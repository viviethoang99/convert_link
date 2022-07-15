import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

const _incognitoKey = 'INCOGNITO_KEY';

abstract class IncognitoLocalSource {
  bool getStatus();

  Future<void> setStatus(bool value);

  Stream<bool> watchStatus();
}

@Injectable(as: IncognitoLocalSource)
class IncognitoLocalSourceImpl implements IncognitoLocalSource {
  const IncognitoLocalSourceImpl(
    @Named('settingBox') this._box,
  );

  final Box _box;

  @override
  bool getStatus() {
    return _box.get(_incognitoKey);
  }

  @override
  Future<void> setStatus(bool value) {
    return _box.put(_incognitoKey, value);
  }

  @override
  Stream<bool> watchStatus() {
    return _box.watch(key: _incognitoKey).map((_) => getStatus());
  }
}
