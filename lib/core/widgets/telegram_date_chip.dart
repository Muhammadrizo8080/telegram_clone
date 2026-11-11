import 'package:flutter/material.dart';

import '../constants/app_constants.dart';
import '../utils/date_utils.dart';

/// Floating capsule date separator used in Telegram chat history.
class TelegramDateChip extends StatelessWidget {
  const TelegramDateChip({super.key, required this.date, this.customText});

  /// The message date represented by this chip.
  final DateTime date;

  /// Optional override text for testing or custom display.
  final String? customText;

  @override
  Widget build(BuildContext context) {
    final text = customText ?? formatMessageDateGroup(date);

    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.5),
        decoration: BoxDecoration(
          color: AppColors.dateChipBackground,
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
