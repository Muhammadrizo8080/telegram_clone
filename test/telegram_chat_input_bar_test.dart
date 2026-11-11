import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telegram_clone/features/messages/presentation/widgets/telegram_chat_input_bar.dart';

void main() {
  group('TelegramChatInputBar widget tests', () {
    testWidgets('renders input elements and mic icon when empty', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: TelegramChatInputBar(onSend: (_) {})),
        ),
      );

      expect(
        find.byIcon(Icons.sentiment_satisfied_alt_outlined),
        findsOneWidget,
      );
      expect(find.text('Xabar...'), findsOneWidget);
      expect(find.byIcon(Icons.attach_file_rounded), findsOneWidget);
      expect(find.byIcon(Icons.mic_rounded), findsOneWidget);
      expect(find.byIcon(Icons.send_rounded), findsNothing);
    });

    testWidgets('typing switches mic icon to send button and sends message', (
      tester,
    ) async {
      String? sentText;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TelegramChatInputBar(onSend: (text) => sentText = text),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'Salom, yangi xabar!');
      await tester.pumpAndSettle();

      // Mic should be replaced by send button
      expect(find.byIcon(Icons.mic_rounded), findsNothing);
      expect(find.byIcon(Icons.send_rounded), findsOneWidget);

      // Tap send
      await tester.tap(find.byIcon(Icons.send_rounded));
      await tester.pumpAndSettle();

      expect(sentText, equals('Salom, yangi xabar!'));
      // Text field cleared and mic icon returned
      expect(find.byIcon(Icons.mic_rounded), findsOneWidget);
      expect(find.byIcon(Icons.send_rounded), findsNothing);
    });
  });
}
