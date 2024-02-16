import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_animation/screens/music_player_detail_screen.dart';

class MusicPlayerScreen extends StatefulWidget {
  static String routeName = "musicplayer";
  static String routeURL = "musicplayer";
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  //viewportFraction: 수치가 낮을 수록 크기가 작아지며, 이전,이후 page가 보여지는 비율이 높아짐
  final PageController _pageController = PageController(viewportFraction: 0.8);

  int _currentPage = 0;

  //메소드를 call하는 횟수를 줄이기위해 ValueNotifier 사용 변동되는 값만 전달
  final ValueNotifier<double> _scroll = ValueNotifier(0.0);

  void _onPageChange(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  void _onTap(int index) {
    Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 2000),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: MusicPlayerDetailScreen(index: index),
            );
          },
        ));
  }

  @override
  void initState() {
    _pageController.addListener(() {
      ////1,2,3,4,...page 넘어가는 값을 보기위함
      //print(_pageController.page);
      if (_pageController.page == null) return;
      //page 값을 ValueNotifier로 받음
      _scroll.value = _pageController.page!;
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.linear,
            child: Container(
              //Widget이 가진 Key가 변경될 수 있도록 key를 부여함(key가 변경되면 새로운 child: 위젯으로 인식함)
              //기존 Key를 계속 사용한다면 기존 child 위젯으로만 빌드
              key: ValueKey(_currentPage),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/movies/${_currentPage + 1}.jpg"),
                    fit: BoxFit.cover),
              ),
              //Image 위에 blur Filter를 씌워줌
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10,
                  sigmaY: 10,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          PageView.builder(
            onPageChanged: _onPageChange,
            controller: _pageController,
            itemCount: 13,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder(
                      valueListenable: _scroll,
                      builder: (context, value, child) {
                        //difference: 페이지수를 빼서 Page의 위치가 중앙으로부터 얼마나 왔는지 알기위한 절대값
                        final difference = (value - index).abs();
                        //scale: 양옆의 카드들의 Scale을 줄이기 위한 값계산 1에서 위치만큼 뺌
                        final scale = 1 - (difference * 0.15);
                        return GestureDetector(
                          onTap: () => _onTap(index + 1),
                          child: Hero(
                            tag: "${index + 1}",
                            child: Transform.scale(
                              scale: scale,
                              child: Container(
                                  height: 470,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/movies/${index + 1}.jpg")),
                                  )),
                            ),
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 35,
                  ),
                  const Text(
                    'MovieName',
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'ActorName',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
