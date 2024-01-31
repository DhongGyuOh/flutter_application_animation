import 'package:flutter/material.dart';

class ExplicitAnimationScreen extends StatefulWidget {
  const ExplicitAnimationScreen({super.key});
  static String routeName = "explicitanimation";
  static String routeURL = "explicitanimation";

  @override
  State<ExplicitAnimationScreen> createState() =>
      _ExplicitAnimationScreenState();
}

class _ExplicitAnimationScreenState extends State<ExplicitAnimationScreen>
//SingleTickerProviderStateMixin -> Ticker가 하나만 필요할 때
//TickerProviderStateMixin -> Ticker가 여러개 필요할 떄
    with
        SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
      reverseDuration: const Duration(milliseconds: 1000)
      //lowerBound: 50,      upperBound: 100
      );

  late final Animation<Color?> _color =
      ColorTween(begin: Colors.amber, end: Colors.blue).animate(_curve);

  late final Animation<Decoration> _decoration = DecorationTween(
          begin: const BoxDecoration(color: Colors.amber),
          end: const BoxDecoration(color: Colors.red))
      .animate(_curve);

  late final Animation<Offset> _transition =
      Tween(begin: const Offset(0, 0), end: const Offset(20, 20))
          .animate(_curve);

  late final Animation<double> _scale =
      Tween(begin: 0.0, end: 0.5).animate(_curve);

  late final CurvedAnimation _curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
      reverseCurve: Curves.easeInOutExpo);

  @override
  void initState() {
    _animationController.addListener(() {
      _range.value = _animationController.value;
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) _animationController.reverse();
    });
    super.initState();
    // //Ticker는 애니메이션 프레임 하나당 한번 호출됨
    // Ticker((elapsed) {
    //   print(elapsed);
    // });
  }

  void _play() {
    _animationController.forward();
  }

  void _pause() {
    _animationController.stop();
  }

  void _reverse() {
    _animationController.reverse();
  }

  final ValueNotifier<double> _range = ValueNotifier(0.0);

  void _onChanged(double value) {
    _range.value = 0;
    _animationController.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Explicit Animations"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //AnimatedBuilder를 사용하면 화면 전체가 빌드되지않고 builder안에 있는 위젯만 리빌드됨
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Text("${_animationController.value}");
              },
            ),
            AnimatedBuilder(
              animation: _color,
              builder: (context, child) {
                return Transform.translate(
                  offset: _transition.value,
                  child: Container(
                    color: _color.value,
                    width: 100,
                    height: 100,
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _decoration,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scale.value,
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: _decoration.value,
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _play, child: const Text("Play")),
                ElevatedButton(onPressed: _pause, child: const Text("pause")),
                ElevatedButton(
                    onPressed: _reverse, child: const Text("reverse")),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: _range,
              builder: (context, value, child) {
                return Slider(value: value, onChanged: _onChanged);
              },
            )
          ],
        ),
      ),
    );
  }
}
