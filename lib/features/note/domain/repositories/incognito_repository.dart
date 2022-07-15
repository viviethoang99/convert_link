abstract class IncognitoRepository {
  bool getStatus();

  Future<void> setStatus(bool value);

  Stream<bool> watchStatus();
}
