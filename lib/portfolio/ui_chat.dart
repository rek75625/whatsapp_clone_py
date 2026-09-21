import 'package:flutter/material.dart';

void main() {
  runApp(const NexaChatApp());
}

class NexaChatApp extends StatelessWidget {
  const NexaChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NexaChat',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B5FEF),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
      ),
      home: const ChatHomeScreens(),
    );
  }
}

// ============================================================
// MODELS
// ============================================================

class ChatUser {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final bool online;
  final int unread;

  const ChatUser({
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    this.online = false,
    this.unread = 0,
  });
}

const users = [
  ChatUser(
    name: 'Sarah Khan',
    message: 'Hey! How are you today?',
    time: '9:24 PM',
    avatar: 'S',
    online: true,
    unread: 2,
  ),
  ChatUser(
    name: 'Alex Johnson',
    message: 'Let\'s catch up tomorrow.',
    time: '8:15 PM',
    avatar: 'A',
    online: true,
    unread: 1,
  ),
  ChatUser(
    name: 'Emma Wilson',
    message: 'That sounds great! 😊',
    time: '7:42 PM',
    avatar: 'E',
    online: true,
  ),
  ChatUser(
    name: 'David Lee',
    message: 'See you soon.',
    time: '6:20 PM',
    avatar: 'D',
    online: false,
  ),
  ChatUser(
    name: 'Ayesha Malik',
    message: 'Okay, see you soon!',
    time: '3:45 PM',
    avatar: 'A',
    online: true,
  ),
  ChatUser(
    name: 'Raza Ahmed',
    message: 'I have updated the docs.',
    time: '2:30 PM',
    avatar: 'R',
    online: false,
  ),
  ChatUser(
    name: 'Hina Sheikh',
    message: 'Thanks for your help.',
    time: '1:10 PM',
    avatar: 'H',
    online: false,
  ),
];

// ============================================================
// HOME
// ============================================================

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  int selectedIndex = 0;

  final pages = const [
    ChatsPage(),
    ContactsPage(),
    GroupsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = constraints.maxWidth >= 1000;

        if (desktop) {
          return Scaffold(
            body: Row(
              children: [
                DesktopSidebar(
                  selectedIndex: selectedIndex,
                  onChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
                Expanded(child: pages[selectedIndex]),
              ],
            ),
          );
        }

        return Scaffold(
          body: pages[selectedIndex],
          bottomNavigationBar: MobileBottomNavigation(
            selectedIndex: selectedIndex,
            onChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}

// ============================================================
// DESKTOP SIDEBAR
// ============================================================

class DesktopSidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const DesktopSidebar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFE7E8F0))),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 28),

            // Logo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF625BFF), Color(0xFF8C52FF)],
                      ),
                    ),
                    child: const Icon(Icons.forum_rounded, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'NexaChat',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 45),

            _item(
              icon: Icons.chat_bubble_outline_rounded,
              activeIcon: Icons.chat_bubble_rounded,
              title: 'Chats',
              index: 0,
            ),

            _item(
              icon: Icons.people_outline_rounded,
              activeIcon: Icons.people_rounded,
              title: 'Contacts',
              index: 1,
            ),

            _item(
              icon: Icons.groups_outlined,
              activeIcon: Icons.groups_rounded,
              title: 'Groups',
              index: 2,
            ),

            _item(
              icon: Icons.person_outline_rounded,
              activeIcon: Icons.person_rounded,
              title: 'Profile',
              index: 3,
            ),

            const Spacer(),

            Container(
              margin: const EdgeInsets.all(18),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: const Color(0xFFF5F4FF),
              ),
              child: const Column(
                children: [
                  Icon(Icons.lock_outline_rounded, color: Color(0xFF625BFF)),
                  SizedBox(height: 8),
                  Text(
                    'Your chats are private',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Secure conversations made simple.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item({
    required IconData icon,
    required IconData activeIcon,
    required String title,
    required int index,
  }) {
    final active = selectedIndex == index;

    return InkWell(
      onTap: () => onChanged(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: active ? const Color(0xFFF0EFFF) : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              active ? activeIcon : icon,
              color: active ? const Color(0xFF625BFF) : const Color(0xFF777A87),
            ),
            const SizedBox(width: 14),
            Text(
              title,
              style: TextStyle(
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                color: active
                    ? const Color(0xFF625BFF)
                    : const Color(0xFF5D606D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CHAT PAGE
// ============================================================

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final filtered = users
        .where((user) => user.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search conversations...',
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: const Color(0xFFEEF0F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          _stories(),

          const SizedBox(height: 12),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final user = filtered[index];

                return ChatTile(
                  user: user,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ChatScreen(user: user)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 18),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Messages',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 4),
                Text(
                  'Stay connected with your people',
                  style: TextStyle(color: Color(0xFF858895)),
                ),
              ],
            ),
          ),
          _roundButton(Icons.edit_rounded, () {}),
        ],
      ),
    );
  }

  Widget _roundButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: const Color(0xFF625BFF),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: const SizedBox(
          width: 46,
          height: 46,
          child: Icon(Icons.edit_rounded, color: Colors.white),
        ),
      ),
    );
  }

  Widget _stories() {
    return SizedBox(
      height: 92,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        children: [
          const StoryAvatar(name: 'My Story', avatar: '+', isAdd: true),
          ...users
              .take(5)
              .map(
                (user) => StoryAvatar(
                  name: user.name.split(' ').first,
                  avatar: user.avatar,
                  online: user.online,
                ),
              ),
        ],
      ),
    );
  }
}

