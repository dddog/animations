import 'dart:math';

import 'package:flutter/material.dart';

class SwipingCardsScreen extends StatefulWidget {
  const SwipingCardsScreen({super.key});

  @override
  State<SwipingCardsScreen> createState() => _SwipingCardsScreenState();
}

class _SwipingCardsScreenState extends State<SwipingCardsScreen>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
    value: 0.0,
  );

  late final Tween<double> _rotationTween = Tween(
    begin: -15.0,
    end: 15.0,
  );
  late final Tween<double> _scaleTween = Tween(
    begin: 0.8,
    end: 1.0,
  );

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _animationController.value += details.delta.dx;
  }

  void _whenComplete() {
    _animationController.value = 0;
    setState(() {
      _index = _index == 5 ? 1 : _index + 1;
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width - 100;
    final dropZone = size.width + 100;
    if (_animationController.value.abs() >= bound) {
      final factor = _animationController.value.isNegative ? -1 : 1;
      _animationController
          .animateTo(
            (dropZone) * factor,
            curve: Curves.easeOut,
          )
          .whenComplete(_whenComplete);
    } else {
      _animationController.animateTo(
        0,
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  int _index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swiping Cards'),
      ),
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final angle = _rotationTween.transform(
                    (_animationController.value + size.width / 2) /
                        size.width) *
                pi /
                180;

            final scale = _scaleTween
                .transform(_animationController.value.abs() / size.width);

            return Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  top: 100,
                  child: Transform.scale(
                    scale: min(scale, 1.0),
                    child: MovieCard(index: _index == 5 ? 1 : _index + 1),
                  ),
                ),
                Positioned(
                  top: 100,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onHorizontalDragUpdate: _onHorizontalDragUpdate,
                      onHorizontalDragEnd: _onHorizontalDragEnd,
                      child: Transform.translate(
                        offset: Offset(_animationController.value, 0),
                        child: Transform.rotate(
                          angle: angle,
                          child: MovieCard(index: _index),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class MovieCard extends StatelessWidget {
  final int index;
  const MovieCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.5,
        child: Image.asset(
          'assets/images/$index.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
