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
      home: const ShootingStarPage(),
    );
  }
}

class ShootingStarPage extends StatefulWidget {
  const ShootingStarPage({super.key});

  @override
  State<ShootingStarPage> createState() => _ShootingStarPageState();
}

class _ShootingStarPageState extends State<ShootingStarPage> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  List<Widget> stars = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_scaleController);

    _scaleController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ElevatedButton(
          onPressed: () {
            setState(() {
              stars.add(Star(
                onEnd: () {
                  setState(
                    () {
                      count++;
                      _scaleController.forward().then((value) => _scaleController.reverse());
                    },
                  );
                },
              ));
            });
          },
          child: const Text("Shoot Star!"),
        ),
        appBar: AppBar(),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("No matter what widgets are in the middle"),
                          Text("animation should not be obscured.")
                        ],
                      ),
                    )),
                  ],
                ),
                ...stars,
                ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                      child: Center(child: Text('$count', style: const TextStyle(color: Colors.white))),
                    ))
              ],
            )));
  }
}

class Star extends StatefulWidget {
  final void Function() onEnd;

  const Star({super.key, required this.onEnd});

  @override
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _positionController;
  late Animation<double> _scaleAnimation;
  late Animation<Alignment> _positionAnimation;

  @override
  void initState() {
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _positionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 2).animate(_scaleController);

    _positionAnimation = Tween<Alignment>(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
    ).animate(_positionController);

    _scaleController.repeat(reverse: true);
    _positionController.forward().then((value) {
      widget.onEnd();
      dispose();
    });
    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlignTransition(
        alignment: _positionAnimation,
        child: ScaleTransition(
            scale: _scaleAnimation,
            child: const Icon(
              Icons.star,
              size: 50,
              color: Colors.blueAccent,
            )));
  }
}
