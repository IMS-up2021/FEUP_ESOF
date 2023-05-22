import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geneio/components/card.dart';
import 'package:geneio/pages/family.dart';
import 'package:geneio/pages/family_history.dart';
import 'package:geneio/pages/family_member_info.dart';
import 'package:geneio/pages/genetic.dart';
import 'package:geneio/pages/about_page.dart';
import 'package:geneio/pages/menu.dart';
import 'package:integration_test/integration_test.dart';

Widget testApp(Widget child) {
  return MaterialApp(
    home: Scaffold(body: child),
  );
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('MenuPage Tests', () {
    setUpAll(() async {
      await Firebase.initializeApp();
    });

    testWidgets('Clicking Family Card opens FamilyPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(testApp(MenuPage()));

      // Swipe from top to bottom to reveal the card
      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pumpAndSettle();

      // Tap the first card
      await tester.tap(find.byType(MyCard).first);
      await tester.pumpAndSettle();

      expect(find.byType(FamilyPage), findsOneWidget);
    });

    testWidgets('Clicking History Card opens FamilyDatesPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(testApp(MenuPage()));

      // Swipe from top to bottom to reveal the card
      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pumpAndSettle();

      // Tap the second card
      await tester.tap(find.byType(MyCard).at(1));
      await tester.pumpAndSettle();

      expect(find.byType(FamilyDatesPage), findsOneWidget);
    });

    testWidgets('Clicking Genetic Card opens GenealogyFormPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(testApp(MenuPage()));

      // Swipe from top to bottom to reveal the card
      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pumpAndSettle();

      // Tap the third card
      await tester.tap(find.byType(MyCard).at(2));
      await tester.pumpAndSettle();

      expect(find.byType(GenealogyFormPage), findsOneWidget);
    });

    testWidgets('Clicking About Card opens AboutPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(testApp(MenuPage()));

      // Swipe from top to bottom to reveal the card
      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pumpAndSettle();

      // Tap the fourth card
      await tester.tap(find.byType(MyCard).at(3));
      await tester.pumpAndSettle();

      expect(find.byType(AboutPage), findsOneWidget);
    });

    testWidgets('Clicking Family Member Info Card opens FamilyMemberInfoPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(testApp(MenuPage()));

      // Swipe from top to bottom to reveal the card
      await tester.drag(find.byType(ListView), const Offset(0, -400));
      await tester.pumpAndSettle();

      // Tap the fifth card
      await tester.tap(find.byType(MyCard).at(4));
      await tester.pumpAndSettle();

      expect(find.byType(FamilyMemberInfoPage), findsOneWidget);
    });
  });
}
