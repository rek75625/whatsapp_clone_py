import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool conversationTones = true;
  bool messageNotifications = true;
  bool groupNotifications = true;
  bool callNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: Column(
        children: [
          _switchItem(
            title: 'Conversation tones',
            subtitle: 'Play sounds for incoming and outgoing messages',
            value: conversationTones,
            onChanged: (value) {
              setState(() {
                conversationTones = value;
              });
            },
          ),

          _switchItem(
            title: 'Message notifications',
            subtitle: 'Show notifications for messages',
            value: messageNotifications,
            onChanged: (value) {
              setState(() {
                messageNotifications = value;
              });
            },
          ),

          _switchItem(
            title: 'Group notifications',
            subtitle: 'Show notifications for group messages',
            value: groupNotifications,
            onChanged: (value) {
              setState(() {
                groupNotifications = value;
              });
            },
          ),

          _switchItem(
            title: 'Call notifications',
            subtitle: 'Show notifications for incoming calls',
            value: callNotifications,
            onChanged: (value) {
              setState(() {
                callNotifications = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _switchItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),

          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
