import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/images_constant.dart';
import 'package:whatsapp_clone_py/widgets/add_story.dart';

class StoryAndStatus extends StatelessWidget {
  const StoryAndStatus({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.addStatus,
  });

  final double screenHeight;
  final double screenWidth;
  final bool addStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.14,
      width: screenWidth, // Adjust width based on screen size
      decoration: BoxDecoration(),
      child: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          if (addStatus && index == 0) {
            return addStoryOrStatusWidget(
              iconData: Icons.add,
              title: 'Your Story',
              size: 60,
              imagePath: null,
            );
          }

          return addStoryOrStatusWidget(
            iconData: null,
            title: 'User $index',
            size: 60,
            imagePath: ImagesConstant.statusOrAddStory,
          );
        },
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
