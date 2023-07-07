import 'package:animations/screens/explicit_animations_screen.dart';
import 'package:animations/screens/implicit_animations_screen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Menu'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const ImplicitAnimationsScreen());
              },
              child: const Text(
                'Implicit Animations',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _goToPage(context, const ExplicitAnimationsScreen());
              },
              child: const Text(
                'Explicit Animations',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
