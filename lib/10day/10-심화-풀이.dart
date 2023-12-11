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
      home: const TinderSwipePage(),
    );
  }
}

class TinderSwipePage extends StatelessWidget {
  const TinderSwipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TinderSwipePageAppbar(),
      body: const TinderSwipePageBody(),
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.whatshot), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: '')
          ]),
    );
  }
}

class TinderSwipePageAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const TinderSwipePageAppbar({super.key});

  @override
  Size get preferredSize => const Size(56.0, 56.0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        height: 56.0,
        child: const Row(
          children: [
            SizedBox(width: 4),
            Icon(Icons.whatshot, size: 24),
            Text('FlutterBoot', style: TextStyle(fontSize: 22))
          ],
        ),
      ),
    );
  }
}

class TinderSwipePageBody extends StatefulWidget {
  const TinderSwipePageBody({super.key});

  @override
  State<TinderSwipePageBody> createState() => _TinderSwipePageBodyState();
}

class _TinderSwipePageBodyState extends State<TinderSwipePageBody> {
  List<CardInfo> cards = [
    CardInfo.kilee().copyWith(age: CardInfo.kilee().age + 1),
    CardInfo.honlee().copyWith(age: CardInfo.honlee().age + 1),
    CardInfo.kilee(),
    CardInfo.honlee()
  ];

  void onChoiceEnded(CardInfo cardInfo, CardStatus status) {
    final last = cards.removeLast();
    cards.insert(0, last.copyWith(age: last.age + 2));
    setState(() {});
  }

  void onStatusChanged(CardStatus status, double value) {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: cards
          .map((card) => TinderCard(
        key: ObjectKey(card),
        cardInfo: card,
        useInteraction: true,
        backgroundColor: Colors.transparent,
        onChoiceEnded: onChoiceEnded,
        onStatusChanged: onStatusChanged,
      ))
          .toList(),
    );
  }
}

enum CardStatus {
  none,
  like,
  dislike,
  superLike,
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
        imgSrc: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsyf3Y3N4Tmh5BU-n3dXTMDqOaxErcx-U8UQ&usqp=CAU');
  }

  factory CardInfo.honlee() {
    return CardInfo(
        name: 'Honlee',
        age: 22,
        desc:
        "Hi, I'm Honlee, the creator of the quiz for this Flutter Challenge. My code is by no means the correct answer!, and I'd appreciate it if you'd consider me a participant as well",
        imgSrc: 'https://img.allurekorea.com/allure/2023/08/style_64d0b9fd307d8-525x700.jpg');
  }

  CardInfo copyWith({int? age}) {
    return CardInfo(
      name: name,
      age: age ?? this.age,
      desc: desc,
      imgSrc: imgSrc,
    );
  }
}

class TinderCard extends StatefulWidget {
  final CardInfo cardInfo;

  final Color backgroundColor;
  final bool useInteraction;
  final double statusChangeMaxDistance;
  final double statusChangeThresholdDistance;
  final void Function(CardStatus, double)? onStatusChanged;
  final void Function(CardInfo, CardStatus)? onChoiceEnded;

  const TinderCard({
    super.key,
    required this.cardInfo,
    this.backgroundColor = Colors.blue,
    this.useInteraction = false,
    this.statusChangeMaxDistance = 200.0,
    this.statusChangeThresholdDistance = 100.0,
    this.onStatusChanged,
    this.onChoiceEnded,
  });

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
  Offset position = Offset.zero;
  double angle = 0;
  bool holdTop = false;
  CardStatus status = CardStatus.none;
  double statusValue = 0.0;
  Duration animatedDuration = Duration.zero;
  bool isChoiceEnd = false;

