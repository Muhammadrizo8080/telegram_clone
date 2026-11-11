import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telegram_clone/core/widgets/telegram_avatar.dart';
import 'package:telegram_clone/core/widgets/telegram_date_chip.dart';
import 'package:telegram_clone/features/chats/models/chat.dart';
import 'package:telegram_clone/features/messages/presentation/chat_page.dart';
import 'package:telegram_clone/features/profile/presentation/profile_page.dart';

void main() {
  final testChat = Chat(
    id: 'chat_1',
    title: 'Anvar Karimov',
    participantIds: const ['user_me', 'user_anvar'],
    lastMessage: 'Salom!',
    lastMessageTime: DateTime.now(),
  );

  group('ChatPage AppBar tests', () {
    testWidgets('renders avatar, title, status and actions in AppBar', (
      tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: ChatPage(chat: testChat)));

      // Verify Back button
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);

      // Verify Avatar
      expect(find.byType(TelegramGradientAvatar), findsOneWidget);
      expect(find.text('AK'), findsOneWidget);

      // Verify Title and Subtitle
      expect(find.text('Anvar Karimov'), findsOneWidget);
      expect(find.text('onlayn'), findsOneWidget);

      // Verify Call and More icons
      expect(find.byIcon(Icons.call_outlined), findsOneWidget);
      expect(find.byIcon(Icons.more_vert_rounded), findsOneWidget);

      // Verify date separator chip and background
      expect(find.byType(TelegramDateChip), findsOneWidget);
      expect(find.text('Bugun'), findsOneWidget);
    });

    testWidgets('tapping title area navigates to ProfilePage', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ChatPage(chat: testChat)));

      await tester.tap(find.text('Anvar Karimov'));
      await tester.pumpAndSettle();

      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets('opening 3-dots popup menu shows action items', (tester) async {
      await tester.pumpWidget(MaterialApp(home: ChatPage(chat: testChat)));

      await tester.tap(find.byIcon(Icons.more_vert_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Ovozni o‘chirish'), findsOneWidget);
      expect(find.text('Xabarlardan qidirish'), findsOneWidget);
      expect(find.text('Tarixni tozalash'), findsOneWidget);
      expect(find.text('Chatni o‘chirish'), findsOneWidget);
    });

    testWidgets('typing and sending a message adds new bubble to chat', (
      tester,
    ) async {
      await tester.pumpWidget(MaterialApp(home: ChatPage(chat: testChat)));

      await tester.enterText(find.byType(TextField), 'Test yangi xabar!');
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Test yangi xabar!'), findsOneWidget);
    });
  });
}
