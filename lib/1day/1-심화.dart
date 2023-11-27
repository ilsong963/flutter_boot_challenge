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
      home: MyCuteGptPage(),
    );
  }
}

class MyCuteGptPage extends StatefulWidget {
  const MyCuteGptPage({super.key});

  @override
  State<MyCuteGptPage> createState() => _HelloDraggablePage();
}

class _HelloDraggablePage extends State<MyCuteGptPage> {
  List<MessageModel> messageList = [
    MessageModel(isAdmin: true, name: 'MyCuteGPT', text: 'Hello, how can I help you?', profile: 'G')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.sort, color: Colors.black),
        title: const CustomAppBar(),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit, color: Colors.black)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.black)),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MessageList(messageList: messageList),
          MessageInput(
            submit: (value) {
              setState(() {
                messageList.add(value);
                messageList.add(MessageModel(
                  isAdmin: true,
                  name: "MyCuteGPT",
                  text: "Actually, Idon't have any features, but one day I'll gorw up and become ChatGPT",
                  profile: "G",
                ));
              });
            },
          )
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text("MyCuteGPT", style: TextStyle(color: Colors.black)),
        Text(" 3.5", style: TextStyle(color: Colors.grey))
      ],
    );
  }
}

class MessageList extends StatelessWidget {
  const MessageList({
    super.key,
    required this.messageList,
  });

  final List<MessageModel> messageList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemBuilder: (context, index) {
              return MessageWidget(message: messageList[index]);
            },
            itemCount: messageList.length));
  }
}

class MessageInput extends StatefulWidget {
  const MessageInput({super.key, required this.submit});

  final void Function(MessageModel) submit;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode textFocus = FocusNode();
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: textFocus,
                      onChanged: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            isEmpty = false;
                          } else {
                            isEmpty = true;
                          }
                        });
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Message',
                      ),
                    ),
                  ),
                  isEmpty ? const Icon(Icons.graphic_eq) : const SizedBox()
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isEmpty ? Colors.grey.withOpacity(0.3) : Colors.black,
            ),
            child: IconButton(
              onPressed: () {
                widget.submit(MessageModel(
                  isAdmin: false,
                  name: "FlutterBoot",
                  text: _controller.text,
                  profile: "FC",
                ));
                _controller.clear();
                textFocus.unfocus();
                isEmpty = true;
              },
              icon: Icon(Icons.north, color: isEmpty ? Colors.grey : Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final MessageModel message;

  const MessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 5, right: 5),
              width: 25.0,
              height: 25.0,
              decoration: BoxDecoration(
                color: message.isAdmin ?   Colors.green : Colors.purple,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  message.profile,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [const SizedBox(height: 5), Text(message.name), const SizedBox(height: 5), Text(message.text)],
            ))
          ],
        ));
  }
}

class MessageModel {
  final String name;
  final String text;
  final String profile;
  final bool isAdmin;

  MessageModel({required this.name, required this.text, required this.profile, required this.isAdmin});
}
