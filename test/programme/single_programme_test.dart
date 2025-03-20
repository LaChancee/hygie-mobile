import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hygie_mobile/presentation/programme/single_programme.dart';

void main() {
  group('ModaleProgram Widget Tests', () {
    testWidgets('ModaleProgram should render properly',
        (WidgetTester tester) async {
      // Pump the widget into the test environment
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ModaleProgram(),
            ),
          ),
        ),
      );

      // Verify the header elements
      expect(find.text('Programme de sevrage tabagique'), findsOneWidget);
      expect(find.text('Arrêt progressif en 30 jours'), findsOneWidget);

      // Verify description and sections
      expect(find.text('Description du programme'), findsOneWidget);
      expect(find.text('Les étapes du programme'), findsOneWidget);

      // Verify the program steps are present
      expect(find.text('Préparation'), findsOneWidget);
      expect(find.text('Réduction'), findsOneWidget);
      expect(find.text('Arrêt'), findsOneWidget);
      expect(find.text('Maintien'), findsOneWidget);

      // Verify the buttons
      expect(find.text('Retour'), findsOneWidget);
      expect(find.text('Commencer'), findsOneWidget);
    });

    testWidgets('ModaleProgram should have a progress indicator',
        (WidgetTester tester) async {
      // Pump the widget into the test environment
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ModaleProgram(),
            ),
          ),
        ),
      );

      // Verify the progress container is present
      final containers =
          tester.widgetList<Container>(find.byType(Container)).toList();
      bool foundProgressBar = false;

      for (var container in containers) {
        if (container.decoration is BoxDecoration) {
          final decoration = container.decoration as BoxDecoration;
          if (decoration.gradient != null && decoration.borderRadius != null) {
            foundProgressBar = true;
            break;
          }
        }
      }

      expect(foundProgressBar, true,
          reason: 'Progress bar gradient container not found');
    });

    testWidgets('ModaleProgram should display correct steps',
        (WidgetTester tester) async {
      // Pump the widget into the test environment
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ModaleProgram(),
            ),
          ),
        ),
      );

      // Check for the grid of steps
      expect(find.byType(GridView), findsOneWidget);

      // Verify the step subtitles
      expect(find.text('Jours 1-7'), findsOneWidget);
      expect(find.text('Jours 8-15'), findsOneWidget);
      expect(find.text('Jours 16-22'), findsOneWidget);
      expect(find.text('Jours 23-30'), findsOneWidget);
    });
  });
}
