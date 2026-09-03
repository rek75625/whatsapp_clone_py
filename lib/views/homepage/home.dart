import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/app_font_sizing.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';
import 'package:whatsapp_clone_py/views/homepage/widgets/add_story.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,

      body: SafeArea(
        child: Padding(
          padding: AppSizes.padHori16,
          child: Column(
            children: [
              SizedBox(height: AppSizes.size32),
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
                    Icons.group_add,
                    size: AppFontSizing.fontHeadingLarge24,
                    color: AppColors.greenColor,
                  ),
                ],
              ),
              SizedBox(height: AppSizes.size24),
              Divider(color: AppColors.lightGrey, thickness: 1.0),
              Row(
                children: [
                  addStoryWidget(size: 50, iconData: Icons.add),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(),
                    child: ListView.builder(
                      itemBuilder: (context, index) => storiesWidget(
                        size: 50,
                        imageUrl: "https://short.do/mzcy2A",
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
