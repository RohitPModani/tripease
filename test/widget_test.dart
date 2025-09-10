// This is a basic Flutter widget test for Voythrix app.

import 'package:flutter_test/flutter_test.dart';

import 'package:tripease/main.dart';

void main() {
  testWidgets('Voythrix app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TripeaseApp());

    // Verify that the app title is displayed.
    expect(find.text('Voythrix'), findsOneWidget);
  });
}
