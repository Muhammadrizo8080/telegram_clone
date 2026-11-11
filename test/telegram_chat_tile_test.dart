import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telegram_clone/core/widgets/telegram_status_icon.dart';
import 'package:telegram_clone/features/chats/models/chat.dart';
import 'package:telegram_clone/features/chats/presentation/chats_page.dart';
import 'package:telegram_clone/features/chats/presentation/widgets/telegram_chat_tile.dart';
import 'package:telegram_clone/features/messages/models/message.dart';
import 'package:telegram_clone/features/messages/presentation/chat_page.dart';
import 'package:telegram_clone/features/messages/presentation/widgets/telegram_message_bubble.dart';

void main() {
  final testChatWithUnread = Chat(
    id: 'test_1',
    title: 'Anvar Karimov',
    participantIds: const ['user_me', 'user_anvar'],
    lastMessage: 'Salom, bugun uchrashamizmi?',
    lastMessageTime: DateTime(2026, 11, 2, 15, 30),
    unreadCount: 3,
  );

  final testChatOutgoing = Chat(
    id: 'test_2',
    title: 'Sarah Jenkins',
    participantIds: const ['user_me', 'user_sarah'],
    lastMessage: 'Hammasi tayyor, rahmat!',
    lastMessageTime: DateTime(2026, 11, 2, 14, 15),
    unreadCount: 0,
  );

  group('TelegramChatTile widget tests', () {
    testWidgets('renders title, last message and unread badge', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: TelegramChatTile(chat: testChatWithUnread)),
        ),
      );

      expect(find.text('Anvar Karimov'), findsOneWidget);
      expect(find.text('Salom, bugun uchrashamizmi?'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.byType(TelegramStatusIcon), findsNothing);
    });

    testWidgets(
      'renders outgoing status icon when isLastMessageOutgoing is true',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: TelegramChatTile(
                chat: testChatOutgoing,
                isLastMessageOutgoing: true,
                lastMessageStatus: MessageStatus.read,
              ),
            ),
          ),
        );

        expect(find.text('Sarah Jenkins'), findsOneWidget);
        expect(find.text('Hammasi tayyor, rahmat!'), findsOneWidget);
        expect(find.byType(TelegramStatusIcon), findsOneWidget);
        expect(find.byIcon(Icons.done_all_rounded), findsOneWidget);
      },
    );

    testWidgets('navigates to ChatPage on tile tap', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: ChatsPage(chats: [testChatWithUnread])),
      );

      await tester.tap(find.text('Anvar Karimov'));
      await tester.pumpAndSettle();

      expect(find.byType(ChatPage), findsOneWidget);
      expect(find.byType(TelegramMessageBubble), findsWidgets);
    });
  });
}
