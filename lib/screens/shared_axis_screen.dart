import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisScreen extends StatefulWidget {
  static String routeURL = "sharedaxis";
  static String routeName = "sharedaxis";
  const SharedAxisScreen({super.key});

  @override
  State<SharedAxisScreen> createState() => _SharedAxisScreenState();
}

class _SharedAxisScreenState extends State<SharedAxisScreen> {
  int _currentImage = 1;
  void _goToImange(int newImage) {
    setState(() {
      _currentImage = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Axis"),
      ),
      body: Column(
        children: [
          PageTransitionSwitcher(
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
                SharedAxisTransition(
                    //2개의 child간의 SharedAxis Trans 애니메이션을 도와주는 위젯
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    child: child),
            child: Container(
                key: ValueKey(_currentImage),
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(45))),
                width: 400,
                height: 400,
                child: Image.asset(
                  "assets/movies/$_currentImage.jpg",
                  fit: BoxFit.cover,
                )),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 1; i <= 5; i++)
                ElevatedButton(
                    onPressed: () => _goToImange(i), child: Text(i.toString()))
            ],
          )
        ],
      ),
    );
  }
}
