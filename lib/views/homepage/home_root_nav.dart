import 'package:flutter/material.dart';
import 'package:hidable/hidable.dart';
import 'package:whatsapp_clone_py/constants/colors.dart';
import 'package:whatsapp_clone_py/views/calls/call_page.dart';
import 'package:whatsapp_clone_py/views/chats/chat_page.dart';
import 'package:whatsapp_clone_py/views/settings/settings_page.dart';

class HomeRootNav extends StatefulWidget {
  const HomeRootNav({super.key});

  @override
  State<HomeRootNav> createState() => _HomeRootNavState();
}

class _HomeRootNavState extends State<HomeRootNav> {
  // Default to the "Chats" tab

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    List<Widget> widgetOptions = <Widget>[
      CallPage(scrollController: scrollController), // Index 0: Home
      ChatPage(scrollController: scrollController), // Index 1: Chats
      SettingsPage(scrollController: scrollController), // Index 2: Settings
    ];
    int selectedIndex = 0;
    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: SafeArea(child: widgetOptions.elementAt(selectedIndex)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Open new chat');
        },
        backgroundColor: AppColors.greenColor,
        child: Icon(Icons.add_box_sharp, color: Colors.white),
      ),
      bottomNavigationBar: SizedBox(
        height: 62,
        child: Hidable(
          controller: scrollController,
          child: BottomNavigationBar(
            iconSize: 24,

            selectedFontSize: 12,
            unselectedFontSize: 12,
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            backgroundColor: AppColors.backgroundColor,
            selectedItemColor: AppColors.greenColor,
            unselectedItemColor: blackColor(context).darkShade,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.phone),
                label: "Calls",
                backgroundColor: selectedIndex == 0
                    ? AppColors.greenColor
                    : null,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble),
                label: "Chats",
                backgroundColor: selectedIndex == 1
                    ? AppColors.greenColor
                    : null,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
                backgroundColor: selectedIndex == 2
                    ? AppColors.greenColor
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
