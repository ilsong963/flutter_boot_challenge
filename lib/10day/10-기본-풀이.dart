import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      home: const NetflixSelectProfile(),
    );
  }
}

class NetflixSelectProfile extends StatelessWidget {
  const NetflixSelectProfile({super.key});

  @override
  Widget build(BuildContext context) {
    const profileWidth = 100.0;

    Widget buildTitle() {
      return Text(
        'Flutter Boot',
        style: TextStyle(
          fontFamily: GoogleFonts.lobster().fontFamily,
          fontSize: 24,
          color: Colors.red,
        ),
      );
    }

    Widget buildInfoText() {
      return const Text(
        'Select a profile to start the Flutter Boot.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      );
    }

    Widget buildProfile(String name, Color color) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Container(
              width: profileWidth,
              height: profileWidth,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [color, color.withOpacity(0.7)],
                ),
              ),
              child: CustomPaint(
                painter: AvatarPainter(),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style:
            TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
          )
        ],
      );
    }

    Widget buildAddProfile() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: profileWidth,
            height: profileWidth,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border:
                Border.all(width: 1, color: Colors.grey.withOpacity(0.7))),
            alignment: Alignment.center,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 48,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Add profile',
            style:
            TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 12),
            buildTitle(),
            Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      buildInfoText(),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildProfile(
                              'Honlee', const Color.fromARGB(255, 0, 140, 255)),
                          const SizedBox(width: 24),
                          buildProfile(
                              'Kilee', const Color.fromARGB(255, 240, 219, 30)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildProfile('Flutter Boot',
                              const Color.fromARGB(255, 255, 17, 0)),
                          const SizedBox(width: 24),
                          buildAddProfile(),
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class AvatarPainter extends CustomPainter {
  final double eyeRadius;
  final double lipThickness;

  AvatarPainter({
    super.repaint,
    this.eyeRadius = 7,
    this.lipThickness = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const eyeWidthDivision = 5;
    const eyeHeightDivision = 3;

    final eyePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final lipPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = lipThickness;

    canvas.drawCircle(
      Offset(size.width / eyeWidthDivision, size.height / eyeHeightDivision),
      eyeRadius,
      eyePaint,
    );

    canvas.drawCircle(
      Offset(size.width * (eyeWidthDivision - 1) / eyeWidthDivision,
          size.height / eyeHeightDivision),
      eyeRadius,
      eyePaint,
    );

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width * 10 / 17, -size.height * 1 / 9),
          radius: 70),
      pi / 4 + pi / 8,
      pi / 4,
      false,
      lipPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
