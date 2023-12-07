import 'dart:convert';

import 'package:http/http.dart' as http;
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
      home: const HttpPage(),
    );
  }
}

class HttpPage extends StatefulWidget {
  const HttpPage({super.key});

  @override
  State<HttpPage> createState() => _HttpPage();
}

class _HttpPage extends State<HttpPage> {
  final controller = TextEditingController();
  Future? futureData;

  @override
  void initState() {
    super.initState();
  }

  Future getData() async {
    var response = await http.get(Uri.parse('https://swapi.dev/api/people/?search=${controller.text}'));
    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Enter the name of a Star Wars character here!',
                      suffix: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              futureData = getData();
                            });
                          },
                          child: Text('Search!'))),
                ),
                FutureBuilder(
                  future: futureData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(child: Center(child: Text("loading...")));
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data['results'].length == 0) {
                        return const Expanded(
                            child: Center(
                                child: Text("No results found, please try again with a different search term!")));
                      }
                      return Expanded(
                          child: SingleChildScrollView(
                              child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data['results'].length,
                        itemBuilder: (context, index) {
                          return CharacterCard(character: Character.fromJson(snapshot.data['results'][index]));
                        },
                      )));
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      return SizedBox();
                    }
                  },
                )
              ],
            )));
  }
}

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              color: Colors.grey,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            width: double.infinity,
            child: Column(
              children: [
                Text(character.name, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('${character.height} / ${character.mass}'),
                SizedBox(height: 10),
                Text('Hair Color : ${character.hairColor} | Skin Color : ${character.skinColor}'),
              ],
            )));
  }
}

class Character {
  final String name;
  final String height;
  final String mass;
  final String hairColor;
  final String skinColor;

  Character(
      {required this.name, required this.height, required this.mass, required this.hairColor, required this.skinColor});

  factory Character.fromJson(Map<String, dynamic> jsonData) {
    return Character(
      name: jsonData['name'],
      height: jsonData['height'],
      mass: jsonData['mass'],
      hairColor: jsonData['hair_color'],
      skinColor: jsonData['skin_color'],
    );
  }
}
