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
      home: const ILoveFlutterBoot(),
    );
  }
}

class ILoveFlutterBoot extends StatelessWidget {
  const ILoveFlutterBoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/flutter_boot_cat_1.png'),
            ),
          ),
          alignment: Alignment.bottomRight,
          child: const LoveButton(
            width: 70,
            buttonSize: 50,
            heartUpDuration: Duration(milliseconds: 5000),
          ),
        ));
  }
}

class Heart {
  final double boxSize;
  final double heartSize;
  final Color color1;
  final Color color2;
  Offset offset;

  Heart({
    required this.boxSize,
    required this.heartSize,
    required this.color1,
    required this.color2,
    this.offset = Offset.zero,
  });
}

class HeartWidget extends StatefulWidget {
  final Heart heart;
  final Duration duration;
  const HeartWidget({super.key, required this.heart, required this.duration});

  @override
  State<HeartWidget> createState() => _HeartWidgetState();
}

class _HeartWidgetState extends State<HeartWidget> {
  late final posMax = widget.heart.boxSize - widget.heart.heartSize;
  late Offset pos = getRandomPos();
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(widget.duration, (_) {
      setState(() {
        pos = getRandomPos();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Offset getRandomPos() {
    return Offset(
        Random().nextDouble() * posMax, Random().nextDouble() * posMax);
  }

  Widget buildIcon() {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: const [0.3, 1],
        colors: [
          widget.heart.color1,
          widget.heart.color2,
        ],
      ).createShader(bounds),
      child: Icon(
        Icons.favorite,
        size: widget.heart.heartSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          SizedBox(
            width: widget.heart.boxSize,
            height: widget.heart.boxSize,
          ),
          AnimatedPositioned(
            left: pos.dx,
            top: pos.dy,
            duration: widget.duration,
            child: buildIcon(),
          )
        ],
      ),
    );
  }
}

class LoveButton extends StatefulWidget {
  final double width;
  final double buttonSize;
  final int maxHeart;
  final Duration heartUpDuration;
  const LoveButton(
      {super.key,
        required this.width,
        required this.buttonSize,
        this.maxHeart = 20,
        required this.heartUpDuration});

  @override
  State<LoveButton> createState() => _LoveButtonState();
}

class _LoveButtonState extends State<LoveButton> {
  List<Heart> hearts = [];

  List<Color> getRandomColors() {
    final firstColor =
    Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    return [
      firstColor,
      Color((Random(firstColor.value).nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0)
    ];
  }

  void onClick() {
    if (hearts.length >= widget.maxHeart) return;
    final heartBoxSize = Random().nextInt(widget.width ~/ 2) + widget.width / 2;
    final colors = getRandomColors();
    final newHeart = Heart(
      boxSize: heartBoxSize,
      heartSize: heartBoxSize * 0.7,
      color1: colors[0],
      color2: colors[1],
      offset: Offset(Random().nextDouble() * (widget.width - heartBoxSize),
          widget.buttonSize),
    );
    setState(() => hearts = [...hearts, newHeart]);

    Future.delayed(const Duration(milliseconds: 50), () {
      newHeart.offset = Offset(newHeart.offset.dx, 500);
      setState(() {});
    });
  }

  void deleteHeart(Heart heart) {
    hearts.remove(heart);
    setState(() {});
  }

  List<Widget> _buildHearts() {
    return hearts
        .map((h) => AnimatedPositioned(
      key: ObjectKey(h),
      left: h.offset.dx,
      bottom: h.offset.dy,
      duration: widget.heartUpDuration,
      onEnd: () => deleteHeart(h),
      child: HeartWidget(
        heart: h,
        duration: const Duration(milliseconds: 500),
      ),
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Stack(
        children: [
          Positioned(
            right: (widget.width - widget.buttonSize) / 2,
            bottom: (widget.width - widget.buttonSize) / 2,
            child: GestureDetector(
              onTap: onClick,
              child: Container(
                width: widget.buttonSize,
                height: widget.buttonSize,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2),
                    borderRadius: const BorderRadius.all(Radius.circular(300)),
                    color: Colors.white.withOpacity(0.5)),
                child: Icon(Icons.favorite,
                    size: widget.buttonSize * 0.7, color: Colors.red),
              ),
            ),
          ),
          const Column(),
          ..._buildHearts(),
        ],
      ),
    );
  }
}
