import 'package:flutter/material.dart';

import 'package:telegram_clone/core/constants/app_constants.dart';
import 'package:telegram_clone/core/utils/date_utils.dart';
import 'package:telegram_clone/core/widgets/telegram_avatar.dart';
import 'package:telegram_clone/core/widgets/telegram_status_icon.dart';

import '../../../messages/models/message.dart';
import '../../models/chat.dart';

/// Authentic Telegram chat tile component matching Telegram Android/iOS dialog lists.
class TelegramChatTile extends StatelessWidget {
  const TelegramChatTile({
    super.key,
    required this.chat,
    this.onTap,
    this.isLastMessageOutgoing = false,
    this.lastMessageStatus,
  });

  /// The chat dialog data.
  final Chat chat;

  /// Callback when the tile is tapped.
  final VoidCallback? onTap;

  /// Whether the last message was sent by the current user.
  final bool isLastMessageOutgoing;

  /// Status of the last outgoing message (e.g., read or sent).
  final MessageStatus? lastMessageStatus;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final textSecondary = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final hasUnread = chat.unreadCount > 0;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: AppDimensions.chatTileHeight,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Row(
          children: [
            // Avatar (54x54 px)
            TelegramGradientAvatar(
              name: chat.title ?? 'Chat',
              id: chat.id,
              imageUrl: chat.avatarUrl,
              radius: AppDimensions.avatarRadiusMedium,
            ),
            const SizedBox(width: 14.0),

            // Content column
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Date/Time
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.title ?? 'Telegram User',
                          style: TextStyle(
                            color: textPrimary,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        formatChatDateTime(chat.lastMessageTime),
                        style: TextStyle(
                          color: hasUnread
                              ? AppColors.unreadBadge
                              : textSecondary,
                          fontSize: 12.0,
                          fontWeight: hasUnread
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),

                  // Message preview, status tick and unread badge
                  Row(
                    children: [
                      if (isLastMessageOutgoing) ...[
                        TelegramStatusIcon(
                          status: lastMessageStatus ?? MessageStatus.read,
                          size: 15.0,
                          color: isDark
                              ? const Color(0xFF6EB6F5)
                              : AppColors.readCheckBlue,
                        ),
                        const SizedBox(width: 4.0),
                      ],
                      Expanded(
                        child: Text(
                          chat.lastMessage,
                          style: TextStyle(
                            color: textSecondary,
                            fontSize: 14.5,
                            height: 1.15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (hasUnread) ...[
                        const SizedBox(width: 8.0),
                        Container(
                          constraints: const BoxConstraints(
                            minWidth: 20.0,
                            minHeight: 20.0,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: chat.unreadCount > 9 ? 6.5 : 0.0,
                            vertical: 1.5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.unreadBadge,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            chat.unreadCount > 99
                                ? '99+'
                                : '${chat.unreadCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
