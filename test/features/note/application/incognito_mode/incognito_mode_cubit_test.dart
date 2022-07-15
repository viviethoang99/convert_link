import 'package:bloc_test/bloc_test.dart';
import 'package:convert_link/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late IncognitoRepository repository;
  late IncognitoModeCubit incognitoModeCubit;

  setUp(() {
    repository = _MockIncognitoRepository();
    incognitoModeCubit = IncognitoModeCubit(repository);
  });

  tearDown((() => incognitoModeCubit.close()));

  group('initialize', () {});

  group('initialize', () {
    blocTest<IncognitoModeCubit, IncognitoModeState>(
      'should emit ['
      'IncognitoModeState.on, '
      'IncognitoModeState.off, '
      '] when value are loaded and a new event is emitted',
      setUp: () {
        when(repository.getStatus).thenReturn(true);
        when(() => repository.setStatus(false))
            .thenAnswer((_) async => Future.value());
        when(repository.watchStatus).thenAnswer((_) => Stream.value(false));
      },
      build: () => incognitoModeCubit,
      act: (cubit) => cubit.initialize(),
      expect: () => [
        IncognitoModeState.on,
        IncognitoModeState.off,
      ],
    );
  });

  group('onTap', () {
    test('Shold call setStatus is true when state == IncognitoModeState.off',
        () async {
      when(() => repository.setStatus(false))
          .thenAnswer((_) async => Future.value());
      when(() => repository.setStatus(true))
          .thenAnswer((_) async => Future.value());

      incognitoModeCubit.onTap();

      verifyNever(() => repository.setStatus(false));
      verify(() => repository.setStatus(true)).called(1);
    });
  });
}

class _MockIncognitoRepository extends Mock implements IncognitoRepository {}
