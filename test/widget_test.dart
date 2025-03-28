import 'package:flutter_test/flutter_test.dart';

import 'package:dda_desktop/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    expect(find.text('This is empty'), findsOneWidget);
  });
}
