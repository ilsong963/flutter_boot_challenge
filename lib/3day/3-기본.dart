import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBoot',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SlackAvatar(),
    );
  }
}

class SlackAvatar extends StatefulWidget {
  const SlackAvatar({super.key});

  @override
  State<SlackAvatar> createState() => _SlackAvatarState();
}

class _SlackAvatarState extends State<SlackAvatar> {
  double headRadius = 45.0;
  double bodyHeight = 120.0;
  Color backgroundColor = const Color.fromARGB(255, 17, 113, 192);

  Widget _buildAvatar({
    required double size,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: CustomPaint(
        painter: AvatarPainter(
          headRadius: headRadius,
          bodyHeight: bodyHeight,
        ),
      ),
    );
  }

  void onHeadRadiusChange(double value) {
    setState(() => headRadius = value);
  }

  void onBodyHeightChange(double value) {
    setState(() => bodyHeight = value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAvatar(size: 200),
            const SizedBox(height: 32),
            Slider(
              min: 35,
              max: 55,
              value: headRadius,
              onChanged: onHeadRadiusChange,
            ),
            const SizedBox(height: 16),
            Slider(
              min: 105,
              max: 120,
              value: bodyHeight,
              onChanged: onBodyHeightChange,
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarPainter extends CustomPainter {
  final double headRadius;
  final double bodyHeight;

  AvatarPainter({
    super.repaint,
    required this.headRadius,
    required this.bodyHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, size.height * 2 / 5), headRadius, paint);

    canvas.drawArc(
      Rect.fromCenter(
          center: Offset(size.width / 3, size.height),
          width: bodyHeight,
          height: bodyHeight),
      pi,
      pi,
      true,
      paint,
    );

    canvas.drawArc(
      Rect.fromCenter(
          center: Offset(size.width * 2 / 3, size.height),
          width: bodyHeight,
          height: bodyHeight),
      pi,
      pi,
      true,
      paint,
    );

    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height - bodyHeight / 4),
            width: bodyHeight / 2,
            height: bodyHeight / 2),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
