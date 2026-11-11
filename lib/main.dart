import 'package:flutter/material.dart';

import 'package:telegram_clone/core/theme/app_theme.dart';

import 'features/chats/presentation/chats_page.dart';

void main() {
  runApp(const TelegramApp());
}

/// Root widget of the Telegram clone application.
class TelegramApp extends StatelessWidget {
  const TelegramApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Telegram Clone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const ChatsPage(),
    );
  }
}