  Widget _buildTextBox(List<Color> colors, String text) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: const [0.5, 1],
        colors: colors
            .map((e) =>
            e.withOpacity(statusValue / widget.statusChangeMaxDistance))
            .toList(),
      ).createShader(bounds),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 6),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(4),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
  }

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
        Visibility(
          visible: status == CardStatus.like,
          child: Positioned(
            left: 50,
            top: 50,
            child: Transform(
                transform: Matrix4.identity()..rotateZ(-pi / 8),
                child:
                _buildTextBox([Colors.lightGreen, Colors.green], 'LIKE')),
          ),
        ),
        Visibility(
          visible: status == CardStatus.dislike,
          child: Positioned(
            right: 50,
            top: 50,
            child: Transform(
                transform: Matrix4.identity()..rotateZ(pi / 8),
                child: _buildTextBox([Colors.yellow, Colors.red], 'NOPE')),
          ),
        ),
        Visibility(
          visible: status == CardStatus.superLike,
          child: Positioned(
            left: 0,
            right: 0,
            bottom: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform(
                    transform: Matrix4.identity()..rotateZ(pi / 8),
                    child: _buildTextBox(
                        [Colors.blue, Colors.indigo], 'SUPER\nLIKE')),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void updateStatus(DragUpdateDetails details) {
    final np = position + details.delta;
    late CardStatus nextStatus;
    late double nextStatusValue;

    if (np.dx < -widget.statusChangeThresholdDistance) {
      nextStatus = CardStatus.dislike;
      nextStatusValue = min(widget.statusChangeMaxDistance, np.dx.abs());
    } else if (np.dx > widget.statusChangeThresholdDistance) {
      nextStatus = CardStatus.like;
      nextStatusValue = min(widget.statusChangeMaxDistance, np.dx.abs());
    } else if (np.dy < -widget.statusChangeThresholdDistance) {
      nextStatus = CardStatus.superLike;
      nextStatusValue = min(widget.statusChangeMaxDistance, np.dy.abs());
    } else {
      nextStatus = CardStatus.none;
      nextStatusValue = 0.0;
    }
    setState(() {
      status = nextStatus;
      statusValue = nextStatusValue;
    });
    widget.onStatusChanged?.call(nextStatus, nextStatusValue);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: widget.backgroundColor,
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(
          builder: (_, boxConstraints) => GestureDetector(
            onPanStart: (details) {
              if (!widget.useInteraction) return;
              holdTop = details.localPosition.dy < boxConstraints.maxHeight / 2;
            },
            onPanUpdate: (details) {
              if (!widget.useInteraction) return;
              double newAngle = 30 * position.dx / boxConstraints.maxWidth;
              if (!holdTop) newAngle = -newAngle;
              updateStatus(details);
              setState(() {
                position += details.delta;
                angle = newAngle;
                animatedDuration = Duration.zero;
              });
            },
            onPanEnd: (details) {
              if (!widget.useInteraction) return;

              if (status == CardStatus.none) {
                setState(() {
                  position = Offset.zero;
                  angle = 0;
                  animatedDuration = const Duration(milliseconds: 400);
                });
              } else if (status == CardStatus.like) {
                setState(() {
                  isChoiceEnd = true;
                  position += Offset(boxConstraints.maxWidth * 2, position.dy);
                  animatedDuration = const Duration(milliseconds: 400);
                });
              } else if (status == CardStatus.dislike) {
                setState(() {
                  isChoiceEnd = true;
                  position += Offset(-boxConstraints.maxWidth * 2, position.dy);
                  animatedDuration = const Duration(milliseconds: 400);
                });
              } else if (status == CardStatus.superLike) {
                setState(() {
                  isChoiceEnd = true;
                  position +=
                      Offset(position.dx, -boxConstraints.maxHeight * 2);
                  animatedDuration = const Duration(milliseconds: 400);
                });
              } else {
                throw 'invalid CardStatus!';
              }
            },
            child: AnimatedContainer(
              onEnd: () {
                if (isChoiceEnd) {
                  widget.onChoiceEnded?.call(widget.cardInfo, status);
                }
              },
              duration: animatedDuration,
              transform: Matrix4.identity()
                ..translate(boxConstraints.smallest.center(Offset.zero).dx,
                    boxConstraints.smallest.center(Offset.zero).dy)
                ..rotateZ(angle * pi / 180)
                ..translate(-boxConstraints.smallest.center(Offset.zero).dx,
                    -boxConstraints.smallest.center(Offset.zero).dy)
                ..translate(position.dx, position.dy),
              child: _buildImageCard(),
            ),
          ),
        ),
      ),
    );
  }
}
