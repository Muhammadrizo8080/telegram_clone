import 'package:flutter/material.dart';

/// Authentic Telegram color palette (Android & iOS matching).
class AppColors {
  AppColors._();

  // --- Telegram Primary & Brand Colors ---
  /// Classic Android Telegram AppBar Blue
  static const Color primaryBlue = Color(0xFF517DA2);

  /// Telegram vibrant action blue (links, active buttons, FAB)
  static const Color accentBlue = Color(0xFF2481CC);

  // --- Backgrounds & Surfaces ---
  /// Chats list and screen background in light mode
  static const Color lightBackground = Color(0xFFFFFFFF);

  /// Telegram dark background for main list
  static const Color darkBackground = Color(0xFF0E1621);

  /// Light surface (cards, search bars, text fields)
  static const Color lightSurface = Color(0xFFF4F4F5);

  /// Telegram dark surface for AppBar, Drawer, and cards
  static const Color darkSurface = Color(0xFF17212B);

  /// Default chat wallpaper background color in light mode
  static const Color lightChatBackground = Color(0xFF8FB4CA);

  /// Default chat wallpaper background in dark mode
  static const Color darkChatBackground = Color(0xFF0E1621);

  // --- Message Bubbles ---
  /// Incoming message bubble in light mode (pure white)
  static const Color incomingBubbleLight = Color(0xFFFFFFFF);

  /// Incoming message bubble in dark mode
  static const Color incomingBubbleDark = Color(0xFF182533);

  /// Outgoing message bubble in light mode (Telegram classic light green)
  static const Color outgoingBubbleLight = Color(0xFFEFFDDE);

  /// Outgoing message bubble in dark mode (Telegram soft dark blue)
  static const Color outgoingBubbleDark = Color(0xFF2B5278);

  // --- Typography & Meta ---
  static const Color textPrimaryLight = Color(0xFF000000);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryLight = Color(0xFF707579);
  static const Color textSecondaryDark = Color(0xFF7F8C99);

  /// Outgoing message bubble timestamp and check tick color in light mode
  static const Color outgoingMetaLight = Color(0xFF539C50);

  /// Incoming message bubble timestamp color in light mode
  static const Color incomingMetaLight = Color(0xFFA0ACB6);

  /// Timestamp in dark mode
  static const Color bubbleMetaDark = Color(0xFF8294A5);

  // --- Badges, Status & Accents ---
  /// Unread messages counter badge (Telegram bright cyan-blue)
  static const Color unreadBadge = Color(0xFF4FA0E5);

  /// Muted chat badge (muted grey)
  static const Color unreadBadgeMuted = Color(0xFFC4C9CC);

  /// Online status green indicator
  static const Color onlineGreen = Color(0xFF40C351);

  /// Double check tick icon color
  static const Color readCheckBlue = Color(0xFF4FA0E5);

  /// Date chip background in chat history (translucent black)
  static const Color dateChipBackground = Color(0x33000000);

  // --- Avatar Gradient Pairs (Telegram algorithm by user id/name) ---
  static const List<List<Color>> avatarGradients = [
    [Color(0xFFFF885E), Color(0xFFFF5151)], // Red / Coral
    [Color(0xFFFFCD6A), Color(0xFFFFA85C)], // Orange / Amber
    [Color(0xFFB694F9), Color(0xFF8063F3)], // Violet / Purple
    [Color(0xFF67DF89), Color(0xFF38B868)], // Green / Emerald
    [Color(0xFF68C9F7), Color(0xFF2E9EE4)], // Cyan / Sky
    [Color(0xFF70A6FF), Color(0xFF447DF7)], // Royal Blue
    [Color(0xFFFF7DA7), Color(0xFFF3497F)], // Pink / Rose
  ];
}

/// Spacing, dimensions, and border radius constants matching Telegram specs.
class AppDimensions {
  AppDimensions._();

  // Spacings
  static const double spacingExtraSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 12.0;
  static const double spacingLarge = 16.0;
  static const double spacingExtraLarge = 24.0;

  // Telegram Chat Tile Metrics
  static const double chatTileHeight = 72.0;
  static const double avatarRadiusSmall = 20.0;
  static const double avatarRadiusMedium =
      27.0; // Standard Telegram chat list avatar (54x54)
  static const double avatarRadiusLarge = 48.0;

  // Border Radiuses
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusBubble = 16.0;
  static const double radiusBubbleNip = 4.0; // Corner with message tail
  static const double radiusCircular = 999.0;
}
