import 'dart:math';
import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  static String routeName = "applewatch";
  static String routeURL = "applewatch";
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2000),
  )..forward();

  late Animation<double> _animation =
      Tween(begin: 0.0, end: 1.5).animate(_curvedAnimation);

  late Animation<double> _animation2 =
      Tween(begin: 0.0, end: 1.5).animate(_curvedAnimation);

  late Animation<double> _animation3 =
      Tween(begin: 0.0, end: 1.5).animate(_curvedAnimation);

  late final CurvedAnimation _curvedAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );

  @override
  void initState() {
    _animationController.addListener(() {});
    _animationController.addStatusListener((status) {});
    _animateValues();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animateValues() {
    final newBegin = _animation.value;
    final random = Random();
    final newEnd = random.nextDouble() * 2.0;
    final random2 = Random();
    final newEnd2 = random2.nextDouble() * 2.0;
    final random3 = Random();
    final newEnd3 = random3.nextDouble() * 2.0;
    setState(() {
      _animation =
          Tween(begin: newBegin, end: newEnd).animate(_curvedAnimation);
      _animation2 =
          Tween(begin: newBegin, end: newEnd2).animate(_curvedAnimation);
      _animation3 =
          Tween(begin: newBegin, end: newEnd3).animate(_curvedAnimation);
    });
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Apple Watch"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: AppleWatchPainter(
                    progress: _animation.value,
                    progress2: _animation2.value,
                    progress3: _animation3.value,
                  ),
                  size: const Size(200, 200),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: ElevatedButton(
                  onPressed: _animateValues, child: const Icon(Icons.refresh)),
            )
          ],
        ),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final double progress;
  final double progress2;
  final double progress3;
  AppleWatchPainter(
      {required this.progress,
      required this.progress2,
      required this.progress3});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const startingAngle = -0.5 * pi;

    // final paintCircle = Paint()
    //   ..color = Colors.pink.shade200
    //   ..style = PaintingStyle.stroke
    //   ..strokeWidth = 20;
    // canvas.drawCircle(center, 100, paintCircle);

    // final paintCircle2 = Paint();
    // paintCircle2.color = Colors.limeAccent.shade100.withOpacity(1);
    // paintCircle2.style = PaintingStyle.stroke;
    // paintCircle2.strokeCap = StrokeCap.round;
    // paintCircle2.strokeWidth = 20;
    // canvas.drawCircle(center, 78, paintCircle2);

    // final paintCircle3 = Paint()
    //   ..color = Colors.lightBlue.shade200.withOpacity(0.9)
    //   ..style = PaintingStyle.stroke
    //   ..strokeCap = StrokeCap.round
    //   ..strokeWidth = 20;
    // canvas.drawCircle(center, 56, paintCircle3);

    // red arc

    final redArcRect = Rect.fromCircle(center: center, radius: 100);

    final redArcPaint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20;

    canvas.drawArc(
      redArcRect,
      startingAngle,
      progress * pi,
      false,
      redArcPaint,
    );

    final redArcRect2 = Rect.fromCircle(center: center, radius: 78);

    final redArcPaint2 = Paint()
      ..color = Colors.limeAccent.shade700
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20;

    canvas.drawArc(
      redArcRect2,
      startingAngle,
      progress2 * pi,
      false,
      redArcPaint2,
    );

    final redArcRect3 = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 56);

    final redArcPaint3 = Paint()
      ..color = Colors.lightBlue
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20;

    canvas.drawArc(
      redArcRect3,
      startingAngle,
      progress3 * pi,
      false,
      redArcPaint3,
    );
  }

  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
