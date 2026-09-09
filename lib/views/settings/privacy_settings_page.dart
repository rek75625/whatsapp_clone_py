import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/views/settings/widgets/simple_settings_page.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return simpleSettingsPage(
      context,
      title: 'Privacy',
      children: [
        simpleItem(
          icon: Icons.visibility_outlined,
          title: 'Last seen and online',
          subtitle: 'Choose who can see your last seen and online status',
        ),
        simpleItem(
          icon: Icons.person_outline,
          title: 'Profile photo',
          subtitle: 'Choose who can see your profile photo',
        ),
        simpleItem(
          icon: Icons.info_outline,
          title: 'About',
          subtitle: 'Choose who can see your About',
        ),
        simpleItem(
          icon: Icons.remove_red_eye_outlined,
          title: 'Read receipts',
          subtitle: 'Turn read receipts on or off',
        ),
        simpleItem(
          icon: Icons.timer_outlined,
          title: 'Disappearing messages',
          subtitle: 'Default message timer',
        ),
        simpleItem(
          icon: Icons.block,
          title: 'Blocked contacts',
          subtitle: 'Manage blocked contacts',
        ),
      ],
    );
  }
}
