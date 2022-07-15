import 'package:bloc_test/bloc_test.dart';
import 'package:convert_link/app/app.dart';
import 'package:convert_link/config/config.dart';
import 'package:convert_link/features/note/note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late IncognitoModeCubit incognitoModeCubit;
  late ConvertLinkCubit convertLinkCubit;

  setUp(() {
    incognitoModeCubit = _MockIncognitoModeCubit();
    convertLinkCubit = _MockConvertLinkCubit();
    getIt.registerFactory(() => incognitoModeCubit);
    getIt.registerFactory(() => convertLinkCubit);
  });

  tearDown(getIt.reset);

  group('$App', () {
    testWidgets('renders App and navigates to the convert screen',
        (tester) async {
      when(() => incognitoModeCubit.state).thenReturn(IncognitoModeState.on);
      when(incognitoModeCubit.initialize).thenAnswer((_) => Future.value());
      when(() => convertLinkCubit.initLoading(null))
          .thenAnswer((_) => Future.value());
      when(() => convertLinkCubit.state).thenReturn(const ConvertLinkState());

      await tester.runAsync((() async {
        await tester.pumpWidget(const App());
        await tester.pump();
      })).then((_) {
        expect(find.byType(App), findsOneWidget);
        expect(find.byType(ConvertLinkScreen), findsOneWidget);
      });
    });
  });
}

class _MockIncognitoModeCubit extends MockCubit<IncognitoModeState>
    implements IncognitoModeCubit {}

class _MockConvertLinkCubit extends MockCubit<ConvertLinkState>
    implements ConvertLinkCubit {}
