import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telegram_clone/core/widgets/telegram_status_icon.dart';
import 'package:telegram_clone/features/chats/data/mock_chats.dart';
import 'package:telegram_clone/features/chats/models/chat.dart';
import 'package:telegram_clone/features/chats/presentation/chats_page.dart';
import 'package:telegram_clone/features/chats/presentation/widgets/telegram_chat_tile.dart';

void main() {
  group('ChatsPage message matching tests', () {
    testWidgets(
      'uses real message from mockMessages to determine outgoing status and status icon',
      (tester) async {
        // Find chat_1 and chat_2 from mockChats
        final chat1 = mockChats.firstWhere((c) => c.id == 'chat_1');
        final chat2 = mockChats.firstWhere((c) => c.id == 'chat_2');

        await tester.pumpWidget(
          MaterialApp(home: ChatsPage(chats: [chat1, chat2])),
        );

        // chat_1 has outgoing last message from user_me in mockMessages
        final chat1TileFinder = find.widgetWithText(
          TelegramChatTile,
          chat1.title!,
        );
        expect(chat1TileFinder, findsOneWidget);
        final chat1Tile = tester.widget<TelegramChatTile>(chat1TileFinder);
        expect(chat1Tile.isLastMessageOutgoing, isTrue);
        expect(chat1Tile.lastMessageStatus, isNotNull);

        // chat_2 has no messages in mockMessages, should use safe default
        final chat2TileFinder = find.widgetWithText(
          TelegramChatTile,
          chat2.title!,
        );
        expect(chat2TileFinder, findsOneWidget);
        final chat2Tile = tester.widget<TelegramChatTile>(chat2TileFinder);
        expect(chat2Tile.isLastMessageOutgoing, isFalse);
        expect(chat2Tile.lastMessageStatus, isNull);
      },
    );

    testWidgets(
      'safe default applies when chat has no matching messages in mockMessages',
      (tester) async {
        final unknownChat = Chat(
          id: 'chat_unknown',
          title: 'New Contact',
          participantIds: const ['user_me', 'user_unknown'],
          lastMessage: 'Hey there',
          lastMessageTime: DateTime(2026, 11, 3, 10, 0),
          unreadCount: 0,
        );

        await tester.pumpWidget(
          MaterialApp(home: ChatsPage(chats: [unknownChat])),
        );

        final tileFinder = find.widgetWithText(TelegramChatTile, 'New Contact');
        expect(tileFinder, findsOneWidget);
        final tile = tester.widget<TelegramChatTile>(tileFinder);
        expect(tile.isLastMessageOutgoing, isFalse);
        expect(tile.lastMessageStatus, isNull);
        expect(find.byType(TelegramStatusIcon), findsNothing);
      },
    );
  });
}
