import 'package:animations_app/screens/menu_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Animations Masterclass',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
        ),
        navigationBarTheme: const NavigationBarThemeData(
          indicatorColor: Colors.amber,
        ),
      ),
      home: const MenuScreen(),
    );
  }
}
