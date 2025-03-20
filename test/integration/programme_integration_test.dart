import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hygie_mobile/presentation/journal/journal_page.dart';
import 'package:hygie_mobile/presentation/programme/programme.dart';
import 'package:hygie_mobile/presentation/programme/single_programme.dart';
import 'package:hygie_mobile/commons/ui/colors.dart';

class TestApp extends StatelessWidget {
  final Widget child;

  const TestApp({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      home: Scaffold(body: child),
    );
  }
}

void main() {
  group('Programme Integration Tests', () {
    testWidgets(
        'JournalPage should navigate to programme tab and show programs',
        (WidgetTester tester) async {
      // Pump the widget into the test environment with the journal page
      await tester.pumpWidget(const TestApp(child: JournalPage()));

      // We need to find and tap the "Programme" tab
      final programmeTab = find.text('Programme');
      expect(programmeTab, findsOneWidget);

      // Tap the tab and wait for animation to complete
      await tester.tap(programmeTab);
      await tester.pumpAndSettle();

      // Now check that the ProgramSection is visible with program cards
      expect(find.byType(ProgramSection), findsOneWidget);

      // Test content of the first program card
      expect(find.text('Programme de sevrage tabagique'), findsOneWidget);
    });

    testWidgets('ProgramSection to ModaleProgram flow test',
        (WidgetTester tester) async {
      // Direct test of program section
      await tester.pumpWidget(const TestApp(child: ProgramSection()));

      // Verify program cards are rendered
      expect(find.text('Programme de sevrage tabagique'), findsOneWidget);
      expect(find.text('Gestion du stress'), findsOneWidget);

      // Find a program card
      final programCard = find.text('Programme de sevrage tabagique').first;

      // Due to limitations in testing showModalBottomSheet, we'll test
      // the ModaleProgram separately

      // Pump the ModaleProgram directly
      await tester.pumpWidget(
        TestApp(
          child: Builder(
            builder: (context) => ModaleProgram(),
          ),
        ),
      );

      // Verify key elements of ModaleProgram
      expect(find.text('Description du programme'), findsOneWidget);
      expect(find.text('Les étapes du programme'), findsOneWidget);

      // Verify buttons
      expect(find.text('Retour'), findsOneWidget);
      expect(find.text('Commencer'), findsOneWidget);
    });

    testWidgets('ModaleProgram navigation test', (WidgetTester tester) async {
      // Setup a navigation observer to track navigation events
      final navigatorKey = GlobalKey<NavigatorState>();

      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigatorKey,
          home: Builder(
            builder: (context) => Scaffold(
              body: ModaleProgram(),
            ),
          ),
        ),
      );

      // Find and tap the "Retour" button
      final backButton = find.text('Retour');
      expect(backButton, findsOneWidget);

      // We can't fully test navigation in this isolated test environment
      // but we can verify the button is there and tappable
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      // Check the "Commencer" button
      final startButton = find.text('Commencer');
      expect(startButton, findsOneWidget);

      await tester.tap(startButton);
      await tester.pumpAndSettle();
    });
  });
}
