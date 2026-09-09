import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    this.contactName = 'Ahmed',
    this.phoneNumber = '+92 300 1234567',
  });

  final String contactName;
  final String phoneNumber;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    ChatMessage(text: 'Hi! How are you?', time: '10:21 AM', isMe: false),
    ChatMessage(
      text: 'I am fine! How about you?',
      time: '10:22 AM',
      isMe: true,
      isRead: true,
    ),
    ChatMessage(text: 'I am doing great 😊', time: '10:23 AM', isMe: false),
    ChatMessage(text: 'Are you free today?', time: '10:24 AM', isMe: false),
    ChatMessage(
      text: 'Yes, I am free after 5 PM.',
      time: '10:25 AM',
      isMe: true,
      isRead: true,
    ),
    ChatMessage(
      text: " Perfect! Let's meet then 👍",
      time: "10:26 AM",
      isMe: false,
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(text: text, time: _currentTime(), isMe: true, isRead: true),
      );
    });

    _messageController.clear();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _currentTime() {
    final now = TimeOfDay.now();

    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  void _showMoreMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MenuItem(
                icon: Icons.search,
                title: 'Search',
                onTap: () => Navigator.pop(context),
              ),
              _MenuItem(
                icon: Icons.photo_library_outlined,
                title: 'Media, links and docs',
                onTap: () => Navigator.pop(context),
              ),
              _MenuItem(
                icon: Icons.notifications_off_outlined,
                title: 'Mute notifications',
                onTap: () => Navigator.pop(context),
              ),
              _MenuItem(
                icon: Icons.wallpaper_outlined,
                title: 'Wallpaper',
                onTap: () => Navigator.pop(context),
              ),
              _MenuItem(
                icon: Icons.more_horiz,
                title: 'More',
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _showAttachmentMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 25),
            child: Wrap(
              spacing: 25,
              runSpacing: 20,
              children: [
                _AttachmentItem(
                  icon: Icons.insert_drive_file,
                  label: 'Document',
                  onTap: () => Navigator.pop(context),
                ),
                _AttachmentItem(
                  icon: Icons.photo,
                  label: 'Gallery',
                  onTap: () => Navigator.pop(context),
                ),
                _AttachmentItem(
                  icon: Icons.camera_alt,
                  label: 'Camera',
                  onTap: () => Navigator.pop(context),
                ),
                _AttachmentItem(
                  icon: Icons.headphones,
                  label: 'Audio',
                  onTap: () => Navigator.pop(context),
                ),
                _AttachmentItem(
                  icon: Icons.location_on,
                  label: 'Location',
                  onTap: () => Navigator.pop(context),
                ),
                _AttachmentItem(
                  icon: Icons.person,
                  label: 'Contact',
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      // ------------------------------------------------------------
      // APP BAR
      // ------------------------------------------------------------
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF075E54),
        foregroundColor: Colors.white,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 21,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.contactName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'online',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam_outlined),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.call_outlined)),
          IconButton(
            onPressed: _showMoreMenu,
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),

      // ------------------------------------------------------------
      // CHAT BODY
      // ------------------------------------------------------------
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFEFE7DE),
          image: DecorationImage(
            image: NetworkImage(
              'https://www.transparenttextures.com/patterns/cubes.png',
            ),
            repeat: ImageRepeat.repeat,
            opacity: 0.15,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                itemCount: _messages.length + 1,
                itemBuilder: (context, index) {
                  // Date separator
                  if (index == 0) {
                    return const _DateSeparator(text: 'TODAY');
                  }

                  final message = _messages[index - 1];

                  return MessageBubble(message: message);
                },
              ),
            ),

            // ------------------------------------------------------
            // MESSAGE INPUT
            // ------------------------------------------------------
            _MessageInput(
              controller: _messageController,
              onSend: _sendMessage,
              onAttachment: _showAttachmentMenu,
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// MESSAGE MODEL
// ================================================================

class ChatMessage {
  final String text;
  final String time;
  final bool isMe;
  final bool isRead;

  ChatMessage({
    required this.text,
    required this.time,
    required this.isMe,
    this.isRead = false,
  });
}

// ================================================================
// MESSAGE BUBBLE
// ================================================================

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.fromLTRB(10, 7, 8, 6),
        decoration: BoxDecoration(
          color: message.isMe ? const Color(0xFFD9FDD3) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8),
            topRight: const Radius.circular(8),
            bottomLeft: Radius.circular(message.isMe ? 8 : 2),
            bottomRight: Radius.circular(message.isMe ? 2 : 8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                message.text,
                style: const TextStyle(
                  fontSize: 15.5,
                  height: 1.3,
                  color: Color(0xFF111111),
                ),
              ),
            ),

            const SizedBox(width: 7),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.time,
                  style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600),
                ),

                if (message.isMe) ...[
                  const SizedBox(width: 3),
                  Icon(
                    Icons.done_all,
                    size: 16,
                    color: message.isRead
                        ? const Color(0xFF53BDEB)
                        : Colors.grey,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// DATE SEPARATOR
// ================================================================

class _DateSeparator extends StatelessWidget {
  const _DateSeparator({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFE1F3FB),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 2,
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF546E7A),
          ),
        ),
      ),
    );
  }
}

// ================================================================
// MESSAGE INPUT
// ================================================================

class _MessageInput extends StatefulWidget {
  const _MessageInput({
    required this.controller,
    required this.onSend,
    required this.onAttachment,
  });

  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onAttachment;

  @override
  State<_MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<_MessageInput> {
  bool hasText = false;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_textChanged);
  }

  void _textChanged() {
    final value = widget.controller.text.trim().isNotEmpty;

    if (value != hasText) {
      setState(() {
        hasText = value;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_textChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(7, 7, 7, 7),
        color: const Color(0xFFF0F2F5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // ----------------------------------------------------
            // TEXT FIELD
            // ----------------------------------------------------
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.emoji_emotions_outlined,
                        color: Color(0xFF54656F),
                      ),
                    ),

                    Expanded(
                      child: TextField(
                        controller: widget.controller,
                        minLines: 1,
                        maxLines: 5,
                        textInputAction: TextInputAction.newline,
                        decoration: const InputDecoration(
                          hintText: 'Type a message',
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: widget.onAttachment,
                      icon: const Icon(
                        Icons.attach_file,
                        color: Color(0xFF54656F),
                      ),
                    ),

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: Color(0xFF54656F),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 6),

            // ----------------------------------------------------
            // SEND / MICROPHONE BUTTON
            // ----------------------------------------------------
            GestureDetector(
              onTap: hasText
                  ? widget.onSend
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Hold to record a voice message'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
              child: Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFF00A884),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  hasText ? Icons.send : Icons.mic,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// MORE MENU ITEM
// ================================================================

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF54656F)),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }
}

// ================================================================
// ATTACHMENT ITEM
// ================================================================

class _AttachmentItem extends StatelessWidget {
  const _AttachmentItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 75,
        child: Column(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.insert_drive_file,
                color: Color(0xFF00A884),
              ),
            ),
            const SizedBox(height: 7),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
