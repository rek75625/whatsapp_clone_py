import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/model/chats_contact_models.dart';
import 'package:whatsapp_clone_py/views/homepage/widgets/custom_loader.dart';
import 'package:whatsapp_clone_py/widgets/chat_page_tile.dart';

class ChatTilesList extends StatelessWidget {
  final bool isSearch;
  final int selectedIndex;
  final TextEditingController searchController;
  const ChatTilesList({
    super.key,
    required this.isSearch,
    required this.searchController,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: ChatContactList(
              selectedIndex: selectedIndex,
              isSearch: isSearch,
              searchController: searchController,
            ),
          ),
        ),
      ),
    );
  }
}

class ChatContactList extends StatelessWidget {
  final bool isSearch;
  final int selectedIndex;
  final TextEditingController searchController;
  const ChatContactList({
    super.key,
    required this.isSearch,
    required this.searchController,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return isSearch & searchController.text.trim().isNotEmpty
        ? Center(child: customLoader(context))
        : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final chat = contacts[index];

              return ChatPageTile(
                selectedIndex: selectedIndex,
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
