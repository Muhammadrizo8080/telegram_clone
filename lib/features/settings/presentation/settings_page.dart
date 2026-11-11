import 'package:flutter/material.dart';

import 'package:telegram_clone/core/constants/app_constants.dart';
import 'package:telegram_clone/core/widgets/telegram_avatar.dart';

import '../../auth/models/user.dart';
import '../../chats/data/mock_chats.dart';
import '../../profile/presentation/profile_page.dart';

/// Authentic Telegram Settings page matching Android/iOS Telegram UI.
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, this.user, this.onThemeToggle});

  /// The active user. Defaults to [currentUser].
  final User? user;

  /// Optional callback for switching themes.
  final VoidCallback? onThemeToggle;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _isDark;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isDark = Theme.of(context).brightness == Brightness.dark;
  }

  User get _activeUser => widget.user ?? currentUser;

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: isDark ? const Color(0xFF6EB6F5) : AppColors.primaryBlue,
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    required bool isDark,
  }) {
    final iconColor = isDark
        ? const Color(0xFF8E9BA8)
        : const Color(0xFF757575);
    final textColor = isDark ? Colors.white : const Color(0xFF222222);

    return ListTile(
      leading: Icon(icon, color: iconColor, size: 24.0),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15.5,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                fontSize: 13.0,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondaryLight,
              ),
            )
          : null,
      trailing:
          trailing ??
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14.0,
            color: isDark ? const Color(0xFF5A6672) : const Color(0xFFB0B0B0),
          ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 0.0,
      ),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _activeUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkSurface : Colors.white;
    final username = '@${user.name.toLowerCase().replaceAll(' ', '_')}';

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text('Sozlamalar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Qidiruv',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            tooltip: 'Yana',
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          // --- User Profile Header Tile ---
          Material(
            color: cardColor,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ProfilePage(user: user)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    TelegramGradientAvatar(
                      name: user.name,
                      id: user.id,
                      imageUrl: user.avatarUrl,
                      radius: 32.0,
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black87,
                              fontSize: 17.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 3.0),
                          Text(
                            user.phoneOrEmail,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                              fontSize: 13.5,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            username,
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondaryLight,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.qr_code_rounded, size: 26.0),
                      color: isDark
                          ? const Color(0xFF6EB6F5)
                          : AppColors.primaryBlue,
                      tooltip: 'QR Kod',
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12.0),

          // --- Settings Section ---
          Material(
            color: cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Sozlamalar', isDark),
                _buildSettingTile(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: 'Chat sozlamalari',
                  isDark: isDark,
                  onTap: () {},
                ),
                const Divider(indent: 64.0, height: 1.0, thickness: 0.6),
                _buildSettingTile(
                  icon: Icons.lock_outline_rounded,
                  title: 'Maxfiylik va xavfsizlik',
                  isDark: isDark,
                  onTap: () {},
                ),
                const Divider(indent: 64.0, height: 1.0, thickness: 0.6),
                _buildSettingTile(
                  icon: Icons.notifications_outlined,
                  title: 'Bildirishnomalar va ovozlar',
                  isDark: isDark,
                  onTap: () {},
                ),
                const Divider(indent: 64.0, height: 1.0, thickness: 0.6),
                _buildSettingTile(
                  icon: Icons.pie_chart_outline_rounded,
                  title: 'Ma’lumotlar va xotira',
                  isDark: isDark,
                  onTap: () {},
                ),
                const Divider(indent: 64.0, height: 1.0, thickness: 0.6),
                _buildSettingTile(
                  icon: Icons.folder_open_rounded,
                  title: 'Chat jildlari',
                  isDark: isDark,
                  onTap: () {},
                ),
                const Divider(indent: 64.0, height: 1.0, thickness: 0.6),
                _buildSettingTile(
                  icon: Icons.devices_rounded,
                  title: 'Qurilmalar',
                  isDark: isDark,
                  onTap: () {},
                ),
                const Divider(indent: 64.0, height: 1.0, thickness: 0.6),
                _buildSettingTile(
                  icon: Icons.language_rounded,
                  title: 'Til',
                  subtitle: 'O‘zbekcha',
                  isDark: isDark,
                  onTap: () {},
                ),
                const Divider(indent: 64.0, height: 1.0, thickness: 0.6),
                // Theme Toggle Tile
                ListTile(
                  leading: Icon(
                    _isDark ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                    color: isDark
                        ? const Color(0xFF8E9BA8)
                        : const Color(0xFF757575),
                    size: 24.0,
                  ),
                  title: Text(
                    'Tungi rejim',
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.white : const Color(0xFF222222),
                    ),
                  ),
                  trailing: Switch(
                    value: _isDark,
                    activeTrackColor: AppColors.primaryBlue,
                    onChanged: (val) {
                      setState(() {
                        _isDark = val;
                      });
                      if (widget.onThemeToggle != null) {
                        widget.onThemeToggle!();
                      }
                    },
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12.0),

          // --- Help Section ---
          Material(
            color: cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Yordam', isDark),
                _buildSettingTile(
                  icon: Icons.help_outline_rounded,
                  title: 'Telegram imkoniyatlari',
                  isDark: isDark,
                  onTap: () {},
                ),
                const Divider(indent: 64.0, height: 1.0, thickness: 0.6),
                _buildSettingTile(
                  icon: Icons.policy_outlined,
                  title: 'Maxfiylik siyosati',
                  isDark: isDark,
                  onTap: () {},
                ),
              ],
            ),
          ),

          // --- App Version Info Footer ---
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              children: [
                Text(
                  'Telegram Clone for Android v1.0.0 (3421)',
                  style: TextStyle(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  'universal arm64-v8a',
                  style: TextStyle(
                    color: isDark
                        ? const Color(0xFF5A6672)
                        : const Color(0xFFA0A0A0),
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
