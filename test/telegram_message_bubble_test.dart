import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telegram_clone/core/widgets/telegram_status_icon.dart';
import 'package:telegram_clone/features/messages/models/message.dart';
import 'package:telegram_clone/features/messages/presentation/widgets/telegram_message_bubble.dart';

void main() {
  final testIncomingMessage = Message(
    id: 'm1',
    chatId: 'c1',
    senderId: 'user_anvar',
    text: 'Assalomu alaykum!',
    createdAt: DateTime(2026, 11, 2, 10, 15),
    status: MessageStatus.read,
  );

  final testOutgoingMessage = Message(
    id: 'm2',
    chatId: 'c1',
    senderId: 'user_me',
    text: 'Vaalaykum assalom, qandaysiz?',
    createdAt: DateTime(2026, 11, 2, 10, 16),
    status: MessageStatus.read,
  );

  group('TelegramMessageBubble widget tests', () {
    testWidgets('renders incoming message on left without status icon', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TelegramMessageBubble(
              message: testIncomingMessage,
              isOutgoing: false,
            ),
          ),
        ),
      );

      expect(find.text('Assalomu alaykum!'), findsOneWidget);
      expect(find.text('10:15'), findsOneWidget);
      expect(find.byType(TelegramStatusIcon), findsNothing);

      final alignWidget = tester.widget<Align>(find.byType(Align).first);
      expect(alignWidget.alignment, equals(Alignment.centerLeft));
    });

    testWidgets(
      'renders outgoing message on right with check ticks and green tint',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TelegramMessageBubble(
                message: testOutgoingMessage,
                isOutgoing: true,
              ),
            ),
          ),
        );

        expect(find.text('Vaalaykum assalom, qandaysiz?'), findsOneWidget);
        expect(find.text('10:16'), findsOneWidget);
        expect(find.byType(TelegramStatusIcon), findsOneWidget);
        expect(find.byIcon(Icons.done_all_rounded), findsOneWidget);

        final alignWidget = tester.widget<Align>(find.byType(Align).first);
        expect(alignWidget.alignment, equals(Alignment.centerRight));
      },
    );
  });
}
