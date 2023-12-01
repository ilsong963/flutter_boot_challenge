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
      home: const HelloTextFieldPage(),
    );
  }
}

class HelloTextFieldPage extends StatefulWidget {
  const HelloTextFieldPage({super.key});

  @override
  State<HelloTextFieldPage> createState() => _HelloTextFieldPageState();
}

class _HelloTextFieldPageState extends State<HelloTextFieldPage> {
  final emptyFakeString = '\u200b';

  late final firstTextEditController =
  TextEditingController(text: '${emptyFakeString}Hello');
  late final secondTextEditController =
  TextEditingController(text: '${emptyFakeString}FlutterBoot!');
  final firstFocusNode = FocusNode();
  final secondFocusNode = FocusNode();

  @override
  void dispose() {
    firstTextEditController.dispose();
    secondTextEditController.dispose();
    firstFocusNode.dispose();
    secondFocusNode.dispose();
    super.dispose();
  }

  void onFirstTextChanged(String value) {
    print(value);
    if (value.isEmpty) {
      secondFocusNode.requestFocus();
    }
    if (!value.contains(emptyFakeString)) {
      firstTextEditController.text = emptyFakeString + value;
      firstTextEditController.selection = TextSelection.fromPosition(
          TextPosition(offset: firstTextEditController.text.length));
    }
  }

  void onSecondTextChanged(String value) {
    if (value.isEmpty) {
      firstFocusNode.requestFocus();
    }
    if (!value.contains(emptyFakeString)) {
      secondTextEditController.text = emptyFakeString + value;
      secondTextEditController.selection = TextSelection.fromPosition(
          TextPosition(offset: secondTextEditController.text.length));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello TextField!')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: onFirstTextChanged,
                  focusNode: firstFocusNode,
                  onEditingComplete: () => secondFocusNode.requestFocus(),
                  controller: firstTextEditController,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: TextField(
                  onChanged: onSecondTextChanged,
                  onEditingComplete: () => firstFocusNode.requestFocus(),
                  focusNode: secondFocusNode,
                  autofocus: true,
                  controller: secondTextEditController,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
