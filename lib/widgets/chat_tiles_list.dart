import 'package:flutter/material.dart';

import 'package:whatsapp_clone_py/model/chats_contact_models.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';
import 'package:whatsapp_clone_py/views/homepage/widgets/home_nave_enums.dart';

class ChatTileList extends StatelessWidget {
  final bool isSearch;
  final TextEditingController searchController;
  final HomeSection selectedSection;

  const ChatTileList({
    super.key,
    required this.isSearch,
    required this.searchController,
    required this.selectedSection,
  });

  @override
  Widget build(BuildContext context) {
    switch (selectedSection) {
      case HomeSection.chats:
        return _buildChatList(context);

      case HomeSection.calls:
        return _buildCallList(context);

      case HomeSection.updates:
        return const SizedBox.shrink();

      case HomeSection.settings:
        return const SizedBox.shrink();
    }
  }

  // ============================================================
  // CHAT LIST
  // ============================================================

  Widget _buildChatList(BuildContext context) {
    final String searchText = searchController.text.trim().toLowerCase();

    final chatContacts = contacts.where((chat) {
      final bool isChat =
          chat.homeTile == HomeTile.chat || chat.homeTile == HomeTile.group;

      if (!isChat) {
        return false;
      }

      if (!isSearch || searchText.isEmpty) {
        return true;
      }

      return chat.username.toLowerCase().contains(searchText) ||
          chat.lastMessage.toLowerCase().contains(searchText);
    }).toList();

    if (chatContacts.isEmpty) {
      return const Center(
        child: Text(
          'No chats found',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: chatContacts.length,
      itemBuilder: (context, index) {
        final ChatContactModels chat = chatContacts[index];

        return _buildChatTile(context, chat);
      },
    );
  }

  // ============================================================
  // CHAT TILE
  // ============================================================

  Widget _buildChatTile(BuildContext context, ChatContactModels chat) {
    final bool isGroup = chat.homeTile == HomeTile.group;

    return InkWell(
      onTap: () {
        debugPrint('Open chat: ${chat.username}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            _buildAvatar(chat, isGroup),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat.username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(
                        chat.time,
                        style: TextStyle(
                          fontSize: 12,
                          color: chat.unreadCount > 0
                              ? AppColors.greenColor
                              : Colors.grey,
                          fontWeight: chat.unreadCount > 0
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Expanded(child: _buildMessagePreview(chat)),

                      if (chat.unreadCount > 0)
                        _buildUnreadBadge(chat.unreadCount),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // AVATAR
  // ============================================================

  Widget _buildAvatar(ChatContactModels chat, bool isGroup) {
    if (isGroup &&
        chat.participantsImages != null &&
        chat.participantsImages!.isNotEmpty) {
      return _buildGroupAvatar(chat.participantsImages!);
    }

    return Stack(
      children: [
        ClipOval(
          child: Image.network(
            chat.userimageUrl,
            width: 58,
            height: 58,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 58,
                height: 58,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffeeeeee),
                ),
                child: const Icon(Icons.person, color: Colors.grey, size: 30),
              );
            },
          ),
        ),

        if (chat.isOnline)
          Positioned(
            right: 1,
            bottom: 1,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: AppColors.greenColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  // ============================================================
  // GROUP AVATAR
  // ============================================================

  Widget _buildGroupAvatar(List<String> images) {
    final List<String> groupImages = images.take(3).toList();

    if (groupImages.length == 1) {
      return _groupImage(groupImages[0], 58);
    }

    return SizedBox(
      width: 58,
      height: 58,
      child: Stack(
        children: [
          if (groupImages.isNotEmpty)
            Positioned(
              left: 0,
              bottom: 0,
              child: _groupImage(groupImages[0], 35),
            ),

          if (groupImages.length > 1)
            Positioned(
              right: 0,
              bottom: 0,
              child: _groupImage(groupImages[1], 35),
            ),

          if (groupImages.length > 2)
            Positioned(
              top: 0,
              left: 11,
              child: _groupImage(groupImages[2], 35),
            ),
        ],
      ),
    );
  }

  Widget _groupImage(String imageUrl, double size) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: size,
              height: size,
              color: const Color(0xffeeeeee),
              child: Icon(Icons.person, size: size * .5, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // MESSAGE PREVIEW
  // ============================================================

  Widget _buildMessagePreview(ChatContactModels chat) {
    IconData? icon;

    switch (chat.messageType) {
      case MessageType.text:
        icon = null;
        break;

      case MessageType.image:
        icon = Icons.image_outlined;
        break;

      case MessageType.video:
        icon = Icons.videocam_outlined;
        break;

      case MessageType.voice:
        icon = Icons.mic_none_outlined;
        break;

      case MessageType.emoji:
        icon = Icons.emoji_emotions_outlined;
        break;
    }

    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 17, color: Colors.grey.shade600),
          const SizedBox(width: 4),
        ],

        Expanded(
          child: Text(
            chat.lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              color: chat.unreadCount > 0
                  ? const Color(0xff333333)
                  : const Color(0xff777777),
              fontWeight: chat.unreadCount > 0
                  ? FontWeight.w500
                  : FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // UNREAD BADGE
  // ============================================================

  Widget _buildUnreadBadge(int count) {
    return Container(
      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.greenColor,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        count > 99 ? '99+' : count.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  // ============================================================
  // CALL LIST
  // ============================================================

  Widget _buildCallList(BuildContext context) {
    final callContacts = contacts.where((chat) {
      return chat.homeTile == HomeTile.call;
    }).toList();

    if (callContacts.isEmpty) {
      return const Center(
        child: Text(
          'No call history',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: callContacts.length,
      itemBuilder: (context, index) {
        final ChatContactModels call = callContacts[index];

        return _buildCallTile(context, call);
      },
    );
  }

  // ============================================================
  // CALL TILE
  // ============================================================

  Widget _buildCallTile(BuildContext context, ChatContactModels call) {
    final bool isVideo = call.callType == CallType.video;

    final bool isMissed = call.callStatus == CallStatus.missed;

    return InkWell(
      onTap: () {
        debugPrint('Open call history: ${call.username}');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                call.userimageUrl,
                width: 58,
                height: 58,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 58,
                    height: 58,
                    color: const Color(0xffeeeeee),
                    child: const Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 30,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    call.username,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Icon(
                        isVideo ? Icons.videocam_outlined : Icons.call_outlined,
                        size: 17,
                        color: isMissed ? Colors.red : AppColors.greenColor,
                      ),

                      const SizedBox(width: 5),

                      Expanded(
                        child: Text(
                          _callSubtitle(call),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: isMissed ? Colors.red : Colors.grey,
                          ),
                        ),
                      ),

                      if (call.numberOfCalls != null && call.numberOfCalls! > 1)
                        Text(
                          '(${call.numberOfCalls})',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            Text(
              call.time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CALL SUBTITLE
  // ============================================================

  String _callSubtitle(ChatContactModels call) {
    final bool isVideo = call.callType == CallType.video;

    switch (call.callStatus) {
      case CallStatus.missed:
        return isVideo ? 'Missed video call' : 'Missed call';

      case CallStatus.declined:
        return isVideo ? 'Declined video call' : 'Declined call';

      case CallStatus.accepted:
        return isVideo ? 'Incoming video call' : 'Incoming call';

      case null:
        return isVideo ? 'Video call' : 'Call';
    }
  }
}
