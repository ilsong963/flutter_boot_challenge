import 'dart:async';
import 'package:flutter/material.dart';

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
      home: const HelloAnimation(),
    );
  }
}

class HelloAnimation extends StatelessWidget {
  const HelloAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(child: RollingStar(duration: Duration(milliseconds: 50))),
        ],
      ),
    );
  }
}

class RollingStar extends StatefulWidget {
  final Duration duration;
  const RollingStar({super.key, required this.duration});

  @override
  State<RollingStar> createState() => _RollingStarState();
}

class _RollingStarState extends State<RollingStar> {
  final startSize = 50.0;

  double turn = 0.0;
  late double left = -startSize;
  double top = 0.0;
  Timer? timer;
  late Duration animationDuration = widget.duration;
  late final size = MediaQuery.of(context).size;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(widget.duration, (_) {
      final nextTurn = turn + 0.05;
      double nextLeft = left + 7;
      double nextTop = top;
      Duration nextDuration = widget.duration;
      if (nextLeft > size.width + startSize) {
        nextLeft = -startSize;
        nextTop = nextTop + startSize;
        nextDuration = Duration.zero;
        if (nextTop + startSize > size.height) {
          nextTop = 0;
        }
      }
      setState(() {
        turn = nextTurn;
        left = nextLeft;
        top = nextTop;
        animationDuration = nextDuration;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            color: Colors.black,
          ),
          AnimatedPositioned(
            left: left,
            top: top,
            duration: animationDuration,
            child: AnimatedRotation(
              turns: turn,
              duration: widget.duration,
              child: Icon(
                Icons.star,
                size: startSize,
                color: Colors.yellowAccent,
              ),
            ),
          )
        ],
      );
    });
  }
}
