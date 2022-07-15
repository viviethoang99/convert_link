// ignore: implementation_imports, depend_on_referenced_packages
import 'package:collection/src/list_extensions.dart';

import '../core.dart';

extension StringExtension on String {
  String encode(ConvertType type) {
    switch (type) {
      case ConvertType.hex:
        return asciiToHex;
      case ConvertType.nhentai:
        return toNhentai;
      case ConvertType.addCharacter:
        return addBrackets;
      case ConvertType.addSpace:
        return addSpace;
      default:
        return this;
    }
  }

  String capitalize() {
    return (length > 0) ? '${this[0].toUpperCase()}${substring(1)}' : this;
  }

  String get asciiToHex {
    var hex = StringBuffer();
    for (var char in codeUnits) {
      hex.write(char.toRadixString(16).padLeft(2, '0'));
    }
    return hex.toString();
  }

  String get hexToAscii => List.generate(
        length ~/ 2,
        (i) => String.fromCharCode(
            int.parse(substring(i * 2, (i * 2) + 2), radix: 16)),
      ).join();

  bool get isHTML {
    final regex = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    return regex.hasMatch(this);
  }

  String get toNhentai => 'nhentai.net/g/$this';

  String get addBrackets => addCharacter('(.)');

  String get addSpace => addCharacter(' .');

  String addCharacter(String char) {
    final edit = trim()
        .split('.')
        .mapIndexed((i, e) => i < 2 ? '$e$char' : '$e.')
        .toList()
        .join();
    return edit.substring(0, edit.length - 1);
  }

  List<String> getUrl() {
    final exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    final matches = exp.allMatches(this);
    var listUrl = <String>[];
    for (var match in matches) {
      final url = substring(match.start, match.end);
      if (url.length > 5) {
        listUrl.add(url);
      }
    }
    return listUrl;
  }

  List<String> getHexCode() {
    final exp = RegExp(r'([a-fA-F0-9]{8})\w+');
    final matches = exp.allMatches(this);
    var listRegex = <String>[];
    for (var match in matches) {
      listRegex.add(substring(match.start, match.end));
    }
    return listRegex;
  }
}
