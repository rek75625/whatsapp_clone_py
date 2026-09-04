import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';
import 'package:whatsapp_clone_py/views/chats/model/chats_contact_models.dart';

class ChatContactItem extends StatelessWidget {
  final int index;
  final ChatContactModels chat;
  final VoidCallback? onTap;

  const ChatContactItem({
    super.key,
    required this.chat,
    this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final bool isGroup = chat.homeTile == HomeTile.group;

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
                if (isGroup)
                  _buildGroupAvatar(avatarSize)
                else
                  _buildUserAvatar(avatarSize),

                AppSizes.width16,

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
  // User AVATAR
  // ==========================================================

  Widget _buildUserAvatar(double size) {
    if (chat.homeTile == HomeTile.message) {
      return Stack(
        clipBehavior: Clip.none,
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffeeeeee),
                  ),
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

          // Online indicator
          if (chat.isOnline)
            Positioned(
              bottom: 0,
              right: 0,
              child: _buildOnlineIndicatora(size),
            ),
        ],
      );
    }

    // ============================================================
    // GROUP
    // ============================================================

    return _buildGroupAvatar(size);
  }

  Widget _buildGroupAvatar(double size) {
    final images = chat.participantsImages ?? [];

    // Number of images we want to display
    final displayImages = images.take(2).toList();

    if (displayImages.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffeeeeee),
        ),
        alignment: Alignment.center,
        child: Icon(Icons.group, size: size * .50, color: Colors.grey),
      );
    }

    // ============================================================
    // TWO / THREE OVERLAPPING IMAGES
    // ============================================================

    final double smallSize = size * .62;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // --------------------------------------------------------
          // IMAGE 1
          // --------------------------------------------------------

          Positioned(
            left: 0,
            top: size * .19,
            child: _buildGroupImages(
              imageUrl: displayImages[0],
              size: smallSize,
            ),
          ),

          // --------------------------------------------------------
          // IMAGE 2
          // --------------------------------------------------------
          if (displayImages.length >= 2)
            Positioned(
              right: 0,
              top: 0,
              child: _buildGroupImages(
                imageUrl: displayImages[1],
                size: smallSize,
              ),
            ),

          // --------------------------------------------------------
          // IMAGE 3
          // --------------------------------------------------------
          if (displayImages.length >= 3)
            Positioned(
              right: 0,
              bottom: 0,
              child: _buildGroupImages(
                imageUrl: displayImages[2],
                size: smallSize,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGroupImages({required String imageUrl, required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xffeeeeee),
              alignment: Alignment.center,
              child: Icon(
                Icons.person,
                size: size * .45,
                color: const Color(0xff999999),
              ),
            );
          },
        ),
      ),
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

  Widget _buildOnlineIndicatora(double size) {
    return Container(
      width: size * 0.2,
      height: size * 0.2,

      decoration: BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}
