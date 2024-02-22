import 'package:flutter/material.dart';

class FadeThroughScreen extends StatefulWidget {
  static String routeName = "fade";
  static String routeURL = "fade";
  const FadeThroughScreen({super.key});

  @override
  State<FadeThroughScreen> createState() => _FadeThroughScreenState();
}

class _FadeThroughScreenState extends State<FadeThroughScreen> {
  int index = 0;

  void _onNewDestination(int newIndex) {
    setState(() {
      index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: _onNewDestination,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
            NavigationDestination(
                icon: Icon(Icons.notifications), label: "Notify"),
            NavigationDestination(
                icon: Icon(Icons.settings), label: "Settings"),
          ]),
    );
  }
}
