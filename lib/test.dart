import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Appbar"),
        ),
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.center,
          color: Color(0xff2d2f41),
          child: ClockView(),
        ));
  }
}

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 300,
        child: Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            painter: MyCirclePainter(),
          ),
        ));
  }
}

class MyCirclePainter extends CustomPainter {
  var dateTime = DateTime.now();
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint()..color = Color(0xff444974);

    var outlineBrush = Paint()
      ..color = Color(0xffeaecff)
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;

    var centerFillBrush = Paint()..color = Color(0xffeaecff);

    var secHandBrush = Paint()
      ..color = Colors.orange[400]
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    var minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.lightBlue, Colors.pink])
          .createShader(Rect.fromCircle(radius: radius, center: center))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;

    var hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.red, Colors.green])
          .createShader(Rect.fromCircle(radius: radius, center: center))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    var hourHandY = centerX +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    var minHandY = centerX + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    var secHandY = centerX + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);

    var dashBrush = Paint()
      ..color = Colors.white
      ..strokeWidth = 4;

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;
    for (double i = 0; i < 360; i += 30) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
