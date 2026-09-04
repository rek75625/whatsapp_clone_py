// ============================================================
// MODEL
// ============================================================

class ChatContactModels {
  final String username;
  final String userimageUrl;
  final String lastMessage;
  final String time;
  final bool isOnline;
  final int unreadCount;
  final MessageType messageType;

  const ChatContactModels({
    required this.username,
    required this.userimageUrl,
    required this.lastMessage,
    required this.time,
    this.isOnline = false,
    this.unreadCount = 0,
    this.messageType = MessageType.text,
  });
}

enum MessageType { text, image, voice, emoji }

// ============================================================
// CHAT DATA
// ============================================================

const List<ChatContactModels> contacts = [
  ChatContactModels(
    username: 'Jordan Moran',
    userimageUrl:
        'https://images.unsplash.com/photo-1595956553066-fe24a8c33395',
    lastMessage: 'Bro, these are fire 🔥🔥',
    time: '16:32',
    isOnline: true,
    messageType: MessageType.emoji,
  ),
  ChatContactModels(
    username: 'James Arthur',
    userimageUrl:
        'https://images.unsplash.com/photo-1595956553066-fe24a8c33395',
    lastMessage: 'Hey! How are you?',
    time: '16:20',
    isOnline: true,
    unreadCount: 2,
    messageType: MessageType.text,
  ),
  ChatContactModels(
    username: 'Sarah Williams',
    userimageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
    lastMessage: 'See you tomorrow 😊',
    time: '15:48',
    isOnline: false,
  ),
  ChatContactModels(
    username: 'David Smith',
    userimageUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
    lastMessage: 'Okay 👍',
    time: '14:35',
    isOnline: true,
    unreadCount: 4,
    messageType: MessageType.voice,
  ),
  ChatContactModels(
    username: 'Emma Watson',
    userimageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb',
    lastMessage: 'Thank you ❤️',
    time: '13:22',
    isOnline: false,
  ),
  ChatContactModels(
    username: 'Michael Johnson',
    userimageUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
    lastMessage: 'Let me check.',
    time: '12:50',
    isOnline: true,
    messageType: MessageType.image,
  ),
  ChatContactModels(
    username: 'Olivia Brown',
    userimageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
    lastMessage: 'That sounds great!',
    time: '11:42',
    isOnline: false,
    unreadCount: 1,
  ),
];
