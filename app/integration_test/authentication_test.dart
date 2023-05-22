import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geneio/firebase_options.dart';
import 'package:geneio/pages/home_page.dart';
import 'package:geneio/pages/login.dart';
import 'package:geneio/pages/menu.dart';
import 'package:geneio/pages/register.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:geneio/components/my_textfield.dart';

Widget testApp(Widget child) {
  return MaterialApp(
    home: Scaffold(body: child),
  );
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Tests', () {
    tearDown(() async {
      await FirebaseAuth.instance.signOut();
    });
    // Setup
    testWidgets('Login with Firebase', (WidgetTester tester) async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await tester.pumpWidget(testApp(LoginPage()));
      await tester.pumpAndSettle();

      // Exercise
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

      // Assert
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      expect(user?.email, 'test@gmail.com');

      // Cleanup
      //stop the app
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
      //sign out
      await auth.signOut();
    });

    testWidgets('Register with Firebase', (WidgetTester tester) async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await tester.pumpWidget(testApp(RegisterPage()));
      await tester.pumpAndSettle();

      // Exercise
      await tester.enterText(
          find.descendant(
              of: find.byType(MyTextField).at(0),
              matching: find.byType(TextField)),
          'newuser@gmail.com');
      await tester.enterText(
          find.descendant(
              of: find.byType(MyTextField).at(1),
              matching: find.byType(TextField)),
          'newUser123');
      await tester.enterText(
          find.descendant(
              of: find.byType(MyTextField).at(2),
              matching: find.byType(TextField)),
          'newUser123');
      await tester.tap(
          find.text('Register')); // Assuming this is the register button text
      await tester.pumpAndSettle();

      // Assert
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      expect(user?.email, 'newuser@gmail.com');

      //Cleanup
      //delete the user from firebase database
      await user?.delete();
      //stop the app
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();

      //Sign out
      await auth.signOut();
    });

    // Setup
    testWidgets('Logout with Firebase', (WidgetTester tester) async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await tester.pumpWidget(testApp(MenuPage()));
      await tester.pumpAndSettle();

      // Exercise
      await tester.tap(find.byIcon(
          Icons.arrow_back_ios_new)); // Assuming this is the logout icon
      await tester.pumpAndSettle();

      // Assert
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      expect(user, isNull);

      // Cleanup
      //stop the app
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
      //sign out
      await auth.signOut();
    });
  });
}
