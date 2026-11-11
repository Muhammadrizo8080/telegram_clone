import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telegram_clone/core/widgets/telegram_status_icon.dart';
import 'package:telegram_clone/features/messages/models/message.dart';

void main() {
  group('TelegramStatusIcon widget tests', () {
    testWidgets('renders clock for sending status', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TelegramStatusIcon(status: MessageStatus.sending),
          ),
        ),
      );

      expect(find.byIcon(Icons.access_time_rounded), findsOneWidget);
    });

    testWidgets('renders single check for sent status', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TelegramStatusIcon(status: MessageStatus.sent)),
        ),
      );

      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    });

    testWidgets('renders double check for read status', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: TelegramStatusIcon(status: MessageStatus.read)),
        ),
      );

      expect(find.byIcon(Icons.done_all_rounded), findsOneWidget);
    });
  });

  group('TelegramBubbleMeta widget tests', () {
    final testTime = DateTime(2026, 11, 2, 14, 30);

    testWidgets('renders time and status icon when isOutgoing is true', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TelegramBubbleMeta(
              time: testTime,
              status: MessageStatus.read,
              isOutgoing: true,
            ),
          ),
        ),
      );

      expect(find.text('14:30'), findsOneWidget);
      expect(find.byType(TelegramStatusIcon), findsOneWidget);
      expect(find.byIcon(Icons.done_all_rounded), findsOneWidget);
    });

    testWidgets('renders time only without status icon when incoming', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TelegramBubbleMeta(
              time: testTime,
              status: MessageStatus.read,
              isOutgoing: false,
            ),
          ),
        ),
      );

      expect(find.text('14:30'), findsOneWidget);
      expect(find.byType(TelegramStatusIcon), findsNothing);
    });
  });
}
