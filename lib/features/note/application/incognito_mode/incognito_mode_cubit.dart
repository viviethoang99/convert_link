import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../note.dart';

part 'incognito_mode_state.dart';

@injectable
class IncognitoModeCubit extends Cubit<IncognitoModeState> {
  IncognitoModeCubit(this._repository) : super(IncognitoModeState.off);

  final IncognitoRepository _repository;
  StreamSubscription? _streamSubscription;

  void initialize() {
    _repository.setStatus(false);
    getStatus();
    watchStatus();
  }

  void getStatus() {
    final isIncognitoMode = _repository.getStatus();
    emit(isIncognitoMode ? IncognitoModeState.on : IncognitoModeState.off);
  }

  Future<void> watchStatus() async {
    _streamSubscription ??= _repository
        .watchStatus()
        .map((value) => value ? IncognitoModeState.on : IncognitoModeState.off)
        .listen(emit);
  }

  void onTap() {
    if (state == IncognitoModeState.on) {
      _repository.setStatus(false);
    } else {
      _repository.setStatus(true);
    }
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }
}
