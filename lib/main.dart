import 'package:flutter/material.dart';
import 'package:whatsapp_clone_py/views/homepage/home_root_nav.dart';

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
      title: 'WhatsApp Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      builder: (context, child) {
        return ScrollConfiguration(behavior: ScrollGlowEffect(), child: child!);
      },
      home: HomeRootNav(),
    );
  }
}
