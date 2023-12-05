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
      home: const ButtonPage(),
    );
  }
}

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _DialogPage();
}

class _DialogPage extends State<ButtonPage> with SingleTickerProviderStateMixin {
  bool isClicked = false;
  late AnimationController _controller;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _topAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
        tween: Tween(begin: Alignment.topLeft, end: Alignment.topRight),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween(begin: Alignment.topRight, end: Alignment.bottomRight),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween(begin: Alignment.bottomRight, end: Alignment.bottomLeft),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween(begin: Alignment.bottomLeft, end: Alignment.topLeft),
        weight: 1,
      ),
    ]).animate(_controller);
    _bottomAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem<Alignment>(
        tween: Tween(begin: Alignment.bottomRight, end: Alignment.bottomLeft),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween(begin: Alignment.bottomLeft, end: Alignment.topLeft),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween(begin: Alignment.topLeft, end: Alignment.topRight),
        weight: 1,
      ),
      TweenSequenceItem<Alignment>(
        tween: Tween(begin: Alignment.topRight, end: Alignment.bottomRight),
        weight: 1,
      ),
    ]).animate(_controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: GestureDetector(
                onTap: () {
                  setState(() => isClicked =true);
                  _controller.repeat(period: const Duration(seconds: 10));
                },
                child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, _) {
                      return Container(
                          padding: const EdgeInsets.all(4),
                          decoration: isClicked
                              ? BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.white, Colors.red],
                                      begin: _topAlignmentAnimation.value,
                                      end: _bottomAlignmentAnimation.value),
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.red, spreadRadius: 1, blurRadius: 7, blurStyle: BlurStyle.normal),
                                  ],
                                )
                              : null,
                          child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text("Flutter Boot\nClick me\u{1F60E}",
                                  style: TextStyle(
                                      shadows: isClicked
                                          ? const [
                                              Shadow(
                                                color: Colors.red,
                                                blurRadius: 5,
                                                offset: Offset(1, 1),
                                              ),
                                              Shadow(
                                                color: Colors.red,
                                                blurRadius: 5,
                                                offset: Offset(-1, -1),
                                              ),
                                              Shadow(
                                                color: Colors.red,
                                                blurRadius: 5,
                                                offset: Offset(1, -1),
                                              ),
                                              Shadow(
                                                color: Colors.red,
                                                blurRadius: 5,
                                                offset: Offset(-1, 1),
                                              ),
                                            ]
                                          : null,
                                      fontFamily: GoogleFonts.lobster().fontFamily,
                                      fontSize: 25,
                                      color: Colors.white),
                                  textAlign: TextAlign.center)));
                    }))));
  }
}
