// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:ebook_reader/common/widgets/top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ebook_reader/main.dart';

void main() {
  testWidgets('Wait and press categories button test',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MyApp(),
      ),
    );

    // Initial pump to render the splash screen
    await tester.pump();

    // Advance time to allow splashInitialize to complete (simulates the 2-second delay)
    await tester.pump(const Duration(seconds: 2));

    // Wait for any remaining animations or rebuilds to complete
    await tester.pumpAndSettle();

    expect(
        find.byWidgetPredicate((widget) =>
            widget is TopAppBar && widget.headerTitle == 'All books'),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            widget is TopAppBar && widget.headerTitle == 'Categories'),
        findsNothing);

    await tester.tap(
      find.byWidgetPredicate((widget) =>
          widget is NavigationDestination && widget.label == 'Categories'),
    );

    await tester.pump();

    expect(
        find.byWidgetPredicate((widget) =>
            widget is TopAppBar && widget.headerTitle == 'All books'),
        findsNothing);
    expect(
        find.byWidgetPredicate((widget) =>
            widget is TopAppBar && widget.headerTitle == 'Categories'),
        findsOneWidget);
  });
}
