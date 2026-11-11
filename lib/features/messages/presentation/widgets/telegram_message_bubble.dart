import 'package:flutter/material.dart';

import 'package:telegram_clone/core/constants/app_constants.dart';
import 'package:telegram_clone/core/widgets/telegram_status_icon.dart';

import '../../models/message.dart';

/// Authentic Telegram message bubble supporting incoming and outgoing messages.
class TelegramMessageBubble extends StatelessWidget {
  const TelegramMessageBubble({
    super.key,
    required this.message,
    required this.isOutgoing,
    this.onTap,
    this.onLongPress,
  });

  /// The message data model.
  final Message message;

  /// Whether the message was sent by the current user.
  final bool isOutgoing;

  /// Optional tap callback.
  final VoidCallback? onTap;

  /// Optional long press callback (e.g., for reaction or context menu).
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final maxBubbleWidth = MediaQuery.of(context).size.width * 0.78;

    final bubbleColor = isDark
        ? (isOutgoing
              ? AppColors.outgoingBubbleDark
              : AppColors.incomingBubbleDark)
        : (isOutgoing
              ? AppColors.outgoingBubbleLight
              : AppColors.incomingBubbleLight);

    final textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;

    // Authentic Telegram bubble corners with sharper nip/tail corner
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(AppDimensions.radiusBubble),
      topRight: const Radius.circular(AppDimensions.radiusBubble),
      bottomLeft: Radius.circular(
        isOutgoing ? AppDimensions.radiusBubble : AppDimensions.radiusBubbleNip,
      ),
      bottomRight: Radius.circular(
        isOutgoing ? AppDimensions.radiusBubbleNip : AppDimensions.radiusBubble,
      ),
    );

    return Align(
      alignment: isOutgoing ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: borderRadius,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: maxBubbleWidth,
              minWidth: 64.0,
            ),
            padding: const EdgeInsets.fromLTRB(11.0, 7.5, 10.0, 5.5),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
                  blurRadius: 1.5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 15.2,
                      height: 1.25,
                      letterSpacing: 0.1,
                    ),
                  ),
                ),
                const SizedBox(height: 3.0),
                TelegramBubbleMeta(
                  time: message.createdAt,
                  status: message.status,
                  isOutgoing: isOutgoing,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
