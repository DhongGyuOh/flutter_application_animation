import 'package:flutter/material.dart';

class ImplicitAnimationScreen extends StatefulWidget {
  const ImplicitAnimationScreen({super.key});
  static String routeName = "implicitanimation";
  static String routeURL = "implicitanimation";

  @override
  State<ImplicitAnimationScreen> createState() =>
      _ImplicitAnimationScreenState();
}

class _ImplicitAnimationScreenState extends State<ImplicitAnimationScreen> {
  bool _visible = true;

  void _trigger() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Implict Animations"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: AnimatedAlign(
                curve: Curves.bounceOut,
                alignment: _visible ? Alignment.topLeft : Alignment.bottomRight,
                duration: const Duration(milliseconds: 1000),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1000),
                  opacity: _visible ? 1 : 0.3,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: AnimatedContainer(
                transform: Matrix4.rotationZ(_visible ? 1 : 0),
                transformAlignment: Alignment.center,
                curve: Curves.easeInOutBack,
                duration: const Duration(
                  milliseconds: 500,
                ),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: _visible ? Colors.red : Colors.blue,
                    borderRadius:
                        BorderRadius.all(Radius.circular(_visible ? 50 : 0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TweenAnimationBuilder(
                tween: ColorTween(begin: Colors.black, end: Colors.green),
                duration: const Duration(milliseconds: 2000),
                curve: Curves.linear,
                builder: (context, value, child) {
                  return Image.network(
                    "https://t1.daumcdn.net/cafeattach/1IHuH/5dcc016c7cdd1f3c5a09f0286dffc09bc1b8c386",
                    fit: BoxFit.contain,
                    width: 100,
                    height: 100,
                    color: value,
                    colorBlendMode: BlendMode.difference,
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _trigger,
              child: const Text("Start Animate"),
            ),
          ],
        ),
      ),
    );
  }
}
