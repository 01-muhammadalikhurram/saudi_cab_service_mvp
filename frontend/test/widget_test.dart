import 'package:flutter_test/flutter_test.dart';
import 'package:saudi_cab_service/app/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SaudiCabApp());
  });
}

