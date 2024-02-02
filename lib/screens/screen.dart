import 'package:flutter/material.dart';

class CanvasScreen extends StatefulWidget {
  static String routeName = "canvus";
  static String routeURL = "canvus";
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Canvas"),
      ),
      body: Center(
        child: CustomPaint(painter: Painter(), size: const Size(400, 400)),
      ),
    );
  }
}

class Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    //사각형
    final rect = Rect.fromCenter(
        center: center, width: 400, height: 200); //사각형 정보를 갖는 객체
    canvas.drawRect(
        rect, //Rect 사각형 객체
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5);

    //원
    canvas.drawCircle(
        Offset((size.width / 2) / 3, (size.height / 2)), //중심점 위치
        50, //반지름 길이
        Paint()
          ..color = Colors.blue //색상
          ..style = PaintingStyle.stroke //비어있는 스타일
          ..strokeWidth = 10); //두께

    //삼각형 (점을 잇는 직선으로 그리기)
    canvas.drawPath(
        Path()
          ..moveTo(size.width / 2.1, size.height / 2.6) //첫 시작점
          ..lineTo(size.width / 2 / 1.4, size.height / 1.6) //다음 점 위치
          ..lineTo(size.width / 1.65, size.height / 1.6) //다음 점 위치
          ..lineTo(size.width / 2.1, size.height / 2.6) //다음 점 위치
          ..close(),
        //다음 점이 없음을 알리고 moveTo(시작점)을 이어줌
        Paint()
          ..color = Colors.pinkAccent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10);

    //사각형
    canvas.drawRect(
        Rect.fromLTRB(size.width / 1.4, size.height / 2.6, size.width / 1.05,
            size.height / 1.6),
        Paint()
          ..color = Colors.orange //도형 색상
          ..style = PaintingStyle.stroke //도형 색 채우기 없음
          ..strokeWidth = 10); //테두리 넓이

    //canvas.drawLine();  직선
    //canvas.drawRect(); 사각형
    //canvas.drawPath(); 경로로 그리기
    //canvas.drawCircle();  원
    //canvas.drawArc();  곡선
    //canvas.drawParagraph(); //텍스트 문단
    //canvas.drawImage(); 이미지
    //문자 그리기는 TextPainter 사용
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
