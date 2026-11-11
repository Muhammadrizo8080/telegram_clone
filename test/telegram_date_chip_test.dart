import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telegram_clone/core/utils/date_utils.dart';
import 'package:telegram_clone/core/widgets/telegram_date_chip.dart';

void main() {
  group('formatMessageDateGroup helper tests', () {
    test('returns Bugun for today', () {
      final now = DateTime.now();
      expect(formatMessageDateGroup(now), equals('Bugun'));
    });

    test('returns Kecha for yesterday', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(formatMessageDateGroup(yesterday), equals('Kecha'));
    });

    test('returns day and month for earlier dates in the same year', () {
      final specificDate = DateTime(DateTime.now().year, 5, 12);
      final formatted = formatMessageDateGroup(specificDate);
      expect(formatted, contains('12-may'));
    });
  });

  group('TelegramDateChip widget tests', () {
    testWidgets('renders date chip with formatted text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: TelegramDateChip(date: DateTime.now())),
        ),
      );

      expect(find.byType(TelegramDateChip), findsOneWidget);
      expect(find.text('Bugun'), findsOneWidget);
    });

    testWidgets('renders customText if provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TelegramDateChip(
              date: DateTime(2026, 10, 15),
              customText: '15-oktabr',
            ),
          ),
        ),
      );

      expect(find.text('15-oktabr'), findsOneWidget);
    });
  });
}