// ============================================================
// CHAT TILE
// ============================================================

class ChatTile extends StatelessWidget {
  final ChatUser user;
  final VoidCallback onTap;

  const ChatTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
          child: Row(
            children: [
              UserAvatar(letter: user.avatar, online: user.online, size: 56),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF858895),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    user.time,
                    style: const TextStyle(
                      color: Color(0xFF9699A5),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 7),

                  if (user.unread > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF625BFF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${user.unread}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// STORY AVATAR
// ============================================================

class StoryAvatar extends StatelessWidget {
  final String name;
  final String avatar;
  final bool online;
  final bool isAdd;

  const StoryAvatar({
    super.key,
    required this.name,
    required this.avatar,
    this.online = false,
    this.isAdd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 58,
                height: 58,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: isAdd
                        ? [const Color(0xFF625BFF), const Color(0xFF8C52FF)]
                        : [const Color(0xFF625BFF), const Color(0xFFEF5DA8)],
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(3),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFFE9E9F8),
                    child: Text(
                      avatar,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF625BFF),
                      ),
                    ),
                  ),
                ),
              ),

              if (online)
                Positioned(
                  right: 1,
                  bottom: 3,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF27C281),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// USER AVATAR
// ============================================================

class UserAvatar extends StatelessWidget {
  final String letter;
  final bool online;
  final double size;

  const UserAvatar({
    super.key,
    required this.letter,
    this.online = false,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: size / 2,
          backgroundColor: const Color(0xFFE4E5F7),
          child: Text(
            letter,
            style: TextStyle(
              fontSize: size * .34,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF625BFF),
            ),
          ),
        ),
        if (online)
          Positioned(
            right: 1,
            bottom: 1,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFF25C281),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}

// ============================================================
// CHAT SCREEN
// ============================================================

class ChatScreen extends StatefulWidget {
  final ChatUser user;

  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();

  final List<Message> messages = [
    Message(text: 'Hey! How are you today?', time: '9:17 PM', mine: false),
    Message(text: 'I\'m good, thanks! 😊', time: '9:18 PM', mine: true),
    Message(text: 'That\'s awesome!', time: '9:19 PM', mine: false),
    Message(text: 'Are you free this weekend?', time: '9:20 PM', mine: true),
    Message(text: 'Yes! Let\'s plan something.', time: '9:22 PM', mine: false),
    Message(text: 'How about a coffee? ☕', time: '9:23 PM', mine: true),
    Message(text: 'Sounds perfect! 👌', time: '9:24 PM', mine: false),
  ];

