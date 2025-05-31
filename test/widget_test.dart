import 'package:flutter_test/flutter_test.dart';

import 'package:unittrust_dividend_calculator/main.dart';

void main() {
  testWidgets('App builds and shows Home & About tabs', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const DividendCalculatorApp());
    await tester.pumpAndSettle();

    // Verify that Home screen AppBar title is shown.
    expect(find.text('Dividend Calculator'), findsOneWidget);

    // Verify BottomNavigationBar items.
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });
}
