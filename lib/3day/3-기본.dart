import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const CanLayoutPage(),
    );
  }
}

class CanLayoutPage extends StatelessWidget {
  const CanLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('I can layout this'),
          backgroundColor: Colors.red,
        ),
        body:  SingleChildScrollView(child: SizedBox(

    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width/2,
              child: Row(
                children: [
                  Expanded(child:
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        border: Border(
                          right: BorderSide(width: 2.5, color: Colors.black),
                          bottom: BorderSide(width: 2.5, color: Colors.black),
                        )),
                  )),
                  Expanded(child:
              Column(
                        children: [
                          Expanded(
                              child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.blue,
                                border: Border(
                                  left: BorderSide(width: 2.5, color: Colors.black),
                                )),
                          )),
                          Expanded(
                              child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  left: BorderSide(width: 2.5, color: Colors.black),
                                  bottom: BorderSide(width: 2.5, color: Colors.black),
                                )),
                          )),
                        ],
                    ))
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.width / 2,
              child: Row(
                children: [
                  Expanded(child:

                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          right: BorderSide(width: 2.5, color: Colors.black),
                          top: BorderSide(width: 2.5, color: Colors.black),
                        )),
                    child: Column(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.green,
                              ),
                            )),
                      ],
                    ),
                  ) ),
                  Expanded(child:
                  Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            left: BorderSide(width: 2.5, color: Colors.black),
                            top: BorderSide(width: 2.5, color: Colors.black),
                          )),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                                color: Colors.yellowAccent,
                                margin: const EdgeInsets.only(top: 15, left: 15, right: 15)),
                          ),
                          Expanded(child: Container(color: Colors.white)),
                        ],
                      )),)
                ],
              ),

            ),
            Expanded(
                flex: 3,child: Container(color: Colors.yellow)),

            Expanded(
                flex: 2,child: Container(color: Colors.brown))
          ],
        ))));
  }
}
