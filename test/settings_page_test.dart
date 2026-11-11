import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telegram_clone/core/widgets/telegram_avatar.dart';
import 'package:telegram_clone/features/auth/models/user.dart';
import 'package:telegram_clone/features/profile/presentation/profile_page.dart';
import 'package:telegram_clone/features/settings/presentation/settings_page.dart';

void main() {
  const testUser = User(
    id: 'user_me',
    name: 'Muhammadrizo',
    phone: '+998 90 123 45 67',
  );

  group('SettingsPage widget tests', () {
    testWidgets('renders user header tile, settings sections and footer', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(
        const MaterialApp(home: SettingsPage(user: testUser)),
      );

      // Verify AppBar
      expect(find.text('Sozlamalar'), findsWidgets);

      // Verify User Profile Tile
      expect(find.byType(TelegramGradientAvatar), findsOneWidget);
      expect(find.text('Muhammadrizo'), findsOneWidget);
      expect(find.text('+998 90 123 45 67'), findsOneWidget);
      expect(find.text('@muhammadrizo'), findsOneWidget);

      // Verify Settings options
      expect(find.text('Chat sozlamalari'), findsOneWidget);
      expect(find.text('Maxfiylik va xavfsizlik'), findsOneWidget);
      expect(find.text('Bildirishnomalar va ovozlar'), findsOneWidget);
      expect(find.text('Ma’lumotlar va xotira'), findsOneWidget);
      expect(find.text('Chat jildlari'), findsOneWidget);
      expect(find.text('Qurilmalar'), findsOneWidget);
      expect(find.text('Til'), findsOneWidget);
      expect(find.text('O‘zbekcha'), findsOneWidget);
      expect(find.text('Tungi rejim'), findsOneWidget);

      // Verify Help & Footer
      expect(find.text('Telegram imkoniyatlari'), findsOneWidget);
      expect(
        find.text('Telegram Clone for Android v1.0.0 (3421)'),
        findsOneWidget,
      );
    });

    testWidgets('tapping user card navigates to ProfilePage', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: SettingsPage(user: testUser)),
      );

      await tester.tap(find.text('Muhammadrizo'));
      await tester.pumpAndSettle();

      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets('toggling dark mode switch triggers onThemeToggle', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      var toggled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: SettingsPage(
            user: testUser,
            onThemeToggle: () => toggled = true,
          ),
        ),
      );

      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(toggled, isTrue);
    });
  });
}
