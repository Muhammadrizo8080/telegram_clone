import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telegram_clone/features/chats/presentation/widgets/telegram_drawer.dart';
import 'package:telegram_clone/features/settings/presentation/settings_page.dart';

void main() {
  group('TelegramDrawer widget tests', () {
    testWidgets('renders user header with name, phone and avatar', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            drawer: TelegramDrawer(),
            body: Center(child: Text('Main Screen')),
          ),
        ),
      );

      // Open drawer
      final scaffoldState = tester.firstState<ScaffoldState>(
        find.byType(Scaffold),
      );
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      // Verify user header
      expect(find.text('Muhammadrizo'), findsOneWidget);
      expect(find.text('+998 90 123 45 67'), findsOneWidget);

      // Verify menu items
      expect(find.text('New Group'), findsOneWidget);
      expect(find.text('Contacts'), findsOneWidget);
      expect(find.text('Calls'), findsOneWidget);
      expect(find.text('Saved Messages'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Invite Friends'), findsOneWidget);
      expect(find.text('Telegram Features'), findsOneWidget);
    });

    testWidgets(
      'tapping Settings closes drawer and navigates to SettingsPage',
      (tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              drawer: TelegramDrawer(),
              body: Center(child: Text('Main Screen')),
            ),
          ),
        );

        final scaffoldState = tester.firstState<ScaffoldState>(
          find.byType(Scaffold),
        );
        scaffoldState.openDrawer();
        await tester.pumpAndSettle();

        await tester.tap(find.text('Settings'));
        await tester.pumpAndSettle();

        expect(find.byType(SettingsPage), findsOneWidget);
      },
    );

    testWidgets('triggers onThemeToggle when sun/moon button is tapped', (
      tester,
    ) async {
      var toggled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            drawer: TelegramDrawer(onThemeToggle: () => toggled = true),
            body: const Center(child: Text('Main Screen')),
          ),
        ),
      );

      final scaffoldState = tester.firstState<ScaffoldState>(
        find.byType(Scaffold),
      );
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.nightlight_round));
      expect(toggled, isTrue);
    });
  });
}
