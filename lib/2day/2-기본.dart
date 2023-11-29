import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const ScorePage(),
    );
  }
}

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  State<ScorePage> createState() => _ScorePage();
}

class _ScorePage extends State<ScorePage> with TickerProviderStateMixin {
  late AnimationController controller;
  int score = 0;

  @override
  void initState() {
    controller = AnimationController(vsync: this)
      ..addListener(() {
        setState(() {});
      })
      ..duration = const Duration(milliseconds: 700);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RotatedBox(
              quarterTurns: -1,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                width: 300,
                height: 40,
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                  child: LinearProgressIndicator(
                      borderRadius:
                          const BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
                      value: controller.value,
                      backgroundColor: Colors.black87),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                controller.value += 0.3;
                if (controller.value >= 1) {
                  score++;
                }
                controller.reverse().then((value) {
                  setState(() {
                    score = 0;
                  });
                });
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
        body: Center(
            child: Column(children: [
          const Text(
            'Your score',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 10
          ),
          Text('$score', style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold))
        ])));
  }
}