  void sendMessage() {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add(Message(text: text, time: 'Now', mine: true));
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            UserAvatar(
              letter: widget.user.avatar,
              online: widget.user.online,
              size: 42,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF22232A),
                  ),
                ),
                Text(
                  widget.user.online ? 'Online' : 'Last seen recently',
                  style: TextStyle(
                    fontSize: 11,
                    color: widget.user.online
                        ? const Color(0xFF27C281)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call_outlined)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(18, 24, 18, 20),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];

                return MessageBubble(message: message);
              },
            ),
          ),

          MessageComposer(controller: controller, onSend: sendMessage),
        ],
      ),
    );
  }
}

// ============================================================
// MESSAGE MODEL
// ============================================================

class Message {
  final String text;
  final String time;
  final bool mine;

  const Message({required this.text, required this.time, required this.mine});
}

// ============================================================
// MESSAGE BUBBLE
// ============================================================

class MessageBubble extends StatelessWidget {
  final Message message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 320),
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        decoration: BoxDecoration(
          gradient: message.mine
              ? LinearGradient(colors: [Color(0xFF625BFF), Color(0xFF765CF6)])
              : null,
          color: message.mine ? null : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(message.mine ? 18 : 4),
            bottomRight: Radius.circular(message.mine ? 4 : 18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.mine ? Colors.white : Color(0xFF30313A),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.time,
                  style: TextStyle(
                    color: message.mine ? Colors.white70 : Colors.grey,
                    fontSize: 9,
                  ),
                ),
                if (message.mine) ...[
                  SizedBox(width: 4),
                  Icon(Icons.done_all_rounded, size: 13, color: Colors.white70),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// MESSAGE COMPOSER
// ============================================================

class MessageComposer extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const MessageComposer({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE9EAF1))),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_circle_outline_rounded,
                color: Color(0xFF625BFF),
              ),
            ),

            Expanded(
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  hintText: 'Write a message...',
                  filled: true,
                  fillColor: const Color(0xFFF1F2F7),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 13,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Icon(
                    Icons.sentiment_satisfied_alt_outlined,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            Material(
              color: const Color(0xFF625BFF),
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onSend,
                child: const SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 21,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CONTACTS
// ============================================================

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(22, 25, 22, 18),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Contacts',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                  ),
                ),
                Icon(Icons.person_add_alt_1_rounded, color: Color(0xFF625BFF)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: const Color(0xFFEEF0F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  leading: UserAvatar(
                    letter: user.avatar,
                    online: user.online,
                    size: 50,
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(user.online ? 'Online' : 'Last seen recently'),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(user: user),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: Color(0xFF625BFF),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// GROUPS
// ============================================================

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = [
      ('Design Team', 'D', '12 members'),
      ('Flutter Developers', 'F', '28 members'),
      ('Family Circle', 'F', '8 members'),
      ('Project Alpha', 'P', '16 members'),
    ];

    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(22, 25, 22, 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Groups',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                  ),
                ),
                Icon(Icons.group_add_outlined, color: Color(0xFF625BFF)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    leading: CircleAvatar(
                      radius: 27,
                      backgroundColor: const Color(0xFFE8E7FF),
                      child: Text(
                        group.$1.substring(0, 1),
                        style: const TextStyle(
                          color: Color(0xFF625BFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      group.$1,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(group.$3),
                    trailing: const Icon(Icons.chevron_right_rounded),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE
// ============================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF625BFF), Color(0xFF9B51E0)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF625BFF).withValues(alpha: .25),
                    blurRadius: 25,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(4),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'M',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF625BFF),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Malik Ahmed',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 5),

            const Text(
              'malik@nexachat.app',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            _setting(Icons.edit_outlined, 'Edit Profile'),
            _setting(Icons.notifications_none_rounded, 'Notifications'),
            _setting(Icons.lock_outline_rounded, 'Privacy & Security'),
            _setting(Icons.chat_outlined, 'Chats & Media'),
            _setting(Icons.help_outline_rounded, 'Help & Support'),
            _setting(Icons.info_outline_rounded, 'About NexaChat'),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4F70),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _setting(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF625BFF)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}

// ============================================================
// MOBILE NAVIGATION
// ============================================================

class MobileBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const MobileBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onChanged,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xFFE9E7FF),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.chat_bubble_outline_rounded),
          selectedIcon: Icon(Icons.chat_bubble_rounded),
          label: 'Chats',
        ),
        NavigationDestination(
          icon: Icon(Icons.people_outline_rounded),
          selectedIcon: Icon(Icons.people_rounded),
          label: 'Contacts',
        ),
        NavigationDestination(
          icon: Icon(Icons.groups_outlined),
          selectedIcon: Icon(Icons.groups_rounded),
          label: 'Groups',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    );
  }
}

class NexasChatApp extends StatelessWidget {
  const NexasChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NexaChat',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B5FEF),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
      ),
      home: const ChatHomeScreen(),
    );
  }
}

