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
  static const List<Widget> _widgetOptions = <Widget>[
    CallPage(), // Index 0: Home
    ChatPage(), // Index 1: Chats
    SettingsPage(), // Index 2: Settings
  ];
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    int selectedIndex = 1;
    return Scaffold(
      backgroundColor: backgroundColor(context),
      body: SafeArea(child: _widgetOptions.elementAt(selectedIndex)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('Open new chat');
        },
        backgroundColor: AppColors.greenColor,
        child: Icon(Icons.add_box_sharp, color: Colors.white),
      ),
      bottomNavigationBar: Hidable(
        controller: scrollController,
        child: BottomNavigationBar(
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

              backgroundColor: selectedIndex == 0 ? AppColors.greenColor : null,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),

              backgroundColor: selectedIndex == 1 ? AppColors.greenColor : null,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),

              backgroundColor: selectedIndex == 2 ? AppColors.greenColor : null,
            ),
          ],
        ),
      ),
    );
  }
}
