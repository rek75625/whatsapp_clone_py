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

  final int? numberOfCalls;
  final CallStatus? callStatus;
  final CallType? callType;

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

    this.numberOfCalls,
    this.callStatus,
    this.callType,
  });
}

enum MessageType { text, image, video, voice, emoji }

enum HomeTile { chat, group, call }

enum CallStatus { missed, declined, accepted }

enum CallType { audio, video }

// ============================================================
// CHAT DATA
// ============================================================

List<ChatContactModels> contacts = [
  ChatContactModels(
    username: 'Sarah Williams',
    userimageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
    lastMessage: 'Missed video call',
    time: '11:32',
    homeTile: HomeTile.call,
    numberOfCalls: 3,
    callStatus: CallStatus.missed,
    callType: CallType.video,
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
    username: 'Michael Johnson',
    userimageUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
    lastMessage: 'Missed call',
    time: '12:50',
    homeTile: HomeTile.call,
    numberOfCalls: 3,
    callStatus: CallStatus.missed,
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
    homeTile: HomeTile.chat,
    callStatus: CallStatus.accepted,
    numberOfCalls: 0,
  ),
  ChatContactModels(
    username: 'Emma Watson',
    userimageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb',
    lastMessage: 'Thank you ❤️',
    time: '13:22',
    isOnline: false,
    homeTile: HomeTile.chat,
    callStatus: CallStatus.accepted,
    numberOfCalls: 0,
  ),
  ChatContactModels(
    username: 'Michael Johnson',
    userimageUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d',
    lastMessage: 'Let me check.',
    time: '12:50',
    isOnline: true,
    messageType: MessageType.image,
    homeTile: HomeTile.chat,
    callStatus: CallStatus.accepted,
    numberOfCalls: 0,
  ),
  ChatContactModels(
    username: 'Olivia Brown',
    userimageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
    lastMessage: 'That sounds great!',
    time: '11:42',
    isOnline: false,
    unreadCount: 1,
    homeTile: HomeTile.chat,
    callStatus: CallStatus.accepted,
    numberOfCalls: 0,
  ),
];
