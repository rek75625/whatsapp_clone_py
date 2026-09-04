import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/app_font_sizing.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';
import 'package:whatsapp_clone_py/constants/images_constant.dart';
import 'package:whatsapp_clone_py/views/chats/chat_page.dart';
import 'package:whatsapp_clone_py/views/homepage/widgets/add_story.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: AppSizes.padHori16,
          child: Column(
            children: [
              AppSizes.height8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chats',
                    style: TextStyle(
                      fontSize: AppFontSizing.fontHeadingLarge24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Icon(
                    Icons.search,
                    size: AppFontSizing.fontHeadingLarge24,
                    color: AppColors.greenColor,
                  ),
                ],
              ),
              AppSizes.height8,
              Divider(color: AppColors.lightGrey, thickness: 1.0),
              AppSizes.height8,
              Container(
                height: screenHeight * 0.14,
                width: screenWidth, // Adjust width based on screen size
                decoration: BoxDecoration(),
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (context, index) {
                    if (index == 0) {
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
              ),
              Divider(color: AppColors.lightGrey, thickness: 1.0),
              Expanded(child: ChatsPage()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Open new chat');
        },
        backgroundColor: AppColors.greenColor,
        child: Icon(Icons.add_box_sharp, color: Colors.white),
      ),
    );
  }
}
