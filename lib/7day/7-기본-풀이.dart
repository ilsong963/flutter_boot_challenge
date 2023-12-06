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
      home: const HelloOverlay(),
    );
  }
}

class HelloOverlay extends StatelessWidget {
  const HelloOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const OverlayExample();
  }
}

class OverlayExample extends StatefulWidget {
  const OverlayExample({super.key});

  @override
  State<OverlayExample> createState() => _OverlayExampleState();
}

class _OverlayExampleState extends State<OverlayExample> {
  OverlayEntry? overlayEntry;
  final List<String> buttonLabels = [
    'Hello!',
    'Press',
    'any',
    'button!',
  ];

  late final keys = buttonLabels.map((_) => GlobalKey()).toList();

  GlobalKey? selectedKey;

  void createOverlay() {
    removeOverlay();
    assert(overlayEntry == null);
    if (selectedKey == null || selectedKey!.currentContext == null) return;
    final renderBox =
    selectedKey!.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final pos = renderBox.localToGlobal(Offset.zero);

    const iconWidth = 16.0;
    const iconTextSpacing = 2.0;

    overlayEntry = OverlayEntry(builder: (ctx) {
      final overlayStartXPos = pos.dx + size.width / 2 - iconWidth / 2;

      return DefaultTextStyle(
        style: const TextStyle(fontSize: 16),
        child: Positioned(
          top: pos.dy - 30,
          left: overlayStartXPos,
          child: IgnorePointer(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                color: Colors.grey,
              ),
              padding: const EdgeInsets.all(4),
              child: const Row(
                children: [
                  Icon(Icons.south, size: iconWidth),
                  SizedBox(width: iconTextSpacing),
                  Text("You clicked this 😎"),
                ],
              ),
            ),
          ),
        ),
      );
    });

    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  // Remove the OverlayEntry.
  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  @override
  void dispose() {
    // Make sure to remove OverlayEntry when the widget is disposed.
    removeOverlay();
    super.dispose();
  }

  void onClick(int idx) {
    setState(() => selectedKey = keys[idx]);
    createOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: removeOverlay,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hello Overlay'),
          centerTitle: true,
        ),
        body: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(32),
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, idx) => ElevatedButton(
            onPressed: () => onClick(idx),
            child: Text(key: keys[idx], buttonLabels[idx]),
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemCount: buttonLabels.length,
        ),
      ),
    );
  }
}
