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
      home: const MyRandomImageSlider(),
    );
  }
}

class MyRandomImageSlider extends StatefulWidget {
  const MyRandomImageSlider({super.key});

  @override
  State<MyRandomImageSlider> createState() => _MyRandomImageSliderState();
}

class _MyRandomImageSliderState extends State<MyRandomImageSlider> {
  late List<String> imageSrcs =
  List.generate(5, (_) => getRandomImageSrc()).toList();

  final scrollController = ScrollController();
  int nowIdx = 0;

  String getRandomImageSrc() {
    return 'https://picsum.photos/id/${Random().nextInt(1000) + 1}/200/200';
  }

  Widget _buildImage(src, double size) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.network(
        src,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) {
            return const Center(child: Text('loading...'));
          } else {
            return child;
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Text('Oops! Something went wrong'),
          );
        },
      ),
    );
  }

  void _updateImageSrcs() {
    final newImageSrcs = [...imageSrcs, getRandomImageSrc()];
    setState(() {
      imageSrcs = newImageSrcs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Click left and right'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      nowIdx = max(0, nowIdx - 1);
                    });
                  },
                  child: const Text('<'),
                ),
              ),
              SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      nowIdx = nowIdx + 1;
                    });
                    if (nowIdx + 5 > imageSrcs.length) _updateImageSrcs();
                  },
                  child: const Text('>'),
                ),
              ),
            ],
          ),
          Expanded(
            child: _buildImage(imageSrcs[nowIdx], width),
          ),
        ],
      ),
    );
  }
}
