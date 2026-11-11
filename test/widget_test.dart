import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telegram_clone/core/utils/date_utils.dart';
import 'package:telegram_clone/features/chats/presentation/chats_page.dart';
import 'package:telegram_clone/main.dart';

void main() {
  testWidgets('App smoke test: builds and displays ChatsPage placeholder', (
    WidgetTester tester,
  ) async {
    // Build the TelegramApp and trigger a frame.
    await tester.pumpWidget(const TelegramApp());

    // Verify that ChatsPage and chat items are rendered.
    expect(find.byType(ChatsPage), findsOneWidget);
    expect(find.text('Telegram'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.text('Anvar Karimov'), findsOneWidget);
    expect(find.text('Flutter Developers UZ'), findsOneWidget);

    // Tap search icon to test search mode
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);

    // Tap back icon to exit search mode
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    expect(find.text('Telegram'), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);

    // Verify FAB pencil button
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.edit_rounded), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump();
    expect(find.text('Yangi xabar boshlash'), findsOneWidget);
  });

  group('DateUtils tests', () {
    test('formatChatDateTime formats today with HH:mm', () {
      final now = DateTime.now();
      final formatted = formatChatDateTime(now);
      expect(formatted.contains(':'), isTrue);
    });

    test('formatChatDateTime formats past dates with dd.MM', () {
      final pastDate = DateTime(2025, 5, 12, 10, 30);
      final formatted = formatChatDateTime(pastDate);
      expect(formatted, equals('12.05'));
    });
  });
}
