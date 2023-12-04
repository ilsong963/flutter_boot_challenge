import 'package:flutter/material.dart';

final spaceData = {
  'NGC 162': 1862,
  '87 Sylvia': 1866,
  'R 136a1': 1985,
  '28978 Ixion': 2001,
  'NGC 6715': 1778,
  '94400 Hongdaeyong': 2001,
  '6354 Vangelis': 1934,
  'C/2020 F3': 2020,
  'Cartwheel Galaxy': 1941,
  'Sculptor Dwarf Elliptical Galaxy': 1937,
  'Eight-Burst Nebula': 1835,
  'Rhea': 1672,
  'C/1702 H1': 1702,
  'Messier 5': 1702,
  'Messier 50': 1711,
  'Cassiopeia A': 1680,
  'Great Comet of 1680': 1680,
  'Butterfly Cluster': 1654,
  'Triangulum Galaxy': 1654,
  'Comet of 1729': 1729,
  'Omega Nebula': 1745,
  'Eagle Nebula': 1745,
  'Small Sagittarius Star Cloud': 1764,
  'Dumbbell Nebula': 1764,
  '54509 YORP': 2000,
  'Dia': 2000,
  '63145 Choemuseon': 2000,
};

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
      home: const MyFirstListViewPage(),
    );
  }
}

class MyFirstListViewPage extends StatefulWidget {
  const MyFirstListViewPage({super.key});

  @override
  State<MyFirstListViewPage> createState() => _MyFirstListViewPageState();
}

class _MyFirstListViewPageState extends State<MyFirstListViewPage> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My First ListView!')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scrollController.animateTo(
            scrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        },
        child: const Icon(Icons.navigation),
      ),
      body: ListView.builder(
        controller: scrollController,
        itemCount: spaceData.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                    '* ${spaceData.keys.elementAt(index)} was discovered in ${spaceData[spaceData.keys.elementAt(index)]}'),
              ));
        },
      ),
    );
  }
}
