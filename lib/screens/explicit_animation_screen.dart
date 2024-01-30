import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ExplicitAnimationScreen extends StatefulWidget {
  const ExplicitAnimationScreen({super.key});
  static String routeName = "explicitanimation";
  static String routeURL = "explicitanimation";

  @override
  State<ExplicitAnimationScreen> createState() =>
      _ExplicitAnimationScreenState();
}

class _ExplicitAnimationScreenState extends State<ExplicitAnimationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this);
  @override
  void initState() {
    super.initState();
    Ticker((elapsed) {
      print(elapsed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Explicit Animations"),
      ),
    );
  }
}
