import 'package:collection/collection.dart';

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

  bool get isHTML {
    final regex = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    return regex.hasMatch(this);
  }

  int? toIntOrNull({int? radix}) => int.tryParse(this, radix: radix);

  bool get isInt => toIntOrNull() != null;
}

extension StringNhentaiExtension on String {
  String get toNhentai => 'nhentai.net/g/$this';

  List<String> getCodeHaiten() {
    final regExp = RegExp(r'([0-9]{6})');
    return regExp.allMatches(this).map((s) => s.group(0)!.toString()).toList();
  }

  bool get isUrlNhentai => contains('nhentai') || (length == 6 && isInt);
}

extension StringHexExtension on String {
  List<String> getHexCode() {
    final exp = RegExp(r'([a-fA-F0-9]{8})\w+');

    final matches = exp.allMatches(this);
    var listRegex = <String>[];
    for (var match in matches) {
      listRegex.add(substring(match.start, match.end));
    }
    return listRegex;
  }

  String get asciiToHex {
    var hex = StringBuffer();
    for (var char in codeUnits) {
      hex.write(char.toRadixString(16).padLeft(2, '0'));
    }
    return hex.toString().toUpperCase();
  }

  String get hexToAscii => List.generate(
        length ~/ 2,
        (i) => String.fromCharCode(
            int.parse(substring(i * 2, (i * 2) + 2), radix: 16)),
      ).join();
}

extension StringUrlExtension on String {
  String get addBrackets => addCharacter('(.)');

  String get addSpace => addCharacter(' .');

  String addCharacter(String char) {
    final listString = trim().split('.');
    return listString
        .mapIndexed((index, txt) {
          if (txt == listString.last) return txt;
          if (index < 2) return '$txt$char';
          return '$txt.';
        })
        .toList()
        .join();
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
}

extension ListUrlX on List<String> {
  bool get isUrlsNhentai {
    for (var url in this) {
      if (url.isUrlNhentai) return true;
    }
    return false;
  }
}
