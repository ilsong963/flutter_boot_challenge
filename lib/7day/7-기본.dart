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
      home: const OverlayPage(),
    );
  }
}

class OverlayPage extends StatefulWidget {
  const OverlayPage({super.key});

  @override
  State<OverlayPage> createState() => _DialogPage();
}

class _DialogPage extends State<OverlayPage> {
  int point = 0;
  OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          removeHighlightOverlay();
        },
        child: Scaffold(
            body: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                    child:
                        Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                  SizedBox(height: 10),
                  Text('Hello Overlay', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  OverlayButton(
                    text: 'Hello!',
                    onPressed: (offset, size) {
                      removeHighlightOverlay();
                      createHighlightOverlay(offset, size);
                    },
                  ),
                  SizedBox(height: 10),
                  OverlayButton(
                    text: 'Press',
                    onPressed: (offset, size) {
                      removeHighlightOverlay();
                      createHighlightOverlay(offset, size);
                    },
                  ),
                  SizedBox(height: 10),
                  OverlayButton(
                    text: 'any',
                    onPressed: (offset, size) {
                      removeHighlightOverlay();
                      createHighlightOverlay(offset, size);
                    },
                  ),
                  SizedBox(height: 10),
                  OverlayButton(
                    text: 'button!',
                    onPressed: (offset, size) {
                      removeHighlightOverlay();
                      createHighlightOverlay(offset, size);
                    },
                  ),
                ])))));
  }

  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  void createHighlightOverlay(Offset offset, Size size) {
    removeHighlightOverlay();

    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (BuildContext context) {
        return Positioned(
            left: offset.dx + size.width / 2,
            top: offset.dy - 20,
            child: IgnorePointer(
                child: Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey,
              ),
              child: const DefaultTextStyle(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
                child: Text('↓ You clicked this 😎'),
              ),
            )));
      },
    );

    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }
}

class OverlayButton extends StatefulWidget {
  const OverlayButton({super.key, required this.onPressed, required this.text});

  final String text;

  final Function onPressed;

  @override
  State<OverlayButton> createState() => _OverlayButtonState();
}

class _OverlayButtonState extends State<OverlayButton> {
  OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            final renderBox = context.findRenderObject() as RenderBox;
            final size = renderBox.size;
            final offset = renderBox.localToGlobal(Offset.zero);
            widget.onPressed(offset, size);
          },
          child: Text(widget.text),
        ));
  }
}
