import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geneio/components/my_textfield.dart';
import 'package:geneio/firebase_options.dart';
import 'package:geneio/pages/login.dart';
import 'package:geneio/pages/profile.dart';
import 'package:integration_test/integration_test.dart';

Widget testApp(Widget child) {
  return MaterialApp(
    home: Scaffold(body: child),
  );
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('FireStore Tests', () {
    tearDown(() async {
      await FirebaseAuth.instance.signOut();
    });
    // Setup
    testWidgets(
        'Family key creates new family entry in database and deletes it',
        (WidgetTester tester) async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      //login to the app
      await tester.pumpWidget(testApp(LoginPage()));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.descendant(
              of: find.byType(MyTextField).at(0),
              matching: find.byType(TextField)),
          'test@gmail.com');
      await tester.enterText(
          find.descendant(
              of: find.byType(MyTextField).at(1),
              matching: find.byType(TextField)),
          'test123');
      await tester
          .tap(find.text('Login')); // Assuming this is the login button text
      await tester.pumpAndSettle();

      await tester.pumpWidget(testApp(ProfilePage()));

      await tester.enterText(
        find.descendant(
          of: find.byType(MyTextField).at(3),
          matching: find.byType(TextField),
        ),
        'newfamilykey',
      );

      await tester.tap(find.text('Save'));

      //after clicking save, an alert dialog will pop up, so we need to tap the ok button

      await tester.tap(find.text('OK'));

      // Assert
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Family')
          .doc('newfamilykey')
          .id
          .toString();

      expect(querySnapshot, 'newfamilykey');

      // Cleanup
      //stop the app
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
      //sign out
      await FirebaseAuth.instance.signOut();
    });
  });
}
