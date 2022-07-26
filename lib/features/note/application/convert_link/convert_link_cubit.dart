import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/core.dart';
import '../../note.dart';

part 'convert_link_state.dart';

@injectable
class ConvertLinkCubit extends Cubit<ConvertLinkState> {
  ConvertLinkCubit(
    this._noteRepository,
    this._uuid,
  ) : super(const ConvertLinkState());

  final NoteRepository _noteRepository;
  final Uuid _uuid;

  Future<void> initLoading(String? id) async {
    if (id?.isNotEmpty ?? false) {
      final content = _noteRepository.findNote(id!)?.content ?? '';
      await Future.delayed(const Duration(milliseconds: 300));
      changeTextField(content);
    }
  }

  void changeTextField(String input) {
    emit(ConvertLinkState(userInput: input));
    findUrl(deleteSpecialCharacters(input));
    if (state.originalUrl.isEmpty) findHex(input);
    if (state.originalUrl.isEmpty) findCode(input);
  }

  Future<void> getDataFromClipboard() async {
    final cdata = await Clipboard.getData(Clipboard.kTextPlain);
    final copiedText = cdata?.text ?? '';
    changeTextField(copiedText);
    unawaited(saveLink());
  }

  Future<void> onSave() => saveLink();

  Future<void> saveLink() async {
    if (state.originalUrl.isNotEmpty) {
      final key = _uuid.v4();
      final data = state.userInput.toNoteModel(key);
      unawaited(_noteRepository.saveNote(data));
    }
  }

  String deleteSpecialCharacters(String text) {
    final specialCharactersRE = RegExp(r'(\s*)[({\[](.*?)[})\]](\s*)');
    return text.replaceAll(specialCharactersRE, '.');
  }

  void findUrl(String text) {
    final listUrl = text.getUrl();
    emit(ConvertLinkState(originalUrl: listUrl, userInput: state.userInput));
  }

  void findHex(String text) {
    final listUrl = text.getHexCode().map((hex) => hex.hexToAscii).toList();
    emit(ConvertLinkState(originalUrl: listUrl, userInput: state.userInput));
  }

  void findCode(String text) {
    final listUrl = text.getCodeHaiten();
    emit(ConvertLinkState(originalUrl: listUrl, userInput: state.userInput));
  }

  void clearData() {
    emit(const ConvertLinkState());
  }

  void copyToClipboard(String value) {
    Clipboard.setData(ClipboardData(text: value));
  }
}

extension on String {
  NoteDetail toNoteModel(String key) {
    return NoteDetail(
      id: key,
      content: toString(),
      createAt: DateTime.now(),
    );
  }
}
