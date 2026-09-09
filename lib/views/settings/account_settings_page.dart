import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/views/settings/widgets/simple_settings_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return simpleSettingsPage(
      context,
      title: 'Account',
      children: [
        simpleItem(
          icon: Icons.security_outlined,
          title: 'Security notifications',
          subtitle: 'Get notified when your security code changes',
        ),
        simpleItem(
          icon: Icons.phone_android_outlined,
          title: 'Change number',
          subtitle: 'Change the phone number associated with your account',
        ),
        simpleItem(
          icon: Icons.download_outlined,
          title: 'Request account info',
          subtitle: 'Create a report of your account information',
        ),
        simpleItem(
          icon: Icons.delete_outline,
          title: 'Delete account',
          subtitle: 'Permanently delete your account',
        ),
      ],
    );
  }
}
