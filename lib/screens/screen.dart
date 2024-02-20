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
  //애니메이션 컨트롤러
  late final AnimationController _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 1));

  //trans를 위한 Animation<Offset>
  late final Animation<Offset> _trans =
      Tween(begin: const Offset(0, 0), end: const Offset(0.5, 0)).animate(
          //애니메이션에 커브감 주기
          CurvedAnimation(
              parent: _animationController,
              curve:
                  //AnimationController 진행률이 50% ~ 100% 일때 수행
                  const Interval(0.5, 1.0,
                      curve: Curves.fastLinearToSlowEaseIn)));

  //scale을 위한 Animation<Offset>
  late final Animation<double> _scale =
      Tween(begin: 1.0, end: 0.6).animate(CurvedAnimation(
          parent: _animationController,
          curve:
              //AnimationController 진행률이 0% ~ 50% 일때 수행
              const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn)));

  //클릭 했을 때 애니메이션효과 실행
  void onTapforward() {
    _animationController.forward();
  }

  //클릭 했을 때 애니메이션효과 거꾸로 실행
  void onTapReverse() {
    _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: onTapReverse,
            ),
          ),
          backgroundColor: Colors.blue,
          body: const Center(
            child: Text("첫번쨰 Stack 화면"),
          ),
        ),
        SlideTransition(
          position: _trans,
          child: ScaleTransition(
            scale: _scale,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: onTapforward,
                  )
                ],
              ),
              backgroundColor: Colors.green,
              body: const Center(
                child: Text("두번째 Stack 화면"),
              ),
            ),
          ),
        )
      ],
    );
  }
}
