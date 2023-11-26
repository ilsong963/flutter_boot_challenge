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
      home: const HelloFlutter(),
    );
  }
}


class HelloFlutter extends StatefulWidget {
  const HelloFlutter({super.key});

  @override
  State<HelloFlutter> createState() => _HelloFlutterState();
}

class _HelloFlutterState extends State<HelloFlutter> {
  int score = 0;

  void addValue(int value) {
    setState(() => score += value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Flutter'),
        centerTitle: true,
        leading: const Icon(Icons.home),
        actions: const [
          SizedBox(height: 56, width: 56, child: Icon(Icons.help))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Your score',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            score.toString(),
            style:
            TextStyle(fontSize: 32, color: Colors.black.withOpacity(0.9)),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () => addValue(1),
                child: const Text('+'),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: () => addValue(-1),
                child: const Text('-'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
