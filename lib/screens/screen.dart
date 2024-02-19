import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  static String routeName = "testscreen";
  static String routeURL = "testscreen";
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000));
  late final Animation<Offset> _trans =
      Tween(begin: const Offset(0, 0), end: const Offset(1, 1))
          .animate(_animationController);
  late final Animation<double> _opacity =
      Tween(begin: 0.0, end: 1.0).animate(_animationController);

  void onTapforward() {
    _animationController.forward();
  }

  void onTapReverse() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.blue,
          body: Center(
            child: Text("첫번쨰 Stack 화면"),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.green,
          body: Center(
            child: Text("두번째 Stack 화면"),
          ),
        )
      ],
    );
  }
}
