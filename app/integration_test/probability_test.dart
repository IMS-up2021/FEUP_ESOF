import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:geneio/pages/genetic.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Genealogy Form Page Tests', () {
    testWidgets('Calculate Probabilities Button is clickable',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: GenealogyFormPage()));
      await tester.pumpAndSettle();

      // Find the 'Calculate Probabilities' button by its text
      final calculateProbabilitiesButton = find.text('Calculate Probabilities');

      // Check if the button exists
      expect(calculateProbabilitiesButton, findsOneWidget);

      // Tap the 'Calculate Probabilities' button
      await tester.tap(calculateProbabilitiesButton);

      // This will throw an error if the button is not tappable
      await tester.pumpAndSettle();
    });
  });
}
