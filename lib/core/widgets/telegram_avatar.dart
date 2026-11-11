import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

/// Authentic Telegram gradient avatar component with initials fallback and online indicator.
class TelegramGradientAvatar extends StatelessWidget {
  const TelegramGradientAvatar({
    super.key,
    required this.name,
    this.id,
    this.imageUrl,
    this.radius = AppDimensions.avatarRadiusMedium,
    this.isOnline = false,
    this.onTap,
  });

  /// Name used for generating initials and gradient fallback.
  final String name;

  /// Unique identifier used for stable gradient color assignment.
  final String? id;

  /// Optional remote image URL.
  final String? imageUrl;

  /// Circle radius. Defaults to standard Telegram chat tile size (27.0 -> 54x54 px).
  final double radius;

  /// Displays a small green online dot at the bottom right if true.
  final bool isOnline;

  /// Optional callback when avatar is tapped.
  final VoidCallback? onTap;

  /// Extracts 1 or 2 uppercase letters as initials from a full name.
  static String extractInitials(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';

    final words = trimmed
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .toList();

    if (words.isEmpty) return '?';

    if (words.length == 1) {
      return words[0].characters.first.toUpperCase();
    }

    final first = words[0].characters.first.toUpperCase();
    final second = words[1].characters.first.toUpperCase();
    return '$first$second';
  }

  /// Selects a deterministic gradient pair from [AppColors.avatarGradients].
  static List<Color> getGradientColors(String key) {
    if (key.isEmpty) return AppColors.avatarGradients.first;
    final hash = key.runes.fold<int>(
      0,
      (prev, rune) => (prev * 31 + rune) & 0x7FFFFFFF,
    );
    return AppColors.avatarGradients[hash % AppColors.avatarGradients.length];
  }

  @override
  Widget build(BuildContext context) {
    final effectiveKey = (id != null && id!.isNotEmpty) ? id! : name;
    final gradient = getGradientColors(effectiveKey);
    final initials = extractInitials(name);
    final indicatorSize = (radius * 0.44).clamp(10.0, 16.0);

    Widget avatarContent = Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.78,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );

    if (imageUrl != null && imageUrl!.trim().isNotEmpty) {
      avatarContent = ClipOval(
        child: Image.network(
          imageUrl!,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => avatarContent,
        ),
      );
    }

    Widget rootWidget = Stack(
      clipBehavior: Clip.none,
      children: [
        avatarContent,
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: indicatorSize,
              height: indicatorSize,
              decoration: BoxDecoration(
                color: AppColors.onlineGreen,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: indicatorSize * 0.2,
                ),
              ),
            ),
          ),
      ],
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: rootWidget,
      );
    }

    return rootWidget;
  }
}
