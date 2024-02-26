import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TestScreen extends StatefulWidget {
  static String routeName = "testscreen";
  static String routeURL = "testscreen";
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final List<MaterialColor> colorList = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.lightGreen,
    Colors.lightBlue,
    Colors.indigo,
    Colors.deepPurple,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: AnimateList(
                    onInit: (controller) {},
                    onPlay: (controller) {},
                    onComplete: (controller) {
                      controller.reverse();
                    },
                    effects: [
                      const FlipEffect(
                          begin: 0,
                          end: 1,
                          direction: Axis.vertical,
                          duration: Duration(milliseconds: 500)),
                      const ScaleEffect(
                          begin: Offset(1, 1), end: Offset(1.5, 1.5))
                    ],
                    interval: 500.ms,
                    children: [
                      for (int i = 0; i < colorList.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            height: 70,
                            width: 350,
                            decoration: BoxDecoration(
                                color: colorList[i],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(25))),
                          ),
                        ),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
