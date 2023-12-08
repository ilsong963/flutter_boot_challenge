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
      home: const TinderCardPage(),
    );
  }
}

class CardInfo {
  final String name;
  final int age;
  final String desc;
  final String imgSrc;

  CardInfo({
    required this.name,
    required this.age,
    required this.desc,
    required this.imgSrc,
  });

  factory CardInfo.kilee() {
    return CardInfo(
        name: 'Kilee',
        age: 19,
        desc:
        "Hi, I'm Kilee, and I'm hosting this two-week Flutter challenge, and I hope you enjoy it!",
        imgSrc:
        'https://github.com/pearan2/BibleMomorizationPrivacyPolicy/assets/74593890/4c4c1645-2537-4909-8f5b-b8e33ff8cd24');
  }

  factory CardInfo.honlee() {
    return CardInfo(
        name: 'Honlee',
        age: 22,
        desc:
        "Hi, I'm Honlee, the creator of the quiz for this Flutter Challenge. My code is by no means the correct answer!, and I'd appreciate it if you'd consider me a participant as well",
        imgSrc:
        'https://github.com/pearan2/BibleMomorizationPrivacyPolicy/assets/74593890/53e40616-0d95-4ae9-88ba-b7973ba23f9d');
  }
}

class TinderCardPage extends StatelessWidget {
  const TinderCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drag the image!'),
        centerTitle: true,
      ),
      body: TinderCard(
        cardInfo: CardInfo.kilee(),
      ),
    );
  }
}

class TinderCard extends StatefulWidget {
  final CardInfo cardInfo;

  const TinderCard({
    super.key,
    required this.cardInfo,
  });

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  Offset _position = Offset.zero;
  double _angle = 0;
  bool holdTop = false;
  Duration _animatedDuration = Duration.zero;
  late final _screenSize = MediaQuery.of(context).size;

  Widget _buildImageCard() {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            widget.cardInfo.imgSrc,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.5, 1],
              colors: [Colors.black.withOpacity(0), Colors.black],
            ),
          ),
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.cardInfo.name,
                    style: const TextStyle().copyWith(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.cardInfo.age.toString(),
                    style: const TextStyle().copyWith(
                        fontSize: 22, color: Colors.white.withOpacity(0.9)),
                  )
                ],
              ),
              const SizedBox(height: 4),
              Text(
                widget.cardInfo.desc,
                style: const TextStyle().copyWith(
                    fontSize: 18, color: Colors.white.withOpacity(0.8)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(
          builder: (_, boxConstraints) => GestureDetector(
            onPanStart: (details) {
              holdTop = details.localPosition.dy < boxConstraints.maxHeight / 2;
            },
            onPanUpdate: (details) {
              double newAngle = 30 * _position.dx / _screenSize.width;
              if (!holdTop) newAngle = -newAngle;
              setState(() {
                _position += details.delta;
                _angle = newAngle;
                _animatedDuration = Duration.zero;
              });
            },
            onPanEnd: (details) {
              setState(() {
                _position = Offset.zero;
                _angle = 0;
                _animatedDuration = const Duration(milliseconds: 400);
              });
            },
            child: AnimatedContainer(
              duration: _animatedDuration,
              transform: Matrix4.identity()
                ..translate(boxConstraints.smallest.center(Offset.zero).dx,
                    boxConstraints.smallest.center(Offset.zero).dy)
                ..rotateZ(_angle * pi / 180)
                ..translate(-boxConstraints.smallest.center(Offset.zero).dx,
                    -boxConstraints.smallest.center(Offset.zero).dy)
                ..translate(_position.dx, _position.dy),
              child: _buildImageCard(),
            ),
          ),
        ),
      ),
    );
  }
}
