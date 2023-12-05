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
      home: const DialogPage(),
    );
  }
}

class DialogPage extends StatefulWidget {
  const DialogPage({super.key});

  @override
  State<DialogPage> createState() => _DialogPage();
}

class _DialogPage extends State<DialogPage> {
  int point = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(child:  Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Your Point : $point", style: const TextStyle(fontWeight: FontWeight.bold, fontSize:20 )),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {
              List<int> points = [
                Random().nextInt(100) + 1,
                Random().nextInt(100) + 1,
                Random().nextInt(100) + 1
              ];
              showDialog(
                  context: context,
                  builder: (context) {

                    return AlertDialog(
                      title: const Text("Choose your next point!"),
                      content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Choose one of the points below!"),
                          Text("If you don't make a selection, your current score will be retained.")
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffede7f6), elevation: 0),
                            onPressed: () {
                              Navigator.pop(context, points[0]);
                            },
                            child: Text("${points[0]}")),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffede7f6), elevation: 0),
                            onPressed: () {
                              Navigator.pop(context, points[1]);
                            },
                            child: Text("${points[1]}")),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffede7f6), elevation: 0),
                            onPressed: () {
                              Navigator.pop(context, points[2]);
                            },
                            child: Text("${points[2]}")),
                      ],
                    );
                  }).then((value) => setState(() {
                    if (value != null) point = value;
                  }));
            },
            child: const Text("I want more points!", style: TextStyle(fontWeight: FontWeight.bold))),
      ],
    )));
  }
}
