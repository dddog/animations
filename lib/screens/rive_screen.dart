import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveScreen extends StatefulWidget {
  const RiveScreen({super.key});

  @override
  State<RiveScreen> createState() => _RiveScreenState();
}

class _RiveScreenState extends State<RiveScreen> {
  late final StateMachineController _stateMachineController;

  void _onInit(Artboard artboard) {
    _stateMachineController = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
      onStateChange: (stateMachineName, stateName) {
        print('$stateMachineName, $stateName');
      },
    )!;
    artboard.addController(_stateMachineController);
  }

  void _tooglePanel() {
    final input = _stateMachineController.findInput<bool>('panelActive')!;
    input.change(!input.value);
  }

  @override
  void dispose() {
    _stateMachineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Rive'),
      // ),
      body: Stack(
        children: [
          const RiveAnimation.asset(
            'assets/animations/ball-animation.riv',
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 50,
                sigmaY: 50,
              ),
              child: const Center(
                child: Text(
                  'Welcome to AI App',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // body: Container(
      //   color: const Color(0xFFFF2ECC),
      //   width: double.infinity,
      //   child: RiveAnimation.asset(
      //     'assets/animations/star-animation.riv',
      //     artboard: 'New Artboard',
      //     stateMachines: const ['State Machine 1'],
      //     onInit: _onInit,
      //   ),
      // ),
    );
  }
}
