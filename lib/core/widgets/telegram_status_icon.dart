import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../features/messages/models/message.dart';
import '../constants/app_constants.dart';

/// Authentic Telegram status icon for messages:
/// - sending: tiny clock indicator
/// - sent: single check mark (✓)
/// - read: double check mark (✓✓)
class TelegramStatusIcon extends StatelessWidget {
  const TelegramStatusIcon({
    super.key,
    required this.status,
    this.size = 15.0,
    this.color,
  });

  /// The delivery status of the message.
  final MessageStatus status;

  /// Icon size. Defaults to 15.0.
  final double size;

  /// Custom icon color. If null, adopts theme or default Telegram blue/meta color.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.readCheckBlue;

    switch (status) {
      case MessageStatus.sending:
        return Icon(
          Icons.access_time_rounded,
          size: size * 0.9,
          color: effectiveColor,
        );
      case MessageStatus.sent:
        return Icon(Icons.check_rounded, size: size, color: effectiveColor);
      case MessageStatus.read:
        return Icon(
          Icons.done_all_rounded,
          size: size * 1.15,
          color: effectiveColor,
        );
    }
  }
}

/// Bottom-right metadata widget for Telegram message bubbles:
/// Displays formatted time (HH:mm) and the status ticks if the message is outgoing.
class TelegramBubbleMeta extends StatelessWidget {
  const TelegramBubbleMeta({
    super.key,
    required this.time,
    this.status,
    this.isOutgoing = false,
    this.textColor,
    this.iconColor,
  });

  /// The creation timestamp of the message.
  final DateTime time;

  /// Status of the message (only relevant if [isOutgoing] is true).
  final MessageStatus? status;

  /// Whether the message was sent by the current user.
  final bool isOutgoing;

  /// Custom text color for timestamp.
  final Color? textColor;

  /// Custom color for status ticks.
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultTextColor = isDark
        ? AppColors.bubbleMetaDark
        : (isOutgoing
              ? AppColors.outgoingMetaLight
              : AppColors.incomingMetaLight);

    final defaultIconColor = isDark
        ? AppColors.bubbleMetaDark
        : (isOutgoing ? AppColors.outgoingMetaLight : AppColors.readCheckBlue);

    final formattedTime = DateFormat('HH:mm').format(time);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          formattedTime,
          style: TextStyle(
            fontSize: 11.0,
            color: textColor ?? defaultTextColor,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
          ),
        ),
        if (isOutgoing && status != null) ...[
          const SizedBox(width: 3.5),
          TelegramStatusIcon(
            status: status!,
            size: 14.0,
            color: iconColor ?? defaultIconColor,
          ),
        ],
      ],
    );
  }
}