// ============================================================
// MODELS
// ============================================================

class ChatsUser {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final bool online;
  final int unread;

  const ChatsUser({
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    this.online = false,
    this.unread = 0,
  });
}

const userser = [
  ChatUser(
    name: 'Sarah Khan',
    message: 'Hey! How are you today?',
    time: '9:24 PM',
    avatar: 'S',
    online: true,
    unread: 2,
  ),
  ChatUser(
    name: 'Alex Johnson',
    message: 'Let\'s catch up tomorrow.',
    time: '8:15 PM',
    avatar: 'A',
    online: true,
    unread: 1,
  ),
  ChatUser(
    name: 'Emma Wilson',
    message: 'That sounds great! 😊',
    time: '7:42 PM',
    avatar: 'E',
    online: true,
  ),
  ChatUser(
    name: 'David Lee',
    message: 'See you soon.',
    time: '6:20 PM',
    avatar: 'D',
    online: false,
  ),
  ChatUser(
    name: 'Ayesha Malik',
    message: 'Okay, see you soon!',
    time: '3:45 PM',
    avatar: 'A',
    online: true,
  ),
  ChatUser(
    name: 'Raza Ahmed',
    message: 'I have updated the docs.',
    time: '2:30 PM',
    avatar: 'R',
    online: false,
  ),
  ChatUser(
    name: 'Hina Sheikh',
    message: 'Thanks for your help.',
    time: '1:10 PM',
    avatar: 'H',
    online: false,
  ),
];

// ============================================================
// HOME
// ============================================================

class ChatHomeScreens extends StatefulWidget {
  const ChatHomeScreens({super.key});

  @override
  State<ChatHomeScreens> createState() => _ChatHomeScreensState();
}

class _ChatHomeScreensState extends State<ChatHomeScreens> {
  int selectedIndex = 0;

