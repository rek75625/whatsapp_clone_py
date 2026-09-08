import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';
import 'package:whatsapp_clone_py/views/homepage/widgets/home_nave_enums.dart';
import 'package:whatsapp_clone_py/widgets/chat_tiles_list.dart';
import 'package:whatsapp_clone_py/widgets/page_header.dart';
import 'package:whatsapp_clone_py/widgets/search_textfield.dart';
import 'package:whatsapp_clone_py/widgets/story_and_status.dart';

class UpdatePage extends StatefulWidget {
  final ScrollController scrollController;
  final int selectedIndex;
  const UpdatePage({
    super.key,
    required this.scrollController,
    required this.selectedIndex,
  });

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
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
// UPDATES PAGE
// ============================================================

class UpdatesPage extends StatelessWidget {
  const UpdatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Updates',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined, size: 25),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 26),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, size: 26),
          ),
        ],
      ),

      body: ListView(
        padding: EdgeInsets.zero,
        children: const [
          // --------------------------------------------------
          // STATUS HEADER
          // --------------------------------------------------

          Padding(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
            child: Text(
              'Status',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
            ),
          ),

          // --------------------------------------------------
          // MY STATUS
          // --------------------------------------------------
          MyStatusCard(),

          SizedBox(height: 15),

          // --------------------------------------------------
          // RECENT UPDATES
          // --------------------------------------------------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Recent updates',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          SizedBox(height: 8),

          StatusItem(
            name: 'Ali Khan',
            time: 'Today, 9:45 AM',
            image: 'https://i.pravatar.cc/150?img=12',
          ),

          StatusItem(
            name: 'Sara Ahmed',
            time: 'Today, 8:30 AM',
            image: 'https://i.pravatar.cc/150?img=47',
          ),

          StatusItem(
            name: 'Usman',
            time: 'Today, 7:15 AM',
            image: 'https://i.pravatar.cc/150?img=33',
          ),

          StatusItem(
            name: 'Ayesha',
            time: 'Today, 6:50 AM',
            image: 'https://i.pravatar.cc/150?img=44',
          ),

          SizedBox(height: 25),

          // --------------------------------------------------
          // CHANNELS
          // --------------------------------------------------
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Channels',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w700),
                  ),
                ),
                Text(
                  'Explore',
                  style: TextStyle(
                    color: Color(0xFF008069),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10),

          ChannelItem(
            name: 'WhatsApp',
            description: 'Welcome to the official WhatsApp channel',
            icon: Icons.whatshot,
          ),

          ChannelItem(
            name: 'Tech News',
            description: 'Latest technology updates and news',
            icon: Icons.computer,
          ),

          ChannelItem(
            name: 'Sports Updates',
            description: 'Live scores, news and highlights',
            icon: Icons.sports_soccer,
          ),

          ChannelItem(
            name: 'Business Today',
            description: 'Business and market updates',
            icon: Icons.business_center,
          ),

          SizedBox(height: 80),
        ],
      ),

      // ----------------------------------------------------
      // FLOATING BUTTONS
      // ----------------------------------------------------
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: 'edit',
            backgroundColor: const Color(0xFFE9F7E7),
            foregroundColor: const Color(0xFF008069),
            onPressed: () {},
            child: const Icon(Icons.edit),
          ),

          const SizedBox(height: 12),

          FloatingActionButton(
            heroTag: 'camera',
            backgroundColor: const Color(0xFF00A884),
            foregroundColor: Colors.white,
            onPressed: () {},
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// MY STATUS
// ============================================================

class MyStatusCard extends StatelessWidget {
  const MyStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),

      leading: Stack(
        children: [
          const CircleAvatar(
            radius: 29,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
          ),

          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 21,
              height: 21,
              decoration: BoxDecoration(
                color: const Color(0xFF00A884),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(Icons.add, size: 15, color: Colors.white),
            ),
          ),
        ],
      ),

      title: const Text(
        'My status',
        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),

      subtitle: const Text(
        'Tap to add status update',
        style: TextStyle(color: Colors.grey),
      ),

      onTap: () {},
    );
  }
}

// ============================================================
// STATUS ITEM
// ============================================================

class StatusItem extends StatelessWidget {
  final String name;
  final String time;
  final String image;

  const StatusItem({
    super.key,
    required this.name,
    required this.time,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),

      leading: Container(
        padding: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF00A884),
        ),
        child: CircleAvatar(
          radius: 27,
          backgroundColor: Colors.white,
          child: CircleAvatar(radius: 25, backgroundImage: NetworkImage(image)),
        ),
      ),

      title: Text(
        name,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      ),

      subtitle: Text(
        time,
        style: const TextStyle(color: Colors.grey, fontSize: 14),
      ),

      onTap: () {},
    );
  }
}

// ============================================================
// CHANNEL ITEM
// ============================================================

class ChannelItem extends StatelessWidget {
  final String name;
  final String description;
  final IconData icon;

  const ChannelItem({
    super.key,
    required this.name,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),

      leading: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: const Color(0xFFE7F5E5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: const Color(0xFF008069), size: 28),
      ),

      title: Text(
        name,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      ),

      subtitle: Text(
        description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.grey),
      ),

      trailing: const Icon(Icons.chevron_right, color: Colors.grey),

      onTap: () {},
    );
  }
}
