import 'dart:math';
import 'package:flutter/material.dart';

class RadialProgress extends StatefulWidget {
  final double porcent;
  final Color colorPrimary;
  final Color colorSecundary;
  final double widthPrimary;
  final double widthSecundary;

  RadialProgress({
    @required this.porcent,
    @required this.colorPrimary,
    @required this.colorSecundary,
    this.widthPrimary = 10.0,
    this.widthSecundary = 4.0,
  });

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  double porcentOld;

  @override
  void initState() {
    porcentOld = widget.porcent;

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    final diferenceAnimate = widget.porcent - porcentOld;
    porcentOld = widget.porcent;

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Container(
          padding: EdgeInsets.all(10.0),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _MyRadialProgress(
                colorPrimary: widget.colorPrimary,
                colorSecundary: widget.colorSecundary,
                widthPrimary: widget.widthPrimary,
                widthSecundary: widget.widthSecundary,
                porcentaje: (widget.porcent - diferenceAnimate) +
                    (diferenceAnimate * controller.value)),
          ),
        );
      },
    );
  }
}

class _MyRadialProgress extends CustomPainter {
  double porcentaje = 20;
  final Color colorPrimary;
  final Color colorSecundary;
  final double widthPrimary;
  final double widthSecundary;

  _MyRadialProgress({
    this.porcentaje,
    this.colorPrimary = Colors.blue,
    this.colorSecundary = Colors.grey,
    this.widthPrimary = 10.0,
    this.widthSecundary = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    /* final Rect rect = Rect.fromCircle(
        center: Offset(
          0,
          0,
        ),
        radius: 180.0);

     final Gradient gradient = new LinearGradient(
        colors: [colorPrimary, Colors.blue, colorPrimary]); */

    // Circle
    final paint = new Paint()
      ..strokeWidth = widthSecundary
      ..color = colorSecundary
      ..style = PaintingStyle.stroke;

    final Offset center = new Offset(size.width * 0.5, size.height / 2);
    final double radius = min(size.width * 0.5, size.height * 0.5);
    canvas.drawCircle(center, radius, paint);

    final paintArco = new Paint()
      ..strokeWidth = widthPrimary
      ..color = colorPrimary
      // ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Parte que se deberá ir llenando
    double arcAngle = 2 * pi * (porcentaje / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, paintArco);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
