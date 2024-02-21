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
    _currentImage = newImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Axis"),
      ),
      body: Column(
        children: [
          for (var i in [1, 2, 3, 4])
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Text(i.toString()))
              ],
            )
        ],
      ),
    );
  }
}
