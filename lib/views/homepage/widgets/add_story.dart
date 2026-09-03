import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';

Widget addStoryWidget({required double size, required IconData iconData}) {
  return Container(
    width: size,
    height: size,
    margin: AppSizes.padHori8,
    child: Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(radius: 30),
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.green,
              child: Icon(iconData, size: 12, color: Colors.white),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget storiesWidget({required double size, required String imageUrl}) {
  return Container(
    height: size,
    width: size,
    margin: AppSizes.padHori8,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        image: NetworkImage(imageUrl),
        fit: BoxFit.contain,
      ),
    ),
  );
}
