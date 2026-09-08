import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';
import 'package:whatsapp_clone_py/views/homepage/widgets/home_nave_enums.dart';
import 'package:whatsapp_clone_py/widgets/chat_tiles_list.dart';
import 'package:whatsapp_clone_py/widgets/page_header.dart';
import 'package:whatsapp_clone_py/widgets/search_textfield.dart';
import 'package:whatsapp_clone_py/widgets/story_and_status.dart';

class ChatPage extends StatefulWidget {
  final ScrollController scrollController;
  final int selectedIndex;
  const ChatPage({
    super.key,
    required this.scrollController,
    required this.selectedIndex,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isSearch = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: SafeArea(
        child: Padding(
          padding: AppSizes.padHori16,
          child: Column(
            children: [
              AppSizes.height8,
              PageHeader(
                isSearch: isSearch,
                pageTitle: "Chats",
                onPressed: () {
                  setState(() {
                    isSearch = !isSearch;
                  });
                },
              ),
              SearchTextfield(
                isSearch: isSearch,
                searchController: searchController,
              ),
              AppSizes.height8,
              Divider(color: AppColors.lightGrey, thickness: 1.0),
              AppSizes.height8,
              StoryAndStatus(
                addStatus: false,
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
              Divider(color: AppColors.lightGrey, thickness: 1.0),

              Expanded(
                child: ChatTilesList(
                  isSearch: isSearch,
                  searchController: searchController,
                  selectedSection: getHomeSection(widget.selectedIndex),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Open new chat');
        },
        backgroundColor: AppColors.greenColor,
        child: Icon(Icons.add_box_sharp, color: Colors.white),
      ),
    );
  }
}
