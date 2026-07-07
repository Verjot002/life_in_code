import 'package:flutter_test/flutter_test.dart';
import 'package:life_in_code/portfolio_app.dart';

void main() {
  testWidgets('Portfolio App Smoke Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PortfolioApp());

    // Verify that the developer name is present in the UI.
    expect(find.text('VERJOT HEER'), findsOneWidget);
  });
}
