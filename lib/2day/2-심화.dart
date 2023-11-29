import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StarAnimationPage(),
    );
  }
}

class StarAnimationPage extends StatefulWidget {
  const StarAnimationPage({super.key});

  @override
  State<StarAnimationPage> createState() => _HelloDraggablePage();
}

class _HelloDraggablePage extends State<StarAnimationPage> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Tween<Alignment> alignmentTween;
  // late Tween<double> rotateTween;

  late Animation<Alignment> alignmentAnimation;
  // late Animation<double> rotateAnimation;

  @override
  void initState() {
    controller = AnimationController(duration:  Duration(seconds:(MediaQuery.of(context).size.width/5*100).toInt()), vsync: this)
      ..repeat(reverse: false);
    alignmentTween = Tween(begin: Alignment.topLeft, end: Alignment.topRight);
    // rotateTween = Tween(begin: 0.0, end: 1.0);
    alignmentAnimation = controller.drive(alignmentTween);
    // rotateAnimation = controller.drive(rotateTween);
    controller.forward();
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
        backgroundColor: Colors.white,
        body: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              return
                Align(
                    alignment: alignmentAnimation.value, // <<< bind align animation
                    child:
                    //
                    // Transform.rotate(
                    //     angle: rotateAnimation.value,
                    //     child:
                    const Icon(Icons.star, size: 100, color: Colors.yellow)
                  // )
                );
            })

    );
  }
}
