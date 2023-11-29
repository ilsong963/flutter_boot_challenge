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
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _HelloDraggablePage();
}

const double profileWidth = 200.0;
const double profileHeight = 200.0;

class _HelloDraggablePage extends State<ProfilePage> {
  double headSize = 10.0;
  double bodySize = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Stack(
              children: [
                Container(
                    width: profileWidth,
                    height: profileHeight,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
                Positioned(
                  top: -30 + profileHeight / 2 - (100 + headSize) / 2,
                  left: profileWidth / 2 - (100 + headSize) / 2,
                  child: Container(
                      width: 100 + headSize,
                      height: 100 + headSize,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      )),
                ),
                Positioned(
                  top: 120 + profileWidth / 2 - (150 + bodySize) / 2,
                  left: profileHeight / 2 - (150 + bodySize) / 2,
                  child: Container(
                      width: 150 + bodySize,
                      height: 150 + bodySize,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                      )),
                )
              ],
            )),
            Slider(
              value: headSize,
              min: 0.0,
              max: 20.0,
              onChanged: (double newValue) {
                setState(
                  () {
                    headSize = newValue;
                  },
                );
              },
            ),
            Slider(
              value: bodySize,
              min: 0.0,
              max: 20.0,
              onChanged: (double newValue) {
                setState(
                  () {
                    bodySize = newValue;
                  },
                );
              },
            ),
          ],
        ));
  }
}
