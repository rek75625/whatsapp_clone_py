import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/views/settings/widgets/simple_settings_page.dart';

class ChatsSettingsPage extends StatelessWidget {
  const ChatsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return simpleSettingsPage(
      context,
      title: 'Chats',
      children: [
        simpleItem(
          icon: Icons.brightness_6_outlined,
          title: 'Theme',
          subtitle: 'System default',
        ),
        simpleItem(
          icon: Icons.wallpaper_outlined,
          title: 'Wallpaper',
          subtitle: 'Change chat wallpaper',
        ),
        simpleItem(
          icon: Icons.archive_outlined,
          title: 'Archived chats',
          subtitle: 'Manage archived chats',
        ),
        simpleItem(
          icon: Icons.backup_outlined,
          title: 'Chat backup',
          subtitle: 'Back up your chats',
        ),
        simpleItem(
          icon: Icons.history,
          title: 'Chat history',
          subtitle: 'Export or clear chat history',
        ),
      ],
    );
  }
}
