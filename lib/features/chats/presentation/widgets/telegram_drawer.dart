import 'package:flutter/material.dart';

import 'package:telegram_clone/core/constants/app_constants.dart';
import 'package:telegram_clone/core/widgets/telegram_avatar.dart';

import '../../../auth/models/user.dart';
import '../../../profile/presentation/profile_page.dart';
import '../../../settings/presentation/settings_page.dart';
import '../../data/mock_chats.dart';

/// Authentic Telegram navigation drawer with user profile header and menu items.
class TelegramDrawer extends StatelessWidget {
  const TelegramDrawer({
    super.key,
    this.user = currentUser,
    this.onThemeToggle,
  });

  /// Current user data displayed in the header.
  final User user;

  /// Optional callback for toggling dark/light mode.
  final VoidCallback? onThemeToggle;

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark
        ? const Color(0xFF8E9BA8)
        : const Color(0xFF757575);
    final textColor = isDark ? Colors.white : const Color(0xFF222222);

    return ListTile(
      leading: Icon(icon, color: iconColor, size: 24.0),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: textColor,
          letterSpacing: 0.1,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 0.0,
      ),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
      onTap: () {
        Navigator.pop(context); // Close drawer
        if (onTap != null) {
          onTap();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerColor = isDark ? AppColors.darkSurface : AppColors.primaryBlue;

    return Drawer(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.lightBackground,
      child: Column(
        children: [
          // --- Telegram Profile Header ---
          Container(
            color: headerColor,
            padding: EdgeInsets.fromLTRB(
              20.0,
              MediaQuery.of(context).padding.top + 16.0,
              16.0,
              16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TelegramGradientAvatar(
                      name: user.name,
                      id: user.id,
                      imageUrl: user.avatarUrl,
                      radius: 32.0,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProfilePage(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        isDark
                            ? Icons.wb_sunny_rounded
                            : Icons.nightlight_round,
                        color: Colors.white,
                        size: 22.0,
                      ),
                      tooltip: isDark ? 'Light Mode' : 'Dark Mode',
                      onPressed: onThemeToggle,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              user.phoneOrEmail,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                        size: 26.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // --- Drawer Menu Items ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children: [
                _buildDrawerItem(
                  context: context,
                  icon: Icons.group_outlined,
                  title: 'New Group',
                  onTap: () {},
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.person_outline_rounded,
                  title: 'Contacts',
                  onTap: () {},
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.call_outlined,
                  title: 'Calls',
                  onTap: () {},
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.bookmark_border_rounded,
                  title: 'Saved Messages',
                  onTap: () {},
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsPage()),
                    );
                  },
                ),
                const Divider(height: 16.0, thickness: 0.8),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.person_add_alt_1_outlined,
                  title: 'Invite Friends',
                  onTap: () {},
                ),
                _buildDrawerItem(
                  context: context,
                  icon: Icons.help_outline_rounded,
                  title: 'Telegram Features',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
