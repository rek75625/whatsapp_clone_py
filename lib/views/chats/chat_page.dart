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
                child: ChatTileList(
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

// ============================================================
// CALLS
// ============================================================

class CallsPage extends StatelessWidget {
  const CallsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calls',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: const [
          Icon(Icons.search),
          SizedBox(width: 20),
          Icon(Icons.more_vert),
          SizedBox(width: 10),
        ],
      ),
      body: const Center(
        child: Text(
          'Calls',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// ============================================================
// COMMUNITIES
// ============================================================

class CommunitiesPage extends StatelessWidget {
  const CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Communities',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: const [Icon(Icons.more_vert), SizedBox(width: 15)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F9ED),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.groups, size: 45, color: Color(0xFF008069)),
                SizedBox(width: 18),
                Expanded(
                  child: Text(
                    'Stay connected with communities and groups.',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
