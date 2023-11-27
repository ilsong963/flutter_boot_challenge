import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterBootPlusPage(),
    );
  }
}

class FlutterBootPlusPage extends StatefulWidget {
  const FlutterBootPlusPage({super.key});

  @override
  State<FlutterBootPlusPage> createState() => _HelloDraggablePage();
}

class _HelloDraggablePage extends State<FlutterBootPlusPage> {
  bool random = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0, backgroundColor: Colors.white),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(30),
            child: Text('FlutterBoot Plus', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
          ),
          const CustomListTile(
              icon: Icons.bolt,
              title: 'Premium features',
              subtitle: 'Plus subscribers have access to FlutterBoot+ and out latest beta features.'),
          const CustomListTile(
              icon: Icons.whatshot,
              title: 'Priority access',
              subtitle: 'You\'ll be able to use FlutterBoot+ even when demand is high'),
          const CustomListTile(
              icon: Icons.speed,
              title: 'Ultra-fast',
              subtitle: 'Enjoy even faster response speeds when using FlutterBoot'),
          const Spacer(),
          Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Restore subscription', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text('Auto-renews for \$25/month until canceled'),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {},
                      child: const Text(
                        'Subscribe',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              )
            ],
          ))
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({super.key, required this.icon, required this.title, required this.subtitle});

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black, size: 40),
      title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 15)),
    );
  }
}
