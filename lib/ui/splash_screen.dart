import 'dart:math';
import 'package:flutter/material.dart';
import 'package:orm_risk_assessment/ui/landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const LandingPage(),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 450),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080838),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          painter: _SplashRadarPainter(sweepFraction: _controller.value),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _SplashRadarPainter extends CustomPainter {
  final double sweepFraction;

  static const _ringColor = Color(0xFF111154);
  static const _sweepColor = Color(0xFF4169E1);
  static const _blipColor = Color(0xFF6495ED);
  static const _crossColor = Color(0xFF191970);
  static const _bgColor = Color(0xFF080838);

  _SplashRadarPainter({required this.sweepFraction});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width * 0.5;
    final cy = size.height * 0.5;
    final maxR = min(size.width, size.height) * 0.4;

    final sweepAngle = sweepFraction * 2 * pi - pi / 2;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = _bgColor,
    );

    final crossPaint = Paint()
      ..color = _crossColor
      ..strokeWidth = 0.5;
    canvas.drawLine(Offset(cx, cy - maxR), Offset(cx, cy + maxR), crossPaint);
    canvas.drawLine(Offset(cx - maxR, cy), Offset(cx + maxR, cy), crossPaint);
    canvas.drawLine(
        Offset(cx - maxR * 0.71, cy - maxR * 0.71),
        Offset(cx + maxR * 0.71, cy + maxR * 0.71),
        crossPaint);
    canvas.drawLine(
        Offset(cx + maxR * 0.71, cy - maxR * 0.71),
        Offset(cx - maxR * 0.71, cy + maxR * 0.71),
        crossPaint);

    final ringPaint = Paint()
      ..color = _ringColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(Offset(cx, cy), maxR * i / 4, ringPaint);
    }

    const trailAngle = pi * 0.9;
    final trailRect = Rect.fromCircle(center: Offset(cx, cy), radius: maxR);

    for (int i = 0; i < 40; i++) {
      final t = i / 40;
      final alpha = (1.0 - t) * 0.45;
      final trailPaint = Paint()
        ..color = _sweepColor.withOpacity(alpha)
        ..style = PaintingStyle.fill;
      final startA = sweepAngle - trailAngle * (i + 1) / 40;
      final sweepA = trailAngle / 40;
      final path = Path()
        ..moveTo(cx, cy)
        ..arcTo(trailRect, startA, sweepA, false)
        ..close();
      canvas.drawPath(path, trailPaint);
    }

    final linePaint = Paint()
      ..color = _sweepColor.withOpacity(0.95)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(cx, cy),
      Offset(cx + maxR * cos(sweepAngle), cy + maxR * sin(sweepAngle)),
      linePaint,
    );

    final glowPaint = Paint()
      ..color = _sweepColor.withOpacity(0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(
      Offset(cx + maxR * cos(sweepAngle), cy + maxR * sin(sweepAngle)),
      5,
      glowPaint,
    );

    canvas.drawCircle(
      Offset(cx, cy), 3.5,
      Paint()..color = _sweepColor.withOpacity(0.9),
    );
    canvas.drawCircle(
      Offset(cx, cy), 7,
      Paint()
        ..color = _sweepColor.withOpacity(0.2)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    final tp = TextPainter(textDirection: TextDirection.ltr);
    for (int i = 1; i <= 4; i++) {
      tp.text = TextSpan(
        text: '${i * 25}',
        style: const TextStyle(
          color: Color(0xFF111154),
          fontSize: 8,
          fontFamily: 'Courier New',
        ),
      );
      tp.layout();
      tp.paint(canvas, Offset(cx + 3, cy - maxR * i / 4 - 10));
    }

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'ORM',
        style: TextStyle(
          color: const Color(0xFF4169E1),
          fontSize: 36,
          fontWeight: FontWeight.w900,
          fontFamily: 'Courier New',
          letterSpacing: 8,
          shadows: const [
            Shadow(color: Colors.black, blurRadius: 4),
            Shadow(color: Color(0xFF4169E1), blurRadius: 20),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(cx - textPainter.width / 2, cy + maxR + 30),
    );
  }

  @override
  bool shouldRepaint(_SplashRadarPainter old) =>
      old.sweepFraction != sweepFraction;
}
