import 'package:flutter/material.dart';

import 'package:telegram_clone/core/constants/app_constants.dart';

/// Authentic Telegram bottom message input bar:
/// Includes emoji icon, auto-expanding text field, attachment paperclip,
/// and reactive microphone/send action button.
class TelegramChatInputBar extends StatefulWidget {
  const TelegramChatInputBar({
    super.key,
    required this.onSend,
    this.onAttachmentTap,
    this.onEmojiTap,
    this.onVoiceTap,
    this.hintText = 'Xabar...',
  });

  /// Called when the user taps send with non-empty text.
  final ValueChanged<String> onSend;

  /// Called when attachment paperclip is tapped.
  final VoidCallback? onAttachmentTap;

  /// Called when emoji/sticker icon is tapped.
  final VoidCallback? onEmojiTap;

  /// Called when microphone icon is tapped while input is empty.
  final VoidCallback? onVoiceTap;

  /// Input placeholder text.
  final String hintText;

  @override
  State<TelegramChatInputBar> createState() => _TelegramChatInputBarState();
}

class _TelegramChatInputBarState extends State<TelegramChatInputBar> {
  final TextEditingController _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleTextChanged);
  }

  void _handleTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    widget.onSend(text);
    _controller.clear();
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? AppColors.darkSurface : Colors.white;
    final iconColor = isDark
        ? const Color(0xFF8E9BA8)
        : const Color(0xFF757575);
    final textColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final hintColor = isDark
        ? const Color(0xFF7F8C99)
        : const Color(0xFF9E9E9E);

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 4.0,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Emoji / Sticker Button
              IconButton(
                icon: Icon(
                  Icons.sentiment_satisfied_alt_outlined,
                  color: iconColor,
                  size: 24.0,
                ),
                tooltip: 'Emoji',
                onPressed: widget.onEmojiTap,
              ),

              // Expanding Text Field
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: TextField(
                    controller: _controller,
                    maxLines: 5,
                    minLines: 1,
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16.0,
                      height: 1.25,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle: TextStyle(color: hintColor, fontSize: 16.0),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 4.0,
                        vertical: 8.0,
                      ),
                    ),
                  ),
                ),
              ),

              // Attachment Paperclip
              IconButton(
                icon: Icon(
                  Icons.attach_file_rounded,
                  color: iconColor,
                  size: 24.0,
                ),
                tooltip: 'Fayl biriktirish',
                onPressed: widget.onAttachmentTap,
              ),

              // Dynamic Send / Microphone Button
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0, right: 4.0),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  transitionBuilder: (child, animation) =>
                      ScaleTransition(scale: animation, child: child),
                  child: _hasText
                      ? Material(
                          key: const ValueKey('send_btn'),
                          color: AppColors.primaryBlue,
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: _submit,
                            child: const Padding(
                              padding: EdgeInsets.all(8.5),
                              child: Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                                size: 19.0,
                              ),
                            ),
                          ),
                        )
                      : IconButton(
                          key: const ValueKey('mic_btn'),
                          icon: Icon(
                            Icons.mic_rounded,
                            color: iconColor,
                            size: 24.0,
                          ),
                          tooltip: 'Ovozli xabar',
                          onPressed: widget.onVoiceTap,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
