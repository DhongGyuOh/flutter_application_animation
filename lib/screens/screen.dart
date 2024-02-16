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
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );
  late final Animation<double> _scale =
      Tween(begin: 1.0, end: 1.5).animate(_animationController);
  late final ValueNotifier<Offset> _dxy = ValueNotifier(Offset.zero);

  void _onPanStart(DragStartDetails details) {
    _animationController.forward();
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _dxy.value = Offset(
      _dxy.value.dx + details.delta.dx,
      _dxy.value.dy + details.delta.dy,
    );
  }

  void _onPanEnd(DragEndDetails details) {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: _dxy,
          builder: (context, value, child) => GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: Transform.translate(
              offset: _dxy.value,
              child: ScaleTransition(
                scale: _scale,
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: _animationController.status ==
                              AnimationStatus.completed
                          ? Colors.indigo
                          : Colors.pink,
                      shape: BoxShape.circle),
                  child: Text(
                      '(${_dxy.value.dx.ceil()} , ${_dxy.value.dy.ceil()})'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
