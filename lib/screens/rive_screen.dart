import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveScreen extends StatefulWidget {
  static String routeName = "rivescreen";
  static String routeURL = "rivescreen";
  const RiveScreen({super.key});

  @override
  State<RiveScreen> createState() => _RiveScreenState();
}

class _RiveScreenState extends State<RiveScreen> {
  late final StateMachineController _stateMachineController;

  void _onInit(Artboard artboard) {
    _stateMachineController = StateMachineController.fromArtboard(
      artboard,
      "State Machine 1",
      onStateChange: (stateMachineName, stateName) {
        //State가 바뀔 때 값을 가져옴
        //stateMachineName:State Machine 1
        //stateName: Correct, Incorrect, Idle
        final snackBar = SnackBar(
            content: Text(
          '$stateMachineName / $stateName',
          style: const TextStyle(fontSize: 28, color: Colors.yellow),
        ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    )!;
    artboard.addController(_stateMachineController);
  }

  void _onTapCorrect() {
    //state Machine 으로 부터 Input을 가져옴
    final input = _stateMachineController.findInput<bool>("Correct")!;
    input.change(true);
  }

  void _onTapIncorrect() {
    final input = _stateMachineController.findInput<bool>("Incorrect")!;
    input.change(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 400,
              width: 500,
              //https://rive.app/community/595-1139-bear-avatar-remix/
              child: RiveAnimation.asset(
                "assets/animations/reaction_bear.riv",
                fit: BoxFit.cover,
                artboard: "New Artboard",
                stateMachines: const ["State Machine 1"],
                onInit: _onInit,
              ),
            ),
            ElevatedButton(
              onPressed: _onTapCorrect,
              child: const Text("Correct Answer"),
            ),
            ElevatedButton(
                onPressed: _onTapIncorrect,
                child: const Text("Incorrect Answer"))
          ],
        ),
      ),
    );
  }
}
