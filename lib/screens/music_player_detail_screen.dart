import 'dart:async';

import 'package:flutter/material.dart';

class MusicPlayerDetailScreen extends StatefulWidget {
  final int index;
  const MusicPlayerDetailScreen({Key? key, required this.index})
      : super(key: key);

  @override
  State<MusicPlayerDetailScreen> createState() =>
      _MusicPlayerDetailScreenState();
}

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen>
    with TickerProviderStateMixin {
  //Text 제목 움직이는 애니메이션
  late final AnimationController _marqueeController =
      AnimationController(vsync: this, duration: const Duration(seconds: 20))
        ..repeat(reverse: true);

  late final Animation<Offset> _marqueeTween = Tween(
    //begin: Offset(1, 0):텍스트 크기의 100%만큼 오른쪽으로 이동한 지점에서 시작
    //begin: Offset(-1, 0):텍스트 크기의 100%만큼 왼쪽으로 이동한 지점에서 시작
    begin: const Offset(0.1, 0),
    end: const Offset(-0.6, 0),
  ).animate(_marqueeController);

  //Text 시간 표시하는 애니메이션
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(minutes: 1),
  )..repeat(reverse: true);

  late double progressTime = 0;
  late Timer _timer;

  //재생/일시정지 버튼 애니메이션
  late final AnimationController _playPauseController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500));
  void _onTapIcon() {
    if (_playPauseController.isCompleted) {
      _playPauseController.reverse();
    } else {
      _playPauseController.forward();
    }
  }

  //volume 애니매이션
  bool _dragging = false;
  void _toggleDragging() {
    _dragging = !_dragging;
    setState(() {});
  }

  final ValueNotifier<double> _volume = ValueNotifier(0);
  void _onvolumeDragUpdate(DragUpdateDetails details) {
    _volume.value += details.delta.dx;
    _volume.value.clamp(0.0, MediaQuery.of(context).size.width - 80);
  }

  @override
  void initState() {
    _animationController.addListener(() {
      setState(() {
        progressTime = _animationController.value * 60; // 분을 초로 변경
      });
    });
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _marqueeController.dispose();
    _playPauseController.dispose();
    _menuController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (progressTime >= 60) {
        setState(() {
          progressTime = 0; // 60초가 지나면 다시 0으로 초기화
        });
      } else {
        setState(() {
          progressTime++; // 1초씩 증가
        });
      }
    });
  }

