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
  final HomeTile homeTile;
  final MessageType messageType;
  final List<String>? participantsImages;

  const ChatContactModels({
    required this.username,
    required this.userimageUrl,
    required this.lastMessage,
    required this.time,
    this.isOnline = false,
    this.unreadCount = 0,
    this.messageType = MessageType.text,
    required this.homeTile,
    this.participantsImages,
  });
}

enum MessageType { text, image, voice, emoji }

enum HomeTile { message, group }

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
    homeTile: HomeTile.group,
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
    homeTile: HomeTile.group,
    participantsImages: [
      'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde',
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
    ],
  ),
  ChatContactModels(
    username: 'Sarah Williams',
    userimageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
    lastMessage: 'See you tomorrow 😊',
    time: '15:48',
    isOnline: false,
    homeTile: HomeTile.group,
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
    homeTile: HomeTile.message,
  ),
  ChatContactModels(
    username: 'Emma Watson',
    userimageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb',
    lastMessage: 'Thank you ❤️',
    time: '13:22',
    isOnline: false,
    homeTile: HomeTile.message,
  ),
  ChatContactModels(
    username: 'Michael Johnson',
    userimageUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
    lastMessage: 'Let me check.',
    time: '12:50',
    isOnline: true,
    messageType: MessageType.image,
    homeTile: HomeTile.message,
  ),
  ChatContactModels(
    username: 'Olivia Brown',
    userimageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
    lastMessage: 'That sounds great!',
    time: '11:42',
    isOnline: false,
    unreadCount: 1,
    homeTile: HomeTile.message,
  ),
];
