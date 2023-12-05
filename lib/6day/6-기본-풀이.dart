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
      home: const HelloDialog(),
    );
  }
}


class HelloDialog extends StatefulWidget {
  const HelloDialog({super.key});

  @override
  State<HelloDialog> createState() => _HelloDialogState();
}

class _HelloDialogState extends State<HelloDialog> {
  int point = 0;

  Widget _buildPoint() {
    return Text(
      'Your point : $point',
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildGetScoreButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => showPointDialog(context),
      child: const Text(
        'I want more points!',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Future<void> showPointDialog(BuildContext context) async {
    final first = Random().nextInt(100);
    final second = Random().nextInt(100);
    final third = Random().nextInt(100);

    final ret = await showDialog<int>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Choose your next point!'),
            content: const Text(
                "Choose one of the points below!\nIf you don't make a selection, your current score will be retained."),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(first),
                  child: Text(first.toString())),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(second),
                  child: Text(second.toString())),
              TextButton(
                  onPressed: () => Navigator.of(context).pop(third),
                  child: Text(third.toString())),
            ],
          );
        });
    if (ret != null) {
      setState(() {
        point = ret;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildPoint(),
            const SizedBox(height: 24),
            _buildGetScoreButton(context),
          ],
        ),
      ),
    );
  }
}
