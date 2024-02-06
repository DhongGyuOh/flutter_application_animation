import 'dart:math';
import 'package:flutter/material.dart';

class SwipingCardsScreen extends StatefulWidget {
  static String routeName = "swingcard";
  static String routeURL = "swingcard";
  const SwipingCardsScreen({super.key});

  @override
  State<SwipingCardsScreen> createState() => _SwipingCardsScreenState();
}

class _SwipingCardsScreenState extends State<SwipingCardsScreen>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;
  late final AnimationController _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      //_animationController의 최대값이 1 최소값이 0 이기 때문에 움직임이 제한적임
      //따라서 lowBound, upperBound를 MideaQuery를 곱해서 정해줌
      lowerBound: (size.width + 100) * -1,
      upperBound: (size.width + 100),
      value: 0.0 //value를 0으로 설정하여 초기값을 0으로 만들어 위치를 가운데로 오게함
      );
  double posX = 0;
  int index = 1;
  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    //드래그할 때 x값을 animationcontroller.value에 넣어줌(드래그 위치에 따라 x 값이 업데이트됨)
    _animationController.value += details.delta.dx;
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    //print(_animationController.value.abs());
    final bound = size.width - 200;
    //절대값이 bound 값보다 클때 _animationController.value를 size.width + 100 을 만들어 사라지게 만들어줌
    if (_animationController.value.abs() >= bound) {
      //음수일때는 왼쪽으로 넘어가게 함
      if (_animationController.value.isNegative) {
        //.whenComplete()를 사용하여 카드를 버리는 애니메이션이 완료되었을 때 value를 다시 0으로 만들어 되돌림
        _animationController
            .animateTo((size.width + 200) * -1)
            .whenComplete(() {
          _animationController.value = 0;
          index = index == 13 ? 1 : index + 1;
          setState(() {});
        });
      } else {
        _animationController.animateTo(size.width + 200).whenComplete(() {
          _animationController.value = 0;
          index = index == 13 ? 1 : index + 1;
          setState(() {});
        });
      }
    } else {
      //드래그 끝냈을 때 animationcontroller.value 값을 0으로 넣고, curve를 줘서 애니메이션에 굴곡을 줌
      _animationController.animateTo(0,
          curve: Curves.bounceOut, duration: const Duration(milliseconds: 500));
    }
  }

  late final Tween<double> _rotation = Tween(
    begin: -15,
    end: 15,
  );
  late final Tween<double> _scale = Tween(begin: 0.8, end: 1.0);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Swiping Cards"),
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          //angle 계산의미: 화면 중앙에 위치하기 위함
          final angle = _rotation.transform(
              (_animationController.value + size.width / 2) / size.width);
          final scale =
              _scale.transform(_animationController.value.abs() / size.width);
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                        left: 40,
                        child: Transform.scale(
                            scale: min(scale, 1.0), //min()둘중 작은 작은 수를 반환하는 함수
                            child: Card(
                              index: index == 13 ? 1 : index + 1,
                            ))),
                    Align(
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        onHorizontalDragUpdate: _onHorizontalDragUpdate,
                        onHorizontalDragEnd: _onHorizontalDragEnd,
                        child: Transform.translate(
                          offset: Offset(_animationController.value, 0),
                          child: Transform.rotate(
                              angle: angle * pi / 180,
                              child: Card(index: index)),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _animationController
                              .animateTo((size.width + 200) * -1)
                              .whenComplete(() {
                            _animationController.value = 0;
                            index = index == 13 ? 1 : index + 1;
                            setState(() {});
                          });
                        },
                        child: AnimatedScale(
                          scale:
                              _animationController.value < 0 ? scale * 1.5 : 1,
                          duration: const Duration(milliseconds: 50),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green.withOpacity(
                                    _animationController.value > 0
                                        ? 0
                                        : _animationController.value.abs() /
                                            _animationController.upperBound),
                                border:
                                    Border.all(width: 1, color: Colors.green)),
                            child: Icon(
                              Icons.done,
                              color: Colors.lightGreen.withOpacity(
                                  _animationController.value > 0
                                      ? 1
                                      : 1 -
                                          _animationController.value.abs() /
                                              _animationController.upperBound),
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _animationController
                              .animateTo(size.width + 200)
                              .whenComplete(() {
                            _animationController.value = 0;
                            index = index == 13 ? 1 : index + 1;
                            setState(() {});
                          });
                        },
                        child: AnimatedScale(
                          scale:
                              _animationController.value > 0 ? scale * 1.5 : 1,
                          duration: const Duration(milliseconds: 50),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red.withOpacity(
                                    _animationController.value < 0
                                        ? 0
                                        : _animationController.value.abs() == 0
                                            ? 0
                                            : _animationController.value.abs() /
                                                _animationController
                                                    .upperBound),
                                border:
                                    Border.all(width: 1, color: Colors.pink)),
                            child: Icon(
                              Icons.close,
                              size: 32,
                              color: Colors.pink.withOpacity(
                                  _animationController.value < 0
                                      ? 1
                                      : 1 -
                                          _animationController.value.abs() /
                                              _animationController.upperBound),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class Card extends StatelessWidget {
  final int index;
  const Card({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.7,
        child: Image.asset(
          "assets/movies/$index.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