  final pages = const [
    ChatsPage(),
    ContactsPage(),
    GroupsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final desktop = constraints.maxWidth >= 1000;

        if (desktop) {
          return Scaffold(
            body: Row(
              children: [
                DesktopSidebar(
                  selectedIndex: selectedIndex,
                  onChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
                Expanded(child: pages[selectedIndex]),
              ],
            ),
          );
        }

        return Scaffold(
          body: pages[selectedIndex],
          bottomNavigationBar: MobileBottomNavigation(
            selectedIndex: selectedIndex,
            onChanged: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}

// ============================================================
// DESKTOP SIDEBAR
// ============================================================

class DesktopSidebars extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const DesktopSidebars({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: Color(0xFFE7E8F0))),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 28),

            // Logo
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF625BFF), Color(0xFF8C52FF)],
                      ),
                    ),
                    child: const Icon(Icons.forum_rounded, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'NexaChat',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 45),

            _item(
              icon: Icons.chat_bubble_outline_rounded,
              activeIcon: Icons.chat_bubble_rounded,
              title: 'Chats',
              index: 0,
            ),

            _item(
              icon: Icons.people_outline_rounded,
              activeIcon: Icons.people_rounded,
              title: 'Contacts',
              index: 1,
            ),

            _item(
              icon: Icons.groups_outlined,
              activeIcon: Icons.groups_rounded,
              title: 'Groups',
              index: 2,
            ),

            _item(
              icon: Icons.person_outline_rounded,
              activeIcon: Icons.person_rounded,
              title: 'Profile',
              index: 3,
            ),

            const Spacer(),

            Container(
              margin: const EdgeInsets.all(18),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: const Color(0xFFF5F4FF),
              ),
              child: const Column(
                children: [
                  Icon(Icons.lock_outline_rounded, color: Color(0xFF625BFF)),
                  SizedBox(height: 8),
                  Text(
                    'Your chats are private',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Secure conversations made simple.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item({
    required IconData icon,
    required IconData activeIcon,
    required String title,
    required int index,
  }) {
    final active = selectedIndex == index;

    return InkWell(
      onTap: () => onChanged(index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: active ? const Color(0xFFF0EFFF) : Colors.transparent,
        ),
        child: Row(
          children: [
            Icon(
              active ? activeIcon : icon,
              color: active ? const Color(0xFF625BFF) : const Color(0xFF777A87),
            ),
            const SizedBox(width: 14),
            Text(
              title,
              style: TextStyle(
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                color: active
                    ? const Color(0xFF625BFF)
                    : const Color(0xFF5D606D),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CHAT PAGE
// ============================================================

class ChatingPage extends StatefulWidget {
  const ChatingPage({super.key});

  @override
  State<ChatingPage> createState() => _ChatingPageState();
}

class _ChatingPageState extends State<ChatingPage> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    final filtered = users
        .where((user) => user.name.toLowerCase().contains(search.toLowerCase()))
        .toList();

    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search conversations...',
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: const Color(0xFFEEF0F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          _stories(),

          const SizedBox(height: 12),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final user = filtered[index];

                return ChatTile(
                  user: user,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ChatScreen(user: user)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 18),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Messages',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 4),
                Text(
                  'Stay connected with your people',
                  style: TextStyle(color: Color(0xFF858895)),
                ),
              ],
            ),
          ),
          _roundButton(Icons.edit_rounded, () {}),
        ],
      ),
    );
  }

  Widget _roundButton(IconData icon, VoidCallback onTap) {
    return Material(
      color: const Color(0xFF625BFF),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: const SizedBox(
          width: 46,
          height: 46,
          child: Icon(Icons.edit_rounded, color: Colors.white),
        ),
      ),
    );
  }

  Widget _stories() {
    return SizedBox(
      height: 92,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        children: [
          const StoryAvatar(name: 'My Story', avatar: '+', isAdd: true),
          ...users
              .take(5)
              .map(
                (user) => StoryAvatar(
                  name: user.name.split(' ').first,
                  avatar: user.avatar,
                  online: user.online,
                ),
              ),
        ],
      ),
    );
  }
}

// ============================================================
// CHAT TILE
// ============================================================

class ChatsTile extends StatelessWidget {
  final ChatUser user;
  final VoidCallback onTap;

