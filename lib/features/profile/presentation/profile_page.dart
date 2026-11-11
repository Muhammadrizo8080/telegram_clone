import 'package:flutter/material.dart';

import 'package:telegram_clone/core/constants/app_constants.dart';
import 'package:telegram_clone/core/widgets/telegram_avatar.dart';

import '../../auth/models/user.dart';
import '../../chats/data/mock_chats.dart';

/// Authentic Telegram Profile page displaying contact/user details and actions.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.user});

  /// The user profile being viewed. Defaults to [currentUser].
  final User? user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notificationsEnabled = true;

  User get _profileUser => widget.user ?? currentUser;

  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 24.0),
            const SizedBox(height: 6.0),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? Colors.white : Colors.black87;
    final secondaryColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: primaryColor,
                fontSize: 15.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2.0),
            Text(
              subtitle,
              style: TextStyle(color: secondaryColor, fontSize: 12.5),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _profileUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final headerColor = isDark ? AppColors.darkSurface : AppColors.primaryBlue;
    final username = '@${user.name.toLowerCase().replaceAll(' ', '_')}';

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : const Color(0xFFF0F2F5),
      body: CustomScrollView(
        slivers: [
          // --- Telegram Profile Header with large avatar & quick actions ---
          SliverAppBar(
            expandedHeight: 280.0,
            pinned: true,
            backgroundColor: headerColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: headerColor,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 36.0,
                  bottom: 12.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TelegramGradientAvatar(
                      name: user.name,
                      id: user.id,
                      imageUrl: user.avatarUrl,
                      radius: 46.0,
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      user.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 21.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    const Text(
                      'onlayn',
                      style: TextStyle(
                        color: Color(0xFFC7E3FF),
                        fontSize: 13.0,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildQuickAction(
                          icon: Icons.call_outlined,
                          label: 'Qo‘ng‘iroq',
                          onTap: () {},
                        ),
                        _buildQuickAction(
                          icon: Icons.videocam_outlined,
                          label: 'Video',
                          onTap: () {},
                        ),
                        _buildQuickAction(
                          icon: Icons.notifications_off_outlined,
                          label: 'Ovozni o‘chirish',
                          onTap: () {},
                        ),
                        _buildQuickAction(
                          icon: Icons.search_rounded,
                          label: 'Qidiruv',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // --- Profile Info Content ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  // Info Card
                  Material(
                    color: isDark ? AppColors.darkSurface : Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                            20.0,
                            14.0,
                            20.0,
                            4.0,
                          ),
                          child: Text(
                            'Ma’lumot',
                            style: TextStyle(
                              color: isDark
                                  ? const Color(0xFF6EB6F5)
                                  : AppColors.primaryBlue,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        _buildInfoTile(
                          context: context,
                          title: user.phoneOrEmail,
                          subtitle: 'Mobil telefon',
                          onTap: () {},
                        ),
                        const Divider(
                          indent: 20.0,
                          height: 1.0,
                          thickness: 0.6,
                        ),
                        _buildInfoTile(
                          context: context,
                          title: username,
                          subtitle: 'Foydalanuvchi nomi',
                          onTap: () {},
                        ),
                        const Divider(
                          indent: 20.0,
                          height: 1.0,
                          thickness: 0.6,
                        ),
                        _buildInfoTile(
                          context: context,
                          title:
                              'Flutter Developer | Building Telegram Clone 🚀',
                          subtitle: 'Tarjimai hol (Bio)',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12.0),

                  // Notifications Setting Card
                  Material(
                    color: isDark ? AppColors.darkSurface : Colors.white,
                    child: SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ),
                      title: Text(
                        'Bildirishnomalar',
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                          fontSize: 15.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        _notificationsEnabled ? 'Yoqilgan' : 'O‘chirilgan',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondaryLight,
                          fontSize: 12.5,
                        ),
                      ),
                      activeTrackColor: AppColors.primaryBlue,
                      value: _notificationsEnabled,
                      onChanged: (val) {
                        setState(() {
                          _notificationsEnabled = val;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 12.0),

                  // Media and Files
                  Material(
                    color: isDark ? AppColors.darkSurface : Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.photo_library_outlined,
                            color: isDark
                                ? const Color(0xFF8E9BA8)
                                : const Color(0xFF757575),
                          ),
                          title: const Text('Media va rasmlar'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15.0,
                          ),
                          onTap: () {},
                        ),
                        const Divider(
                          indent: 56.0,
                          height: 1.0,
                          thickness: 0.6,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.insert_drive_file_outlined,
                            color: isDark
                                ? const Color(0xFF8E9BA8)
                                : const Color(0xFF757575),
                          ),
                          title: const Text('Fayllar va hujjatlar'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15.0,
                          ),
                          onTap: () {},
                        ),
                        const Divider(
                          indent: 56.0,
                          height: 1.0,
                          thickness: 0.6,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.link_rounded,
                            color: isDark
                                ? const Color(0xFF8E9BA8)
                                : const Color(0xFF757575),
                          ),
                          title: const Text('Ulashilgan havolalar'),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15.0,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
