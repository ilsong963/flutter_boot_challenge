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
      home: const MyCuteGPT(),
    );
  }
}

class MyCuteGPT extends StatefulWidget {
  const MyCuteGPT({super.key});

  @override
  State<MyCuteGPT> createState() => _MyCuteGPTState();
}

class _MyCuteGPTState extends State<MyCuteGPT> {
  List<String> userInputs = [];
  List<String> gptOutputs = ['Hello, how can I help you?'];
  String input = '';
  final controller = TextEditingController();

  void onTextEditCompleted() {
    if (input.isEmpty) return;

    setState(() {
      userInputs = [...userInputs, input];
      input = '';
      controller.text = '';
      gptOutputs = [
        ...gptOutputs,
        "Actually, I don't have any features, but one day I'll grow up and become ChatGPT!",
      ];
    });
  }

  Widget _buildCustomAppBar() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.notes, size: 24),
            SizedBox(width: 16),
            Text('MyCuteGPT', style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            Text('3.5', style: TextStyle(fontSize: 24, color: Colors.grey))
          ],
        ),
        Row(
          children: [
            Icon(Icons.mode, size: 24),
            SizedBox(width: 16),
            Icon(Icons.more_vert, size: 24),
          ],
        )
      ],
    );
  }

  Widget _buildIcon(
      {double size = 24,
        required Color backgroundColor,
        required String thumbnail}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(300),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        thumbnail,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildChatTile({
    required Color iconBackgroundColor,
    required String thumbnail,
    required String name,
    required String content,
  }) {
    const iconSize = 24.0;
    const iconNameSpacing = 8.0;

    return Column(
      children: [
        Row(
          children: [
            _buildIcon(
              size: iconSize,
              backgroundColor: iconBackgroundColor,
              thumbnail: thumbnail,
            ),
            const SizedBox(width: iconNameSpacing),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: iconNameSpacing + iconSize),
            Expanded(
              child: Text(
                content,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildChats() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemBuilder: (_, idx) {
        final isUser = idx.isOdd;

        return _buildChatTile(
          iconBackgroundColor: isUser ? Colors.purple : Colors.green,
          thumbnail: isUser ? 'FC' : 'G',
          name: isUser ? 'FlutterBoot' : 'MyCuteGPT',
          content: isUser ? userInputs[idx ~/ 2] : gptOutputs[idx ~/ 2],
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemCount: userInputs.length + gptOutputs.length,
    );
  }

  Widget _buildMessageInput() {
    const normalBackgroundColor = Color(0xFFE7E2E8);
    const normalIconColor = Color(0xFFA39FA7);

    return Row(
      children: [
        Expanded(
            child: CuteGPTTextField(
              controller: controller,
              onchanged: (v) => setState(() => input = v),
            )),
        const SizedBox(width: 12),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTextEditCompleted,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(300)),
                color: input.isEmpty ? normalBackgroundColor : Colors.black),
            padding: const EdgeInsets.all(12),
            child: Icon(Icons.north,
                size: 24,
                color: input.isEmpty ? normalIconColor : Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBFF),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildCustomAppBar(),
                const SizedBox(height: 32),
                Expanded(child: _buildChats()),
                const SizedBox(height: 16),
                _buildMessageInput(),
              ],
            ),
          )),
    );
  }
}

class CuteGPTTextField extends StatelessWidget {
  final void Function(String) onchanged;
  final TextEditingController controller;

  const CuteGPTTextField({
    super.key,
    required this.onchanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE7E2E8);
    const iconColor = Color(0xFFA39FA7);
    return TextFormField(
      controller: controller,
      maxLines: 10,
      minLines: 1,
      onChanged: onchanged,
      cursorColor: Colors.black,
      decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: controller.text.isEmpty
                ? const Icon(Icons.graphic_eq)
                : const SizedBox(),
          ),
          hintText: 'Message',
          hintStyle: const TextStyle(color: iconColor),
          fillColor: backgroundColor,
          filled: true,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              borderSide: BorderSide(width: 0, style: BorderStyle.none)),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 24, horizontal: 16)),
    );
  }
}
