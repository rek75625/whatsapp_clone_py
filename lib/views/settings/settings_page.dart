import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/app_font_sizing.dart';
import 'package:whatsapp_clone_py/constants/app_sizing.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';
import 'package:whatsapp_clone_py/constants/images_constant.dart';
import 'package:whatsapp_clone_py/views/chats/widgets/add_story.dart';
import 'package:whatsapp_clone_py/views/chats/widgets/chat_tiles_list.dart';

class SettingsPage extends StatefulWidget {
  final ScrollController scrollController;
  const SettingsPage({super.key, required this.scrollController});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isSearch = false;
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: backgroundColor(context),
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
                    isSearch ? 'Search' : 'Settings',
                    style: TextStyle(
                      fontSize: AppFontSizing.fontHeadingLarge24,
                      fontWeight: FontWeight.w800,
                      color: blackColor(context).darkShade,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSearch = !isSearch;
                        searchController.clear();
                      });
                    },
                    icon: Transform.rotate(
                      angle: isSearch ? 0 : pi * (90 / 360),
                      child: Icon(
                        isSearch ? Icons.search : Icons.add,
                        size: AppFontSizing.fontHeadingLarge24,
                        color: AppColors.greenColor,
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),

                child: isSearch
                    ? SizedBox(key: ValueKey('empty'))
                    : Padding(
                        key: ValueKey('search'),

                        padding: EdgeInsets.only(top: 4, bottom: 8),

                        child: SizedBox(
                          height: 48,

                          child: TextFormField(
                            controller: searchController,

                            decoration: InputDecoration(
                              hintText: 'Search here......',

                              prefixIcon: Icon(Icons.search),

                              filled: true,

                              fillColor: Colors.grey.shade100,

                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 12,
                              ),

                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),

                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
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
              Expanded(
                child: ChatTilesList(
                  key: Key("Settings"),
                  isSearch: isSearch,
                  searchController: searchController,
                ),
              ),
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
