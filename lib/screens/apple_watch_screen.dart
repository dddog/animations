import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  )..forward();

  late final CurvedAnimation _curvedAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );

  late List<Animation<double>> _animation = List.generate(
      3,
      (index) => Tween(
            begin: 0.005,
            end: Random().nextDouble() * 2.0,
          ).animate(_curvedAnimation));

  void _animateValues() {
    _animation = List.generate(
        3,
        (index) => Tween(
              begin: _animation[index].value,
              end: Random().nextDouble() * 2.0,
            ).animate(_curvedAnimation));
    _animationController.forward(
      from: 0.0,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Apple Watch'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return CustomPaint(
              painter: AppleWatchPainter(
                progress: _animation.map((e) => e.value).toList(),
              ),
              size: const Size(360, 360),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateValues,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final List<double> progress;
  AppleWatchPainter({
    required this.progress,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    const startAngle = -0.5 * pi;

    final redRedius = (size.width / 2) * 0.9;

    final redPaint = Paint()
      ..color = Colors.red.shade300.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;

    canvas.drawCircle(
      center,
      redRedius,
      redPaint,
    );

    final greenRedius = (size.width / 2) * 0.71;

    final greenPaint = Paint()
      ..color = Colors.green.shade300.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;

    canvas.drawCircle(
      center,
      greenRedius,
      greenPaint,
    );

    final blueRedius = (size.width / 2) * 0.52;

    final bluePaint = Paint()
      ..color = Colors.cyan.shade300.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;

    canvas.drawCircle(
      center,
      blueRedius,
      bluePaint,
    );

    final redRect = Rect.fromCircle(
      center: center,
      radius: redRedius,
    );
    final redArcPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30;
    canvas.drawArc(
      redRect,
      startAngle,
      progress[0] * pi,
      false,
      redArcPaint,
    );

    final greenRect = Rect.fromCircle(
      center: center,
      radius: greenRedius,
    );
    final greenArcPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30;
    canvas.drawArc(
      greenRect,
      startAngle,
      progress[1] * pi,
      false,
      greenArcPaint,
    );

    final blueRect = Rect.fromCircle(
      center: center,
      radius: blueRedius,
    );
    final blueArcPaint = Paint()
      ..color = Colors.cyan
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 30;
    canvas.drawArc(
      blueRect,
      startAngle,
      progress[2] * pi,
      false,
      blueArcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
