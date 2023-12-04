
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

class _ShootingStarPageState extends State<ShootingStarPage> {
  final destKey = GlobalKey();
  final srcKey = GlobalKey();

  int numberOfStarts = 0;

  Offset? getGlobalCenterPositionFromKey(GlobalKey key) {
    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;
    final globalCenterPos = renderBox.localToGlobal(
        Offset(renderBox.size.width / 2, renderBox.size.height / 2));
    return globalCenterPos;
  }

  void onPressed() {
    final srcPos = getGlobalCenterPositionFromKey(srcKey);
    final destPos = getGlobalCenterPositionFromKey(destKey);
    if (srcPos == null || destPos == null) return;

    late final OverlayEntry entry;
    entry = OverlayEntry(builder: (ctx) {
      return Positioned(
        left: srcPos.dx,
        top: srcPos.dy,
        child: Star(
          onEnd: () {
            entry.remove();
            setState(() => numberOfStarts++);
          },
          startPos: srcPos,
          endPos: destPos,
        ),
      );
    });
    Overlay.of(context).insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "No matter what widgets are in the middle\nanimation should not be obscured.",
                textAlign: TextAlign.center,
              )
            ],
          ),
          Positioned(
            left: 10,
            top: 10,
            child: StarBucket(
              key: destKey,
              numberOfStarts: numberOfStarts,
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: ElevatedButton(
              key: srcKey,
              onPressed: onPressed,
              child: const Text(
                'Shoot Star!',
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Star extends StatefulWidget {
  final void Function() onEnd;
  final Offset startPos;
  final Offset endPos;

  const Star({
    super.key,
    required this.onEnd,
    required this.startPos,
    required this.endPos,
  });

  @override
  State<Star> createState() => _StarState();
}

class _StarState extends State<Star> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  final lowerBound = 0.0;
  final upperBound = 4.0;
  final initialValue = 0.0;

  void animationControllerListener() {
    setState(() {});
  }

  void animationControllerStatusListner(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.onEnd();
    }
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      value: initialValue,
      lowerBound: lowerBound,
      upperBound: upperBound,
    );
    animationController.addListener(animationControllerListener);
    animationController.addStatusListener(animationControllerStatusListner);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.removeListener(animationControllerListener);
    animationController.removeStatusListener(animationControllerStatusListner);
    animationController.dispose();
    super.dispose();
  }

  double getScaleValue() {
    if (animationController.value > (upperBound / 2)) {
      return upperBound - animationController.value;
    } else {
      return animationController.value;
    }
  }

  Offset getTransOffset() {
    final percent = animationController.value / upperBound;
    final ret = (widget.endPos - widget.startPos) * percent;
    return (ret);
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..translate(
          getTransOffset().dx,
          getTransOffset().dy,
        )
        ..scale(getScaleValue(), getScaleValue()),
      child: const Icon(
        Icons.star,
        color: Colors.blue,
        size: 36,
      ),
    );
  }
}

class StarBucket extends StatefulWidget {
  final int numberOfStarts;
  const StarBucket({super.key, required this.numberOfStarts});

  @override
  State<StarBucket> createState() => _StarBucketState();
}

class _StarBucketState extends State<StarBucket>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  void animationControllerListener() {
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant StarBucket oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.numberOfStarts != widget.numberOfStarts) {
      animationController.forward().then((_) => animationController.reverse());
    }
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
      value: 1,
      lowerBound: 1,
      upperBound: 1.2,
    );
    animationController.addListener(animationControllerListener);
  }

  @override
  void dispose() {
    animationController.removeListener(animationControllerListener);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animationController.value,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(300)),
        width: 50,
        height: 50,
        alignment: Alignment.center,
        child: Text(
          widget.numberOfStarts.toString(),
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
