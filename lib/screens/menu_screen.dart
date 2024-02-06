import 'package:flutter/material.dart';
import 'package:flutter_application_animation/screens/apple_watch_screen.dart';
import 'package:flutter_application_animation/screens/explicit_animation_screen.dart';
import 'package:flutter_application_animation/screens/implicit_animation_screen.dart';
import 'package:flutter_application_animation/screens/screen.dart';
import 'package:flutter_application_animation/screens/swiping_cards_screen.dart';
import 'package:go_router/go_router.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  static String routeName = "menuscreen";
  static String routeURL = "/menuscreen";
  @override
  Widget build(BuildContext context) {
    final List<String> screenList = [
      ImplicitAnimationScreen.routeName,
      ExplicitAnimationScreen.routeName,
      AppleWatchScreen.routeName,
      CanvasScreen.routeName,
      SwipingCardsScreen.routeName
    ];
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text("Menu Screen"),
        ),
        body: ListView.separated(
          itemCount: screenList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                context.pushNamed(screenList[index]);
              },
              child: ListTile(
                trailing: const Icon(
                  Icons.cookie,
                  color: Colors.amber,
                  size: 32,
                ),
                title: Text(screenList[index]),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
        ));
  }
}
