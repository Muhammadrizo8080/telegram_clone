import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telegram_clone/core/widgets/telegram_avatar.dart';

void main() {
  group('TelegramGradientAvatar unit tests', () {
    test('extractInitials returns correct initials for various names', () {
      expect(TelegramGradientAvatar.extractInitials('Anvar Karimov'), 'AK');
      expect(TelegramGradientAvatar.extractInitials('Muhammadrizo'), 'M');
      expect(
        TelegramGradientAvatar.extractInitials('Flutter Developers UZ'),
        'FD',
      );
      expect(TelegramGradientAvatar.extractInitials('  sarah jenkins '), 'SJ');
      expect(TelegramGradientAvatar.extractInitials(''), '?');
      expect(TelegramGradientAvatar.extractInitials('   '), '?');
    });

    test('getGradientColors returns consistent gradients for the same key', () {
      final gradient1 = TelegramGradientAvatar.getGradientColors('user_123');
      final gradient2 = TelegramGradientAvatar.getGradientColors('user_123');
      expect(gradient1, equals(gradient2));

      final emptyGradient = TelegramGradientAvatar.getGradientColors('');
      expect(emptyGradient.length, 2);
    });
  });

  group('TelegramGradientAvatar widget tests', () {
    testWidgets('renders initials text and reacts to tap', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: TelegramGradientAvatar(
                name: 'Anvar Karimov',
                id: 'user_anvar',
                onTap: () => tapped = true,
              ),
            ),
          ),
        ),
      );

      expect(find.text('AK'), findsOneWidget);

      await tester.tap(find.byType(TelegramGradientAvatar));
      expect(tapped, isTrue);
    });

    testWidgets('shows online indicator when isOnline is true', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Center(
              child: TelegramGradientAvatar(
                name: 'Sarah Jenkins',
                isOnline: true,
              ),
            ),
          ),
        ),
      );

      expect(find.text('SJ'), findsOneWidget);
      // Verify online indicator container is rendered
      final stackFinder = find.descendant(
        of: find.byType(TelegramGradientAvatar),
        matching: find.byType(Stack),
      );
      expect(stackFinder, findsOneWidget);
      final stack = tester.widget<Stack>(stackFinder);
      expect(stack.children.length, 2);
      expect(find.byType(Positioned), findsOneWidget);
    });
  });
}
