import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:telegram_clone/core/widgets/telegram_avatar.dart';
import 'package:telegram_clone/features/auth/models/user.dart';
import 'package:telegram_clone/features/profile/presentation/profile_page.dart';

void main() {
  const testUser = User(
    id: 'user_test',
    name: 'Muhammadrizo',
    phone: '+998 90 123 45 67',
  );

  group('ProfilePage widget tests', () {
    testWidgets('renders user header, avatar and quick action buttons', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfilePage(user: testUser)),
      );

      expect(find.byType(TelegramGradientAvatar), findsOneWidget);
      expect(find.text('Muhammadrizo'), findsOneWidget);
      expect(find.text('onlayn'), findsOneWidget);

      expect(find.text('Qo‘ng‘iroq'), findsOneWidget);
      expect(find.text('Video'), findsOneWidget);
      expect(find.text('Ovozni o‘chirish'), findsOneWidget);
      expect(find.text('Qidiruv'), findsOneWidget);
    });

    testWidgets('renders user info and switches notifications toggle', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: ProfilePage(user: testUser)),
      );

      expect(find.text('+998 90 123 45 67'), findsOneWidget);
      expect(find.text('@muhammadrizo'), findsOneWidget);
      expect(find.text('Bildirishnomalar'), findsOneWidget);
      expect(find.text('Yoqilgan'), findsOneWidget);

      // Toggle switch
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();

      expect(find.text('O‘chirilgan'), findsOneWidget);
    });
  });
}
