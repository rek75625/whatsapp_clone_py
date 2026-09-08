import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';

class UserProfilePage extends StatefulWidget {
  final int selectedIndex;

  const UserProfilePage({super.key, required this.selectedIndex});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool notificationsEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 22),

                    // =====================================================
                    // PROFILE
                    // =====================================================
                    Row(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1595956553066-fe24a8c33395',
                                width: 54,
                                height: 54,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 54,
                                    height: 54,
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.person,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Online indicator
                            Positioned(
                              right: -1,
                              top: -1,
                              child: Container(
                                width: 17,
                                height: 17,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(2),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Yash Makan',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 3),
                              Text(
                                'View profile',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Logout icon
                        Icon(
                          Icons.logout_rounded,
                          color: Color(0xffe57373),
                          size: 23,
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // Divider
                    Container(
                      height: 1,
                      margin: const EdgeInsets.only(left: 68, right: 60),
                      color: Colors.grey.shade200,
                    ),

                    const SizedBox(height: 20),

                    // =====================================================
                    // NOTIFICATIONS
                    // =====================================================
                    Row(
                      children: [
                        const Icon(
                          Icons.notifications_none_rounded,
                          size: 22,
                          color: Color(0xff555555),
                        ),

                        const SizedBox(width: 17),

                        const Expanded(
                          child: Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff333333),
                            ),
                          ),
                        ),

                        Switch(
                          value: notificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              notificationsEnabled = value;
                            });
                          },
                          activeThumbColor: Colors.white,
                          activeTrackColor: const Color(0xff54d889),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // =====================================================
                    // MANAGE TITLE
                    // =====================================================
                    const Text(
                      'MANAGE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff777777),
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // =====================================================
                    // SETTINGS
                    // =====================================================
                    _settingsItem(
                      icon: Icons.settings_outlined,
                      title: 'Settings',
                      onTap: () {
                        debugPrint('Settings tapped');
                      },
                    ),

                    // =====================================================
                    // SHARE
                    // =====================================================
                    _settingsItem(
                      icon: Icons.reply_rounded,
                      title: 'Share',
                      onTap: () {
                        debugPrint('Share tapped');
                      },
                    ),

                    // =====================================================
                    // CHANGE PASSWORD
                    // =====================================================
                    _settingsItem(
                      icon: Icons.lock_outline_rounded,
                      title: 'Change Password',
                      onTap: () {
                        debugPrint('Change Password tapped');
                      },
                    ),

                    // =====================================================
                    // FAQ
                    // =====================================================
                    _settingsItem(
                      icon: Icons.chat_bubble_outline_rounded,
                      title: 'FAQ',
                      onTap: () {
                        debugPrint('FAQ tapped');
                      },
                    ),

                    // =====================================================
                    // HELP
                    // =====================================================
                    _settingsItem(
                      icon: Icons.help_outline_rounded,
                      title: 'Help',
                      onTap: () {
                        debugPrint('Help tapped');
                      },
                    ),

                    // =====================================================
                    // INVITE A FRIEND
                    // =====================================================
                    _settingsItem(
                      icon: Icons.group_add_outlined,
                      title: 'Invite a friend',
                      onTap: () {
                        debugPrint('Invite a friend tapped');
                      },
                    ),

                    const SizedBox(height: 25),

                    // =====================================================
                    // FROM META
                    // =====================================================
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'from',
                            style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey.shade500,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.all_inclusive_rounded,
                                size: 20,
                                color: Colors.teal.shade300,
                              ),
                              const SizedBox(width: 3),
                              const Text(
                                'Meta',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff555555),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================================
  // SETTINGS ITEM
  // =====================================================================

  Widget _settingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 43,
        child: Row(
          children: [
            SizedBox(
              width: 32,
              child: Icon(icon, size: 21, color: const Color(0xff555555)),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff333333),
                ),
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              size: 22,
              color: Color(0xff777777),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================================
  // BOTTOM ITEM
  // =====================================================================
}
