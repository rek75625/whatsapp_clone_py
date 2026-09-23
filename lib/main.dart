import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/constants/theme.dart';

import 'package:whatsapp_clone_py/views/chats/single_chat_page.dart';

void main() {
  runApp(const MyApp());
}

class ScrollGlowEffect extends ScrollBehavior {
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDiection,
  ) {
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      builder: (context, child) {
        return ScrollConfiguration(behavior: ScrollGlowEffect(), child: child!);
      },
      home: SingleChatPage(),
    );
  }
}
