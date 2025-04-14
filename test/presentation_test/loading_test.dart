import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dda_desktop/presentation/loading.dart';

void main() {
  group("The Loading widget", () {
    testWidgets("will render a circular loading icon", (tester) async {
      await tester.pumpWidget(LoadingPage());
      expect(find.byKey(Key("loadingIcon")), findsOneWidget);
    });
  });
}
