import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32.0),
              ),
            ),
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black),
          )),
      home: const HelloFlutterPage(),
    );
  }
}

class HelloFlutterPage extends StatefulWidget {
  const HelloFlutterPage({super.key});

  @override
  State<HelloFlutterPage> createState() => _HelloFlutterPageState();
}

class _HelloFlutterPageState extends State<HelloFlutterPage> {
  int _score = 0;

  void _incrementScore() {
    setState(() {
      _score++;
    });
  }

  void _decrementScore() {
    setState(() {
      _score--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {},
          ),
          title: const Text('Hello Flutter', style: TextStyle(fontSize: 25)),
          actions: [
            IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {},
            ),
          ],
        ),
        body:Center(child: SingleChildScrollView (child:   Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Your score', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            Text(
              '$_score',
              style: const TextStyle(fontSize: 35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _incrementScore,
                  child: const Text(
                    "+",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: _decrementScore,
                  child: const Text(
                    "-",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ],
        )    )));
  }
}
