import 'dart:async';
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
      home: const MyFancyButton(),
    );
  }
}


class MyFancyButton extends StatelessWidget {
  const MyFancyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FancyButton(),
      ),
    );
  }
}

class FancyButton extends StatefulWidget {
  const FancyButton({super.key});

  @override
  State<FancyButton> createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton> {
  final shadowColor = Colors.red;
  Timer? timer;
  double degree = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startAnimation() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      setState(() {
        degree = degree + 0.1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          gradient: timer == null
              ? null
              : LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: const [
              Colors.white,
              Colors.red,
            ],
            transform: GradientRotation(degree),
          ),
          boxShadow: timer == null
              ? null
              : List.generate(
            3,
                (idx) => BoxShadow(
              spreadRadius: 0,
              color: shadowColor,
              blurRadius: (idx + 1) * 3,
              blurStyle: BlurStyle.outer,
            ),
          ).toList()),
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        padding: const EdgeInsets.all(16),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: startAnimation,
          // child: Text(
          //   'Flutter Boot\nClick me 😎',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     fontFamily: GoogleFonts.lobster().fontFamily,
          //     color: Colors.white,
          //     shadows: timer == null
          //         ? null
          //         : List.generate(
          //         3,
          //             (idx) => Shadow(
          //             color: shadowColor,
          //             blurRadius: 3 * (idx + 1))).toList(),
          //     fontSize: 24,
          //   ),
          // ),
        ),
      ),
    );
  }
}
