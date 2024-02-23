import 'package:animations/animations.dart';
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
      body: Center(
        child: PageTransitionSwitcher(
          transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
              FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          ),
          child: [
            const NavigationPage(
              key: ValueKey(0),
              text: "Profile Page",
              icon: Icons.person,
            ),
            const NavigationPage(
              key: ValueKey(1),
              text: "Notify Page",
              icon: Icons.notifications,
            ),
            const NavigationPage(
              key: ValueKey(2),
              text: "Settings Page",
              icon: Icons.settings,
            ),
          ][index],
        ),
      ),
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

class NavigationPage extends StatelessWidget {
  final String text;
  final IconData icon;

  const NavigationPage({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 400,
          color: Colors.amber,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
