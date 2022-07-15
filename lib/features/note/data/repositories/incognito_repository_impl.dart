import 'package:injectable/injectable.dart';

import '../../note.dart';

@Injectable(as: IncognitoRepository)
class IncognitoRepositoryImpl implements IncognitoRepository {
  const IncognitoRepositoryImpl(this._localSource);

  final IncognitoLocalSource _localSource;

  @override
  bool getStatus() {
    return _localSource.getStatus();
  }

  @override
  Future<void> setStatus(bool value) {
    return _localSource.setStatus(value);
  }

  @override
  Stream<bool> watchStatus() {
    return _localSource.watchStatus();
  }
}