//Menu 애니메이션(stagged Animation 구현)
  final List<Map<String, dynamic>> _menus = [
    {"icon": Icons.person, "text": "Profile"},
    {"icon": Icons.notifications, "text": "Notifications"},
    {"icon": Icons.settings, "text": "Settings"}
  ];

  late final AnimationController _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
      reverseDuration: const Duration(milliseconds: 1000));

  late final Animation<double> _screenScale = Tween(begin: 1.0, end: 0.65)
      .animate(CurvedAnimation(
          parent: _menuController,
          curve: const Interval(0.0, 0.5,
              curve: Curves.slowMiddle))); //애니메이션이 실행되는 시간비율? 0% ~ 50%

  late final Animation<Offset> _screenOffset =
      Tween(begin: Offset.zero, end: const Offset(0.5, 0)).animate(
          CurvedAnimation(
              parent: _menuController,
              curve: const Interval(0.5, 1.0,
                  curve: Curves.decelerate))); //애니메이션이 실행되는 시간비율? 50% ~ 100%
  late final Animation<double> _closeButtonOpacity = Tween(begin: 0.0, end: 1.0)
      .animate(CurvedAnimation(
          parent: _menuController,
          curve: const Interval(0.5, 0.7, curve: Curves.easeInOutCubic)));
  late final List<Animation<Offset>> _profileSlide = [
    for (int i = 0; i < _menus.length; i++)
      Tween(begin: const Offset(-1, 0), end: Offset.zero).animate(
          CurvedAnimation(
              parent: _menuController,
              curve: Interval(0.3, 0.7 + (0.1 * i), curve: Curves.linear)))
  ];

  late final Animation<Offset> _logoutSlide =
      Tween(begin: const Offset(-1, 0), end: Offset.zero).animate(
          CurvedAnimation(
              parent: _menuController,
              curve: const Interval(0.8, 1.0, curve: Curves.linear)));

  void _openMenu() {
    _menuController.forward();
  }

  void _closeMenu() {
    _menuController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            leading: FadeTransition(
              opacity: _closeButtonOpacity,
              child: IconButton(
                onPressed: _closeMenu,
                icon: const Icon(Icons.close),
              ),
            ),
          ),
          body: Column(
            children: [
              for (int i = 0; i < _menus.length; i++) ...[
                const SizedBox(
                  height: 30,
                ),
                SlideTransition(
                  position: _profileSlide[i],
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        _menus[i]["icon"],
                        color: Colors.grey.shade200,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        _menus[i]["text"],
                        style: TextStyle(
                          color: Colors.grey.shade200,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                )
              ],
              const SizedBox(
                height: 400,
              ),
              SlideTransition(
                position: _logoutSlide,
                child: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Log Out",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        SlideTransition(
          position: _screenOffset,
          child: ScaleTransition(
            scale: _screenScale,
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text("MovieName"),
                actions: [
                  IconButton(
                      onPressed: _openMenu,
                      icon: const Icon(Icons.menu_outlined))
                ],
                elevation: 0,
              ),
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: "${widget.index}",
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        width: 250,
                        height: 250,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(35)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                  offset: Offset(0, 8))
                            ]),
                        child: Image.asset(
                          "assets/movies/${widget.index}.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    //progress
                    AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) => CustomPaint(
                              size: Size(size.width - 80, 5),
                              painter: ProgressBar(
                                  progressValue: _animationController.value),
                            )),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // ~/: 는 정수 나눗셈 연산자 5~/2 = 2 즉, 소수점 0.5를 버림
                            "${progressTime ~/ 60}:${(progressTime % 60).toInt().toString().padLeft(2, '0')}", // 분:초 형식으로 표시
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                          Text(
                            "- ${progressTime ~/ 60}:${(60 - progressTime % 60).toInt().toString().padLeft(2, '0')}", // 분:초 형식으로 표시
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "MovieName",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SlideTransition(
                      position: _marqueeTween,
                      child: const Text(
                        "MovieName-MovieName-MovieName-MovieName-MovieName-MovieName-MovieName",
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: _onTapIcon,
                      child: AnimatedIcon(
                        icon: AnimatedIcons.pause_play,
                        progress: _playPauseController,
                        size: 50,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onHorizontalDragStart: (_) => _toggleDragging(),
                      onHorizontalDragEnd: (_) => _toggleDragging(),
                      onHorizontalDragUpdate: _onvolumeDragUpdate,
                      child: AnimatedScale(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.bounceOut,
                        scale: _dragging ? 1.1 : 1,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: ValueListenableBuilder(
                            valueListenable: _volume,
                            builder: (context, value, child) => CustomPaint(
                              size: Size(size.width - 80, 50),
                              painter: VolumePaint(volume: value),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressBar extends CustomPainter {
  final double progressValue;
  ProgressBar({
    required this.progressValue,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final progress = size.width * progressValue;
    //background track
    final backgroundBarPrint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    final trackRRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      const Radius.circular(10),
    );
    canvas.drawRRect(trackRRect, backgroundBarPrint);

    //progress
    final progressPaint = Paint()
      ..color = Colors.grey.shade500
      ..style = PaintingStyle.fill;

    final progressRRect = RRect.fromLTRBR(
      0,
      0,
      progress,
      size.height,
      const Radius.circular(10),
    );
    canvas.drawRRect(progressRRect, progressPaint);

    //thumb
    canvas.drawCircle(
      Offset(progress, size.height / 2),
      7.5,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ProgressBar oldDelegate) {
    return oldDelegate.progressValue != progressValue;
  }
}

//볼륨 페이더 페인트
class VolumePaint extends CustomPainter {
  final double volume;
  VolumePaint({required this.volume});
  //.clamp: 값의 최대치 최소치를 고정함
  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = Colors.grey.shade300;
    final bgRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawRect(bgRect, bgPaint);

    final volumePaint = Paint()..color = Colors.grey.shade600;
    final volumeRect = Rect.fromLTWH(0, 0, volume, size.height);

    canvas.drawRect(volumeRect, volumePaint);
  }

  @override
  bool shouldRepaint(covariant VolumePaint oldDelegate) {
    return oldDelegate.volume != volume;
  }
}
