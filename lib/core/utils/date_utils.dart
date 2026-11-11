import 'package:intl/intl.dart';

/// Checks if two [DateTime] instances fall on the same calendar day.
bool isSameDay(DateTime a, DateTime b) {
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

/// Formats a [DateTime] for chat list items:
/// - If [dateTime] is today: returns time as "HH:mm" (e.g., "14:30")
/// - Otherwise: returns date as "dd.MM" (e.g., "28.10")
String formatChatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  if (isSameDay(now, dateTime)) {
    return DateFormat('HH:mm').format(dateTime);
  } else {
    return DateFormat('dd.MM').format(dateTime);
  }
}

/// Month names in Uzbek for Telegram date chips.
const List<String> _uzbekMonths = [
  'yanvar',
  'fevral',
  'mart',
  'aprel',
  'may',
  'iyun',
  'iyul',
  'avgust',
  'sentabr',
  'oktabr',
  'noyabr',
  'dekabr',
];

/// Formats date for floating chat history date chips (e.g., "Bugun", "Kecha", "28-oktabr").
String formatMessageDateGroup(DateTime dateTime) {
  final now = DateTime.now();
  final yesterday = now.subtract(const Duration(days: 1));

  if (isSameDay(now, dateTime)) {
    return 'Bugun';
  }

  if (isSameDay(yesterday, dateTime)) {
    return 'Kecha';
  }

  final monthName = _uzbekMonths[dateTime.month - 1];
  if (now.year == dateTime.year) {
    return '${dateTime.day}-$monthName';
  }

  return '${dateTime.day}-$monthName, ${dateTime.year}';
}
