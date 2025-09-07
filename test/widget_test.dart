// This is a basic Flutter widget test for Tripease app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tripease/main.dart';

void main() {
  testWidgets('Tripease app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const TripeaseApp());

    // Verify that the app title is displayed.
    expect(find.text('Tripease'), findsOneWidget);
  });
}
