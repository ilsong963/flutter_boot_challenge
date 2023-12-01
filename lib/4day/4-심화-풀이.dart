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
      home: const CatchGreen(),
    );
  }
}

class CatchGreen extends StatefulWidget {
  const CatchGreen({super.key});

  @override
  State<CatchGreen> createState() => _CatchGreenState();
}

class _CatchGreenState extends State<CatchGreen> {
  bool readyToStart = true;
  Offset? randomScaledOffset; // 0 ~ 1.0
  TicTokTimerState timerState = TicTokTimerState.reset;

  @override
  void dispose() {
    super.dispose();
  }

  void startMakeBlockTimer() {
    Future.delayed(
      Duration(milliseconds: Random().nextInt(500) + 200),
          () {
        setState(() {
          timerState = TicTokTimerState.start;
          randomScaledOffset =
              Offset(Random().nextDouble(), Random().nextDouble());
        });
      },
    );
  }

  void gameStart() {
    setState(() {
      timerState = TicTokTimerState.reset;
      readyToStart = false;
    });
    startMakeBlockTimer();
  }

  Widget makeGreen() {
    const boxSize = 50.0;

    Widget buildGreen(BoxConstraints constraints) {
      if (randomScaledOffset == null) return const SizedBox();
      return Positioned(
        left: randomScaledOffset!.dx * (constraints.maxWidth - boxSize),
        top: randomScaledOffset!.dy * (constraints.maxHeight - boxSize),
        child: GestureDetector(
          onTap: () {
            setState(() {
              readyToStart = true;
              timerState = TicTokTimerState.stop;
              randomScaledOffset = null;
            });
          },
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(300))),
            width: boxSize,
            height: boxSize,
          ),
        ),
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Container(color: Colors.black),
          buildGreen(constraints),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catch green game'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const Row(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: readyToStart ? gameStart : null,
              child: const Text('Start!'),
            ),
            const SizedBox(height: 12),
            TicTokTimer(state: timerState),
            Expanded(
              child: makeGreen(),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

enum TicTokTimerState {
  start,
  stop,
  reset,
}

class TicTokTimer extends StatefulWidget {
  final TicTokTimerState state;

  const TicTokTimer({super.key, required this.state});

  @override
  State<TicTokTimer> createState() => _TicTokTimerState();
}

class _TicTokTimerState extends State<TicTokTimer> {
  Duration delay = Duration.zero;
  Timer? timer;

  @override
  void didUpdateWidget(covariant TicTokTimer oldWidget) {
    if (widget.state != oldWidget.state) {
      switch (widget.state) {
        case TicTokTimerState.start:
          startTimer();
          break;
        case TicTokTimerState.reset:
          resetTimer();
          break;
        case TicTokTimerState.stop:
          stopTimer();
          break;
        default:
          throw 'invalid state!';
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  void startTimer() {
    timer?.cancel();
    delay = Duration.zero;
    timer = Timer.periodic(const Duration(milliseconds: 33), (timer) {
      setState(() => delay = delay + const Duration(milliseconds: 33));
    });
  }

  void resetTimer() {
    timer?.cancel();
    setState(() => delay = Duration.zero);
  }

  void stopTimer() {
    timer?.cancel();
  }

  String getTimeStr() {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(delay.inMilliseconds);
    return '${dateTime.minute}:${dateTime.second}.${dateTime.millisecond}';
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(getTimeStr());
  }
}
