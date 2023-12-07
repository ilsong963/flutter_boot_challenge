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
      home: HeartPage(),
    );
  }
}

class HeartPage extends StatefulWidget {
  const HeartPage({super.key});

  @override
  State<HeartPage> createState() => _HeartPageState();
}

class _HeartPageState extends State<HeartPage> {
  List<Widget> stars = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        floatingActionButton: GestureDetector(
            onTap: () {
              setState(() {
                stars.insert(0, Balloon());
              });
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 2),
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.5)),
              child: Icon(Icons.favorite, size: 35, color: Colors.red),
            )),
        body: Stack(children: [const Placeholder(), ...stars]));
  }
}

class Balloon extends StatefulWidget {
  const Balloon({super.key});

  @override
  State<Balloon> createState() => _BalloonState();
}

class _BalloonState extends State<Balloon> with TickerProviderStateMixin {
  late AnimationController _positionController;
  late Animation<Alignment> _positionAnimation;
  Random random = Random();
  Color? color1;
  Color? color2;
  int? size;

  @override
  void initState() {
    color1 = Colors.primaries[random.nextInt(Colors.primaries.length)][random.nextInt(9) * 100];
    color2 = Colors.primaries[random.nextInt(Colors.primaries.length)][random.nextInt(9) * 100];
    size = random.nextInt(9)+1;

    _positionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (random.nextInt(9) + 1) * 1000),
    );

    _positionAnimation = Tween<Alignment>(
      begin: Alignment.bottomRight,
      end: Alignment.topRight,
    ).animate(_positionController);

    _positionController.forward().then((value) {
      Future.delayed(const Duration(seconds: 5), () {
        dispose();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlignTransition(
        alignment: _positionAnimation,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [color1!, color2!],
            ).createShader(bounds);
          },
          child:  Icon(
            Icons.favorite,
            color: Colors.white,
            size: 50.0 +size!,
          ),
        ));
  }
}
