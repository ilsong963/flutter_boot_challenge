import 'dart:math';

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
      home: HelloDraggablePage(),
    );
  }
}

class HelloDraggablePage extends StatefulWidget {
  const HelloDraggablePage({super.key});

  @override
  State<HelloDraggablePage> createState() => _HelloDraggablePage();
}

class _HelloDraggablePage extends State<HelloDraggablePage> {
  bool random = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: const IntrinsicHeight(
                child: Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello Draggable!", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 20),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TargetBucket(data: 'rectangle'),
                      TargetBucket(data: 'circle'),
                    ],
                  )),
                  Center(
                      child: DragBucket(
                    data: ['rectangle', 'circle'],
                  )),
                ],
              ),
            ))),
      );
    }));
  }
}

class DragBucket extends StatefulWidget {
  const DragBucket({super.key, required this.data});

  final List<String> data;

  @override
  State<DragBucket> createState() => _DragBucketState();
}

class _DragBucketState extends State<DragBucket> {
  bool random = Random().nextBool();

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: random ? widget.data[0] : widget.data[1],
      feedback: Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: random ? BorderRadius.circular(10.0) : null,
          shape: random ? BoxShape.rectangle : BoxShape.circle,
        ),
        child: const Center(
            child: Material(
          color: Colors.transparent,
          child: Text('Drag me'),
        )),
      ),
      onDragCompleted: () {
        setState(() {
          random = Random().nextBool();
        });
      },
      childWhenDragging: const SizedBox(),
      child: Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
          borderRadius: widget.data == 'rectangle' ? BorderRadius.circular(10.0) : BorderRadius.circular(50.0),
        ),
        child: const Center(
          child: Text('Drag me'),
        ),
      ),
    );
  }
}

class TargetBucket extends StatefulWidget {
  const TargetBucket({super.key, required this.data});

  final String data;

  @override
  State<TargetBucket> createState() => _TargetBucketState();
}

class _TargetBucketState extends State<TargetBucket> {
  bool _isAccepted = false;
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return Container(
          constraints: const BoxConstraints(
            maxHeight: 100,
            maxWidth: 100,
          ),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Colors.black,
              width: _isAccepted ? 4 : 2,
            ),
            borderRadius: widget.data == 'rectangle' ? BorderRadius.circular(10.0) : BorderRadius.circular(50.0),
          ),
          child: Center(
            child: Text('$_count'),
          ),
        );
      },
      onWillAccept: (String? data) {
        if (data == widget.data) {
          _isAccepted = true;
          return true;
        }
        return false;
      },
      onLeave: (data) {
        setState(() {
          _isAccepted = false;
        });
      },
      onAccept: (String data) {
        setState(() {
          if (data == widget.data) {
            _isAccepted = false;
            _count++;
          }
        });
      },
    );
  }
}