  const ChatsTile({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 6),
          child: Row(
            children: [
              UserAvatar(letter: user.avatar, online: user.online, size: 56),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF858895),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    user.time,
                    style: const TextStyle(
                      color: Color(0xFF9699A5),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 7),

                  if (user.unread > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF625BFF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${user.unread}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// STORY AVATAR
// ============================================================

class StorysAvatar extends StatelessWidget {
  final String name;
  final String avatar;
  final bool online;
  final bool isAdd;

  const StorysAvatar({
    super.key,
    required this.name,
    required this.avatar,
    this.online = false,
    this.isAdd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 58,
                height: 58,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: isAdd
                        ? [const Color(0xFF625BFF), const Color(0xFF8C52FF)]
                        : [const Color(0xFF625BFF), const Color(0xFFEF5DA8)],
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(3),
                  child: CircleAvatar(
                    backgroundColor: const Color(0xFFE9E9F8),
                    child: Text(
                      avatar,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF625BFF),
                      ),
                    ),
                  ),
                ),
              ),

              if (online)
                Positioned(
                  right: 1,
                  bottom: 3,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF27C281),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// USER AVATAR
// ============================================================

class UserAvatars extends StatelessWidget {
  final String letter;
  final bool online;
  final double size;

  const UserAvatars({
    super.key,
    required this.letter,
    this.online = false,
    this.size = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: size / 2,
          backgroundColor: const Color(0xFFE4E5F7),
          child: Text(
            letter,
            style: TextStyle(
              fontSize: size * .34,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF625BFF),
            ),
          ),
        ),
        if (online)
          Positioned(
            right: 1,
            bottom: 1,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFF25C281),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}

// ============================================================
// CHAT SCREEN
// ============================================================

class ChatsScreens extends StatefulWidget {
  final ChatUser user;

  const ChatsScreens({super.key, required this.user});

  @override
  State<ChatsScreens> createState() => _ChatsScreensState();
}

class _ChatsScreensState extends State<ChatsScreens> {
  final TextEditingController controller = TextEditingController();

  final List<Message> messages = [
    Message(text: 'Hey! How are you today?', time: '9:17 PM', mine: false),
    Message(text: 'I\'m good, thanks! 😊', time: '9:18 PM', mine: true),
    Message(text: 'That\'s awesome!', time: '9:19 PM', mine: false),
    Message(text: 'Are you free this weekend?', time: '9:20 PM', mine: true),
    Message(text: 'Yes! Let\'s plan something.', time: '9:22 PM', mine: false),
    Message(text: 'How about a coffee? ☕', time: '9:23 PM', mine: true),
    Message(text: 'Sounds perfect! 👌', time: '9:24 PM', mine: false),
  ];

  void sendMessage() {
    final text = controller.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add(Message(text: text, time: 'Now', mine: true));
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            UserAvatar(
              letter: widget.user.avatar,
              online: widget.user.online,
              size: 42,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF22232A),
                  ),
                ),
                Text(
                  widget.user.online ? 'Online' : 'Last seen recently',
                  style: TextStyle(
                    fontSize: 11,
                    color: widget.user.online
                        ? const Color(0xFF27C281)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.call_outlined)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(18, 24, 18, 20),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];

                return MessageBubble(message: message);
              },
            ),
          ),

          MessageComposer(controller: controller, onSend: sendMessage),
        ],
      ),
    );
  }
}

// ============================================================
// MESSAGE MODEL
// ============================================================

class Messages {
  final String text;
  final String time;
  final bool mine;

  const Messages({required this.text, required this.time, required this.mine});
}

// ============================================================
// MESSAGE BUBBLE
// ============================================================

class MessagesBubble extends StatelessWidget {
  final Message message;

