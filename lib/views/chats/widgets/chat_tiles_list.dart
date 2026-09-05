import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/views/chats/widgets/chat_page_tile.dart';
import 'package:whatsapp_clone_py/views/chats/model/chats_contact_models.dart';

class ChatTilesList extends StatelessWidget {
  const ChatTilesList({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(width: double.infinity, child: ChatContactList()),
        ),
      ),
    );
  }
}

class ChatContactList extends StatelessWidget {
  const ChatContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final chat = contacts[index];

        return ChatContactItem(
          index: index,
          chat: chat,

          onTap: () {
            debugPrint('Open chat: ${chat.username}');
          },
        );
      },
    );
  }
}
