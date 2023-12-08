import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


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
      home: const HelloHttp(),
    );
  }
}

class StarWarsPeople {
  final String name;
  final String height;
  final String mass;
  final String hairColor;
  final String skinColor;
  final String birthYear;
  final String gender;

  StarWarsPeople._({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.birthYear,
    required this.gender,
  });

  factory StarWarsPeople.fromJson(Map<String, dynamic> json) {
    return StarWarsPeople._(
      name: json['name'],
      height: json['height'],
      mass: json['mass'],
      hairColor: json['hair_color'],
      skinColor: json['skin_color'],
      birthYear: json['birth_year'],
      gender: json['gender'],
    );
  }
}

class HelloHttp extends StatefulWidget {
  const HelloHttp({super.key});

  @override
  State<HelloHttp> createState() => _HelloHttpState();
}

class _HelloHttpState extends State<HelloHttp> {
  bool isSearched = false;
  bool isLoading = false;
  String? errorMsg;
  final textController = TextEditingController(text: 'sky');
  List<StarWarsPeople> people = [];

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  Future<void> onSearch() async {
    if (!isSearched) isSearched = true;
    if (isLoading) return;

    setState(() => isLoading = true);
    try {
      final url = Uri.parse(
          'https://swapi.dev/api/people/?search=${textController.text}');
      final ret = await http.get(url);
      final resultPeople = ((jsonDecode(ret.body)['results']) as Iterable)
          .map((e) => StarWarsPeople.fromJson(e))
          .toList();
      setState(() => people = resultPeople);
    } catch (e) {
      setState(() => errorMsg = e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: textController,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Enter the name of a Star Wars character here!',
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey.withOpacity(0.7),
          ),
          suffix: ElevatedButton(
            onPressed: onSearch,
            child: const Text('Search!'),
          ),
        ),
      ),
    );
  }

  Widget _buildResult() {
    if (errorMsg != null) {
      return Center(
        child: Text("Something went wrong!\n$errorMsg"),
      );
    }

    if (isLoading) {
      return const HelloHttpLoading();
    } else if (people.isEmpty) {
      if (isSearched) {
        return const Center(
          child: Text(
              "No results found, please try again with a different search term!"),
        );
      } else {
        return HelloHttpResultList(people: people);
      }
    } else {
      return HelloHttpResultList(people: people);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 32),
          _buildSearchBar(),
          const SizedBox(height: 16),
          Expanded(child: _buildResult()),
        ],
      ),
    );
  }
}

class HelloHttpResultList extends StatelessWidget {
  final List<StarWarsPeople> people;

  const HelloHttpResultList({super.key, required this.people});

  Widget _buildPersonCard(StarWarsPeople person) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        color: Colors.grey.withAlpha(200),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            person.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text('${person.height} / ${person.mass}'),
          const SizedBox(height: 4),
          Text(
              'Hair Color : ${person.hairColor} | Skin Color : ${person.skinColor}'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(16),
      itemBuilder: (_, idx) => _buildPersonCard(people[idx]),
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemCount: people.length,
    );
  }
}

class HelloHttpLoading extends StatelessWidget {
  const HelloHttpLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Loading...'),
    );
  }
}
