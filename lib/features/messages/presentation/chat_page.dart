import 'package:flutter/material.dart';

import 'package:telegram_clone/core/constants/app_constants.dart';
import 'package:telegram_clone/core/utils/date_utils.dart';
import 'package:telegram_clone/core/widgets/telegram_avatar.dart';
import 'package:telegram_clone/core/widgets/telegram_date_chip.dart';

import '../../chats/data/mock_chats.dart';
import '../../chats/models/chat.dart';
import '../../profile/presentation/profile_page.dart';
import '../data/mock_messages.dart';
import '../models/message.dart';
import 'widgets/telegram_chat_input_bar.dart';
import 'widgets/telegram_message_bubble.dart';

/// Single chat room page matching Telegram's chat screen.
class ChatPage extends StatefulWidget {
  const ChatPage({super.key, this.chat, this.messages});

  /// The active chat dialog.
  final Chat? chat;

  /// Optional custom messages list. Defaults to matching [mockMessages].
  final List<Message>? messages;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late List<Message> _chatMessages;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(String text) {
    final newMessage = Message(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      chatId: widget.chat?.id ?? 'chat_direct',
      senderId: currentUser.id,
      text: text,
      createdAt: DateTime.now(),
      status: MessageStatus.sent,
    );

    setState(() {
      _chatMessages.add(newMessage);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _loadMessages() {
    if (widget.messages != null) {
      _chatMessages = List.from(widget.messages!);
      return;
    }

    final chatId = widget.chat?.id;
    final filtered = mockMessages.where((m) => m.chatId == chatId).toList();

    if (filtered.isNotEmpty) {
      _chatMessages = filtered;
    } else if (widget.chat != null) {
      // Fallback to chat last message
      _chatMessages = [
        Message(
          id: 'msg_fallback',
          chatId: widget.chat!.id,
          senderId: 'user_other',
          text: widget.chat!.lastMessage,
          createdAt: widget.chat!.lastMessageTime,
          status: MessageStatus.read,
        ),
      ];
    } else {
      _chatMessages = [];
    }
  }

  String _getSubtitle() {
    final chat = widget.chat;
    if (chat == null) return 'oxirgi marta yaqinda bo‘lgan';

    final isGroup = chat.participantIds.length > 2;
    if (isGroup) {
      return '${chat.participantIds.length} a’zo';
    }

    // Realistic Telegram status
    if (chat.id == 'chat_1') {
      return 'onlayn';
    }
    return 'oxirgi marta yaqinda bo‘lgan';
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final chat = widget.chat;
    final title = chat?.title ?? 'Chat';
    final subtitle = _getSubtitle();
    final isOnline = subtitle == 'onlayn';

    return AppBar(
      titleSpacing: 0.0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        tooltip: 'Back',
        onPressed: () => Navigator.pop(context),
      ),
      title: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfilePage()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              TelegramGradientAvatar(
                name: title,
                id: chat?.id,
                imageUrl: chat?.avatarUrl,
                radius: 19.5,
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.1,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 1.0),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: isOnline
                            ? const Color(0xFFC7E3FF)
                            : Colors.white.withValues(alpha: 0.72),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.call_outlined),
          tooltip: 'Call',
          onPressed: () {},
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert_rounded),
          tooltip: 'More',
          onSelected: (value) {},
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'mute', child: Text('Ovozni o‘chirish')),
            const PopupMenuItem(
              value: 'search',
              child: Text('Xabarlardan qidirish'),
            ),
            const PopupMenuItem(
              value: 'clear',
              child: Text('Tarixni tozalash'),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Chatni o‘chirish'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? AppColors.darkChatBackground
        : AppColors.lightChatBackground;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: backgroundColor,
        child: Column(
          children: [
            Expanded(
              child: _chatMessages.isEmpty
                  ? const Center(
                      child: Text(
                        'Xabarlar mavjud emas',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      itemCount: _chatMessages.length,
                      itemBuilder: (context, index) {
                        final message = _chatMessages[index];
                        final isOutgoing = message.senderId == currentUser.id;

                        final showDateHeader =
                            index == 0 ||
                            !isSameDay(
                              _chatMessages[index - 1].createdAt,
                              message.createdAt,
                            );

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (showDateHeader)
                              TelegramDateChip(date: message.createdAt),
                            TelegramMessageBubble(
                              message: message,
                              isOutgoing: isOutgoing,
                            ),
                          ],
                        );
                      },
                    ),
            ),
            TelegramChatInputBar(onSend: _sendMessage),
          ],
        ),
      ),
    );
  }
}
