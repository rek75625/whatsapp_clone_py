import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/views/settings/account_settings_page.dart';
import 'package:whatsapp_clone_py/views/settings/chat_settings_page.dart';
import 'package:whatsapp_clone_py/views/settings/notifications_settings_page.dart';
import 'package:whatsapp_clone_py/views/settings/privacy_settings_page.dart';

class UserProfilePage extends StatelessWidget {
  final int selectedIndex;
  const UserProfilePage({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ============================================================
              // PROFILE
              // ============================================================

              _profileSection(
                context,
                name: 'Yash Makan',
                subtitle: 'View profile',
                imageUrl: 'https://images.unsplash.com/photo-1595956553066-fe24a8c33395',
              ),

              const SizedBox(height: 8),

              // ============================================================
              // ACCOUNT
              // ============================================================
              _sectionTitle('Account'),

              _settingsItem(
                context,
                icon: Icons.key_outlined,
                title: 'Account',
                subtitle: 'Security notifications, change number',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AccountPage()),
                  );
                },
              ),

              _settingsItem(
                context,
                icon: Icons.lock_outline,
                title: 'Privacy',
                subtitle: 'Block contacts, disappearing messages',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PrivacyPage()),
                  );
                },
              ),

              // ============================================================
              // CHATS
              // ============================================================
              _sectionTitle('Chats'),

              _settingsItem(
                context,
                icon: Icons.chat_outlined,
                title: 'Chats',
                subtitle: 'Theme, wallpapers, chat history',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ChatsSettingsPage(),
                    ),
                  );
                },
              ),

              // ============================================================
              // NOTIFICATIONS
              // ============================================================
              _sectionTitle('Notifications'),

              _settingsItem(
                context,
                icon: Icons.notifications_none_outlined,
                title: 'Notifications',
                subtitle: 'Message, group and call notifications',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationsPage(),
                    ),
                  );
                },
              ),

              // ============================================================
              // STORAGE
              // ============================================================
              _sectionTitle('Storage and data'),

              _settingsItem(
                context,
                icon: Icons.data_usage_outlined,
                title: 'Storage and data',
                subtitle: 'Network usage, auto-download',
                onTap: () {},
              ),

              // ============================================================
              // APP LANGUAGE
              // ============================================================
              _settingsItem(
                context,
                icon: Icons.language_outlined,
                title: 'App language',
                subtitle: 'English',
                onTap: () {
                  _showLanguageDialog(context);
                },
              ),

              // ============================================================
              // HELP
              // ============================================================
              _sectionTitle('Help'),

              _settingsItem(
                context,
                icon: Icons.help_outline,
                title: 'Help',
                subtitle: 'Help center, contact us, privacy policy',
                onTap: () {},
              ),

              _settingsItem(
                context,
                icon: Icons.group_add_outlined,
                title: 'Invite a friend',
                subtitle: 'Invite your friends to WhatsApp',
                onTap: () {},
              ),

              // ============================================================
              // ABOUT
              // ============================================================
              _settingsItem(
                context,
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'About WhatsApp',
                onTap: () {},
              ),

              const SizedBox(height: 30),

              // ============================================================
              // META
              // ============================================================
              Column(
                children: [
                  Text(
                    'from',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  ),

                  const SizedBox(height: 3),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.all_inclusive,
                        size: 20,
                        color: Colors.teal.shade400,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Meta',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // PROFILE
  // ========================================================================

  static Widget _profileSection(
    BuildContext context, {
    required String name,
    required String subtitle,
    required String imageUrl,
  }) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                imageUrl,
                width: 62,
                height: 62,
                fit: BoxFit.cover,

                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 62,
                    height: 62,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.person,
                      size: 32,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            Icon(Icons.qr_code_2, size: 28, color: Colors.teal.shade600),
          ],
        ),
      ),
    );
  }

  // ========================================================================
  // SECTION TITLE
  // ========================================================================

  static Widget _sectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, top: 16, bottom: 6),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.teal.shade600,
          letterSpacing: .4,
        ),
      ),
    );
  }

  // ========================================================================
  // SETTINGS ITEM
  // ========================================================================

  static Widget _settingsItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 42,
              child: Icon(icon, size: 25, color: Colors.grey.shade700),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ========================================================================
  // LANGUAGE DIALOG
  // ========================================================================

  static void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('App language'),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _languageOption(context, 'English'),
              _languageOption(context, 'اردو'),
              _languageOption(context, 'العربية'),
            ],
          ),
        );
      },
    );
  }

  static Widget _languageOption(BuildContext context, String language) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            const Icon(Icons.radio_button_unchecked),

            const SizedBox(width: 12),

            Text(language, style: const TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