  const MessagesBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: 320),
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        decoration: BoxDecoration(
          gradient: message.mine
              ? LinearGradient(colors: [Color(0xFF625BFF), Color(0xFF765CF6)])
              : null,
          color: message.mine ? null : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(message.mine ? 18 : 4),
            bottomRight: Radius.circular(message.mine ? 4 : 18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.mine ? Colors.white : Color(0xFF30313A),
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.time,
                  style: TextStyle(
                    color: message.mine ? Colors.white70 : Colors.grey,
                    fontSize: 9,
                  ),
                ),
                if (message.mine) ...[
                  SizedBox(width: 4),
                  Icon(Icons.done_all_rounded, size: 13, color: Colors.white70),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// MESSAGE COMPOSER
// ============================================================

class MessagesComposer extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const MessagesComposer({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Color(0xFFE9EAF1))),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add_circle_outline_rounded,
                color: Color(0xFF625BFF),
              ),
            ),

            Expanded(
              child: TextField(
                controller: controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  hintText: 'Write a message...',
                  filled: true,
                  fillColor: const Color(0xFFF1F2F7),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 13,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Icon(
                    Icons.sentiment_satisfied_alt_outlined,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),

            Material(
              color: const Color(0xFF625BFF),
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onSend,
                child: const SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 21,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CONTACTS
// ============================================================

class ContactingPage extends StatelessWidget {
  const ContactingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(22, 25, 22, 18),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Contacts',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                  ),
                ),
                Icon(Icons.person_add_alt_1_rounded, color: Color(0xFF625BFF)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                prefixIcon: const Icon(Icons.search_rounded),
                filled: true,
                fillColor: const Color(0xFFEEF0F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 15),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  leading: UserAvatar(
                    letter: user.avatar,
                    online: user.online,
                    size: 50,
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(user.online ? 'Online' : 'Last seen recently'),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatScreen(user: user),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.chat_bubble_outline_rounded,
                      color: Color(0xFF625BFF),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// GROUPS
// ============================================================

class GroupingPage extends StatelessWidget {
  const GroupingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = [
      ('Design Team', 'D', '12 members'),
      ('Flutter Developers', 'F', '28 members'),
      ('Family Circle', 'F', '8 members'),
      ('Project Alpha', 'P', '16 members'),
    ];

    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(22, 25, 22, 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Groups',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                  ),
                ),
                Icon(Icons.group_add_outlined, color: Color(0xFF625BFF)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              itemCount: groups.length,
              itemBuilder: (context, index) {
                final group = groups[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    leading: CircleAvatar(
                      radius: 27,
                      backgroundColor: const Color(0xFFE8E7FF),
                      child: Text(
                        group.$1.substring(0, 1),
                        style: const TextStyle(
                          color: Color(0xFF625BFF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      group.$1,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(group.$3),
                    trailing: const Icon(Icons.chevron_right_rounded),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROFILE
// ============================================================

class ProfilingPage extends StatelessWidget {
  const ProfilingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            const SizedBox(height: 20),

            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF625BFF), Color(0xFF9B51E0)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF625BFF).withValues(alpha: .25),
                    blurRadius: 25,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(4),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  'M',
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF625BFF),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Malik Ahmed',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
            ),

            const SizedBox(height: 5),

            const Text(
              'malik@nexachat.app',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            _setting(Icons.edit_outlined, 'Edit Profile'),
            _setting(Icons.notifications_none_rounded, 'Notifications'),
            _setting(Icons.lock_outline_rounded, 'Privacy & Security'),
            _setting(Icons.chat_outlined, 'Chats & Media'),
            _setting(Icons.help_outline_rounded, 'Help & Support'),
            _setting(Icons.info_outline_rounded, 'About NexaChat'),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4F70),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Log Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _setting(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF625BFF)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}

// ============================================================
// MOBILE NAVIGATION
// ============================================================

class MobileBottomNavigations extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const MobileBottomNavigations({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onChanged,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xFFE9E7FF),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.chat_bubble_outline_rounded),
          selectedIcon: Icon(Icons.chat_bubble_rounded),
          label: 'Chats',
        ),
        NavigationDestination(
          icon: Icon(Icons.people_outline_rounded),
          selectedIcon: Icon(Icons.people_rounded),
          label: 'Contacts',
        ),
        NavigationDestination(
          icon: Icon(Icons.groups_outlined),
          selectedIcon: Icon(Icons.groups_rounded),
          label: 'Groups',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
    );
  }
}
