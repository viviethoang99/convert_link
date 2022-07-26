import 'package:convert_link/core/extension/extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DateTimeX', () {
    test('.toFormat()', () {
      final dentistAppointment = DateTime(2017, 9, 7, 17, 30);
      expect(dentistAppointment.toFormat(), '17:30 07-09-2017');
    });
  });
}
