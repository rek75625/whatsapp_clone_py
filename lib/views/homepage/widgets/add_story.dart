import 'package:flutter/material.dart';

/// ===============================================================
/// WhatsApp Style Story / Status Widget
/// ===============================================================

Widget addStoryOrStatusWidget({
  required double size,
  required IconData? iconData,
  required String title,
  required String? imagePath,
}) {
  final bool hasImage = imagePath != null && imagePath.isNotEmpty;
  final bool isAddStatus = iconData != null;

  return SizedBox(
    width: size + 12,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // =========================================================
        // PROFILE / STATUS IMAGE
        // =========================================================
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: size,
              height: size,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,

                // Green ring for status
                color: hasImage ? Colors.green : Colors.grey.shade400,
              ),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: ClipOval(
                  child: hasImage
                      ? Image.network(
                          imagePath,
                          width: size,
                          height: size,
                          fit: BoxFit.cover,

                          // Prevent invalid asset from crashing the UI
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade300,
                              child: Icon(
                                Icons.person_rounded,
                                size: size * .42,
                                color: Colors.grey.shade600,
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Colors.grey.shade300,
                          child: Icon(
                            Icons.person_rounded,
                            size: size * .42,
                            color: Colors.grey.shade600,
                          ),
                        ),
                ),
              ),
            ),

            // =====================================================
            // ADD STATUS BUTTON
            // =====================================================
            if (isAddStatus)
              Container(
                width: size * .32,
                height: size * .32,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(iconData, size: size * .18, color: Colors.white),
              ),
          ],
        ),

        const SizedBox(height: 6),

        // =========================================================
        // STATUS TITLE
        // =========================================================
        SizedBox(
          width: size + 12,
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}
