import 'dart:async';
import 'dart:math';
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
      home: const MyHighScore(),
    );
  }
}

class MyHighScore extends StatefulWidget {
  const MyHighScore({super.key});

  @override
  State<MyHighScore> createState() => _MyHighScoreState();
}

class _MyHighScoreState extends State<MyHighScore> {
  late final sc = Theme.of(context).colorScheme;
  int score = 0;
  Duration duration = const Duration(milliseconds: 100);
  double gauge = 0;
  late final maxGauge = (MediaQuery.of(context).size.height / 2) - 40;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      final nextGuage = max(gauge - ((maxGauge / 100) * 1.5), 0.05);

      setState(() => gauge = nextGuage);
      if (nextGuage < 1) setState(() => score = 0);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void plusButtonHandler() {
    final nextGauge = min(gauge + (maxGauge / 3), maxGauge);
    if (nextGauge > maxGauge * 0.9) setState(() => score = score + 1);
    setState(() => gauge = nextGauge);
  }

  Widget _buildButton() {
    return FloatingActionButton(
      onPressed: plusButtonHandler,
      child: const Text(
        '+',
        style: TextStyle(fontSize: 30),
      ),
    );
  }

  Widget _buildProgressBar() {
    const borderRadius = BorderRadius.only(
        topLeft: Radius.circular(16), topRight: Radius.circular(16));
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: sc.onBackground,
      ),
      height: maxGauge,
      width: 40,
      alignment: Alignment.bottomCenter,
      child: AnimatedSize(
        alignment: Alignment.bottomCenter,
        duration: duration,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: sc.primary,
          ),
          width: 40,
          height: gauge,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              const SizedBox(height: 32),
              const Text(
                'Your score',
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(height: 16),
              Text(
                score.toString(),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Positioned(
              right: 12,
              bottom: 12,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildProgressBar(),
                  const SizedBox(height: 8),
                  _buildButton(),
                ],
              )),
        ],
      ),
    );
  }
}
