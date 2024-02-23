import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WalletScreen extends StatefulWidget {
  static String routeName = "wallet";
  static String routeURL = "wallet";
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _isExpanded = false;
  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _onShrink() {
    setState(() {
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Animate(
                  effects: [
                    FadeEffect(
                      begin: 0,
                      end: 1,
                      duration: 3.seconds,
                      curve: Curves.bounceOut,
                    ),
                    const FlipEffect(
                        alignment: Alignment.center,
                        begin: 0.5,
                        end: 2.0,
                        direction: Axis.vertical)
                  ],
                  child: const Text(
                    "110-479-562935",
                    style: TextStyle(fontSize: 32),
                  )),
              const Text(
                "￦100,000,000",
                style: TextStyle(fontSize: 20),
              )
                  .animate()
                  .fadeIn(begin: 0, duration: 2.seconds)
                  .then(delay: 500.ms)
                  .scale(
                      alignment: Alignment.center,
                      begin: Offset.zero,
                      end: const Offset(1, 1),
                      duration: 1.seconds),
              GestureDetector(
                onVerticalDragEnd: (_) => _onShrink(),
                onTap: _toggleExpand,
                child: Column(
                  children: AnimateList(interval: 500.ms, effects: [
                    SlideEffect(
                        begin: const Offset(-1.5, -0.5),
                        end: const Offset(0, 0),
                        duration: 1000.ms,
                        curve: Curves.fastOutSlowIn)
                  ], children: [
                    CreditCard(
                      color: Colors.pink,
                      isExpended: _isExpanded,
                    )
                        .animate(
                            delay: 3500.ms,
                            target: //target: 진행률을 나타냄 0 ~ 1
                                _isExpanded ? 0 : 1)
                        .flipV(end: 0.2),
                    CreditCard(
                      color: Colors.orange,
                      isExpended: _isExpanded,
                    )
                        .animate(delay: 3500.ms, target: _isExpanded ? 0 : 1)
                        .flipV(end: 0.2)
                        .slideY(end: -0.8),
                    CreditCard(
                      color: Colors.amber,
                      isExpended: _isExpanded,
                    )
                        .animate(delay: 3500.ms, target: _isExpanded ? 0 : 1)
                        .flipV(end: 0.2)
                        .slideY(end: -0.8 * 2),
                    CreditCard(
                      color: Colors.lightGreen,
                      isExpended: _isExpanded,
                    )
                        .animate(delay: 3500.ms, target: _isExpanded ? 0 : 1)
                        .flipV(end: 0.2)
                        .slideY(end: -0.8 * 3),
                    CreditCard(
                      color: Colors.blue,
                      isExpended: _isExpanded,
                    )
                        .animate(delay: 3500.ms, target: _isExpanded ? 0 : 1)
                        .flipV(end: 0.2)
                        .slideY(end: -0.8 * 4),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  final MaterialColor color;
  final bool isExpended;
  const CreditCard({super.key, required this.color, required this.isExpended});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !isExpended,
      child: Hero(
        tag: color,
        child: Material(
          type: MaterialType.transparency,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CardDetailScreen(
                  color: color,
                ),
              ));
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    width: 300,
                    height: 180,
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                const Positioned(
                  left: 30,
                  top: 40,
                  child: Text(
                    "￦20,000,000",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const Positioned(
                  left: 30,
                  bottom: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("Visa Card"), Text("****-****-****-3728")],
                  ),
                ),
                const Positioned(
                  bottom: 40,
                  right: 25,
                  child: CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 25,
                  ),
                ),
                const Positioned(
                  bottom: 40,
                  right: 50,
                  child: Opacity(
                    opacity: 0.9,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 25,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 25,
                  right: 30,
                  child: Text(
                    "Master Card",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardDetailScreen extends StatelessWidget {
  final MaterialColor color;
  const CardDetailScreen({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transtion"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CreditCard(color: color, isExpended: true),
              ...[
                for (int i = 0; i < 7; i++)
                  ListTile(
                    leading: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: color.shade100),
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            Icons.lunch_dining,
                            size: 40,
                          ),
                        )),
                    title: const Text(
                      "Lunch",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text("￦ 10,000"),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  )
              ]
                  .animate(interval: 600.ms)
                  .flipV(begin: -1, end: 0, curve: Curves.bounceOut)
                  .fadeIn(begin: 0, curve: Curves.bounceOut)
            ],
          ),
        ),
      ),
    );
  }
}
