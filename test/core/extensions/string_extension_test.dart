import 'package:convert_link/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringExtension', () {
    test('.encode', () {
      const url = 'irohasu.xyz';
      const code = '193262';
      expect(url.encode(ConvertType.hex), '69726F686173752E78797A');
      expect(code.encode(ConvertType.nhentai), 'nhentai.net/g/193262');
      expect(url.encode(ConvertType.addCharacter), 'irohasu(.)xyz');
      expect(url.encode(ConvertType.addSpace), 'irohasu .xyz');
    });

    test('.capitalize()', () {
      expect(''.capitalize(), '');
      expect('193262'.capitalize(), '193262');
      expect('i'.capitalize(), 'I');
      expect('iroha'.capitalize(), 'Iroha');
      expect('Iroha'.capitalize(), 'Iroha');
    });

    test('.toIntOrNull()', () {
      expect(''.toIntOrNull(), null);
      expect('i'.isInt, false);
      expect('iroha'.isInt, false);
      expect('1.0'.toIntOrNull(), null);
      expect('1'.toIntOrNull(), 1);
      expect('123456789'.toIntOrNull(), 123456789);
    });

    test('.isInt', () {
      expect(''.isInt, false);
      expect('i'.isInt, false);
      expect('iroha'.isInt, false);
      expect('1.0'.isInt, false);
      expect('1'.isInt, true);
      expect('123456789'.isInt, true);
    });
  });

  group('StringNhentaiExtension', () {
    test('.toNhentai', () {
      expect('193262'.toNhentai, 'nhentai.net/g/193262');
      expect('123456'.toNhentai, 'nhentai.net/g/123456');
    });

    test('.getCodeHaiten()', () {
      const txt1 = 'Tôi đã đọc bộ này 125252 lần.';
      const txt2 = 'Tôi đã nghe cái này 125256 lần và biết 21521 lần.';
      const txt3 = 'Tôi đã đọc manga này 2152 lần';
      const txt4 = 'Tôi đã nghe cái này 125256 lần và biết 821521 lần.';

      expect(''.getCodeHaiten(), []);
      expect(txt1.getCodeHaiten(), ['125252']);
      expect(txt2.getCodeHaiten(), ['125256']);
      expect(txt3.getCodeHaiten(), []);
      expect(txt4.getCodeHaiten(), ['125256', '821521']);
    });

    test('.isUrlNhentai', () {
      expect('i'.isUrlNhentai, false);
      expect('iroha'.isUrlNhentai, false);
      expect('1.0'.isUrlNhentai, false);
      expect('1'.isUrlNhentai, false);
      expect('123456789'.isUrlNhentai, false);
      expect('193262'.isUrlNhentai, true);
      expect('nhentai.net/g/193262'.isUrlNhentai, true);
      expect('irohasu.net/g/193262'.isUrlNhentai, false);
    });

    test('.isUrlsNhentai', () {
      expect(['Method nothing', 'test'].isUrlsNhentai, false);
      expect(['125256', 'test'].isUrlsNhentai, true);
      expect(['nhentai.net/g/193262', 'test'].isUrlsNhentai, true);
      expect(['i', 'a', '123456'].isUrlsNhentai, true);
    });
  });
}
