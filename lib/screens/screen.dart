import 'dart:ui';

import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  static String routeName = "testscreen";
  static String routeURL = "testscreen";
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.6);

  int currentColor = 0;

  List<Color> colorList = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
  ];

  void changePage(int newPage) {
    currentColor = newPage;
    setState(() {});
  }

  @override
  void initState() {
    _pageController.addListener(() {
      if (_pageController.page == null) return;
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.linear,
          //배경이 되는 Container
          child: Container(
            //key를 사용하여 새로 리빌드되는 효과를 줌
            key: ValueKey(currentColor),
            color: colorList[currentColor],
            child: BackdropFilter(
              //blur 필터효과를 사용하여 흐리게 만들어 줌
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
        ),
        Center(
            child: PageView.builder(
          controller: _pageController,
          onPageChanged: changePage,
          scrollDirection: Axis.vertical,
          itemCount: colorList.length,
          itemBuilder: (context, index) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //PageView에 포함된 Container
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: colorList[index],
                    borderRadius: const BorderRadius.all(Radius.circular(45))),
                width: 300,
                height: 300,
                child: Text(colorList[index].value.toString()),
              ),
            ],
          ),
        )),
      ]),
    );
  }
}
