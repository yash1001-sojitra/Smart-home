import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

const indicatorRadius = 20.0;

class CircleSliderPainter extends CustomPainter {
  final double widgetSize;
  final double value;

  CircleSliderPainter({required this.widgetSize, required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    _drawSkeleton(canvas: canvas);

    _drawValueAndIndicators(canvas: canvas);
  }

  void _drawSkeleton({required Canvas canvas}) {
    const markSize = 4.0;

    final markArcPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = markSize;

    final externalArcPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = indicatorRadius * 2;

    final middleArc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = indicatorRadius
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(widgetSize, widgetSize),
        [
          const ui.Color.fromARGB(255, 225, 245, 255),
          const ui.Color.fromARGB(255, 144, 196, 241),
        ],
      );

    final backgroundOverlayPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(
        Offset.zero,
        Offset(widgetSize, widgetSize),
        [
          const Color(0XFFFFFEFF),
          const Color(0XFFFFEEED),
        ],
      );

    canvas.drawArc(
      Offset.zero & Size(widgetSize, widgetSize),
      0,
      math.pi * 2,
      false,
      externalArcPaint,
    );

    canvas.drawArc(
      const Offset(30, 30) & Size(widgetSize - 60, widgetSize - 60),
      0,
      math.pi * 2,
      false,
      middleArc,
    );

    canvas.drawArc(
      const Offset(-18, -18) & Size(widgetSize + 36, widgetSize + 36),
      0,
      math.pi * 2,
      false,
      markArcPaint,
    );

    canvas.drawCircle(Offset(widgetSize / 2, widgetSize / 2),
        widgetSize / 2 - indicatorRadius * 2, backgroundOverlayPaint);
  }

  void _drawValueAndIndicators({required Canvas canvas}) {
    final path = Path();

    path.addArc(
      Rect.fromLTWH(0, 0, widgetSize, widgetSize),
      -math.pi / 2,
      value,
    );

    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = indicatorRadius * 1
        ..shader = ui.Gradient.linear(
          Offset(widgetSize * .25, widgetSize),
          Offset(widgetSize, widgetSize * .25),
          [
            const Color.fromARGB(255, 89, 177, 244),
            const Color.fromARGB(255, 6, 204, 239),
          ],
        ),
    );

    final metrics = path.computeMetrics().toList();

    if (metrics.isEmpty) {
      _drawIndicatorCircle(
        canvas: canvas,
        position: Offset(widgetSize / 2 - indicatorRadius / 2, 0),
      );
      return;
    }

    final tangent = metrics.first.getTangentForOffset(metrics.first.length);

    _drawIndicatorCircle(
      canvas: canvas,
      position: tangent!.position,
    );
  }

  void _drawIndicatorCircle({
    required Canvas canvas,
    required Offset position,
  }) {
    final whiteCirclePainter = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);

    canvas.drawCircle(position, indicatorRadius * .75, shadowPaint);

    canvas.drawCircle(position, indicatorRadius, whiteCirclePainter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
