import 'package:flutter_test/flutter_test.dart';
import 'package:usedev_uninassau/main.dart';
import 'package:usedev_uninassau/src/screens/initial_screen.dart';

void main() {
  testWidgets('app opens the store initial screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(InitialScreen), findsOneWidget);
  });
}
