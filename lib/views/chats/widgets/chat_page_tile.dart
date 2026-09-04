import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';
import 'package:whatsapp_clone_py/views/chats/model/chats_contact_models.dart';

class ChatContactItem extends StatelessWidget {
  final ChatContactModels chat;
  final VoidCallback? onTap;

  const ChatContactItem({super.key, required this.chat, this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final double horizontalPadding = width < 400 ? 10 : 12;
    final double avatarSize = width < 400 ? 54 : 58;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
          left: horizontalPadding,
          right: horizontalPadding,
          top: 8,
          bottom: 8,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ------------------------------------------------
                // AVATAR
                // ------------------------------------------------
                _buildAvatar(avatarSize),

                const SizedBox(width: 14),

                // ------------------------------------------------
                // NAME + LAST MESSAGE
                // ------------------------------------------------
                Expanded(
                  child: SizedBox(
                    height: avatarSize,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          chat.username,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff111111),
                          ),
                        ),

                        const SizedBox(height: 5),

                        _buildLastMessage(),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // ------------------------------------------------
                // TIME + UNREAD COUNT
                // ------------------------------------------------
                SizedBox(
                  width: 68,
                  height: avatarSize,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        chat.time,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: chat.unreadCount > 0
                              ? FontWeight.w500
                              : FontWeight.w400,
                          color: chat.unreadCount > 0
                              ? const Color(0xff00b050)
                              : const Color(0xff555555),
                        ),
                      ),

                      const Spacer(),

                      if (chat.unreadCount > 0) _buildUnreadBadge(),
                    ],
                  ),
                ),
              ],
            ),

            // ------------------------------------------------
            // DIVIDER
            // ------------------------------------------------
            Padding(
              padding: EdgeInsets.only(left: avatarSize + 14, top: 8),
              child: Container(height: 1, color: const Color(0xffe5e5e5)),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // AVATAR
  // ==========================================================

  Widget _buildAvatar(double size) {
    return Stack(
      children: [
        ClipOval(
          child: Image.network(
            chat.userimageUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: size,
                height: size,
                color: const Color(0xffeeeeee),
                alignment: Alignment.center,
                child: Icon(
                  Icons.person,
                  size: size * .55,
                  color: const Color(0xff999999),
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: chat.isOnline ? _buildOnlineIndicator(size) : const SizedBox(),
        ),
      ],
    );
  }

  // ==========================================================
  // LAST MESSAGE
  // ==========================================================

  Widget _buildLastMessage() {
    if (chat.messageType == MessageType.image) {
      return Row(
        children: [
          const Icon(Icons.camera_alt, size: 17, color: Color(0xff777777)),

          const SizedBox(width: 5),

          Text(
            chat.lastMessage,
            style: const TextStyle(fontSize: 15, color: Color(0xff666666)),
          ),
        ],
      );
    }

    if (chat.messageType == MessageType.voice) {
      return Row(
        children: [
          Icon(Icons.done_all, size: 17, color: Color(0xff00aaff)),

          SizedBox(width: 4),

          Icon(Icons.mic, size: 17, color: Color(0xff777777)),

          SizedBox(width: 4),

          Text(
            chat.lastMessage,
            style: const TextStyle(fontSize: 15, color: Color(0xff666666)),
          ),
        ],
      );
    }

    if (chat.messageType == MessageType.emoji) {
      return Text(
        chat.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 18),
      );
    }

    return Text(
      chat.lastMessage,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(fontSize: 15, color: Color(0xff555555)),
    );
  }

  // ==========================================================
  // UNREAD BADGE
  // ==========================================================

  Widget _buildUnreadBadge() {
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color(0xff00c853),
        shape: BoxShape.circle,
      ),
      child: Text(
        '${chat.unreadCount}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOnlineIndicator(double size) {
    return Container(
      width: size * 0.2,
      height: size * 0.2,

      decoration: const BoxDecoration(
        color: AppColors.greenColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
