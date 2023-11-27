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
      home: const FlutterBootPlus(),
    );
  }
}

class FlutterBootPlus extends StatelessWidget {
  const FlutterBootPlus({super.key});

  Widget _buildAdCard({
    required IconData iconData,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          iconData,
          size: 36,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(content,
                  style: TextStyle(
                      fontSize: 14, color: Colors.black.withOpacity(0.7))),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FlutterBoot Plus',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildAdCard(
                iconData: Icons.bolt,
                title: 'Premium features',
                content:
                'Plus subscribers have access to FlutterBoot+ and out latest beta features.'),
            const SizedBox(height: 24),
            _buildAdCard(
                iconData: Icons.whatshot,
                title: 'Priority access',
                content:
                "You'll be able to use FlutterBoot+ even when demand is high"),
            const SizedBox(height: 24),
            _buildAdCard(
                iconData: Icons.speed,
                title: 'Ultra-fast',
                content:
                'Enjoy even faster response speeds when using FlutterBoot'),
            const Expanded(child: SizedBox()),
            Center(
              child: Text(
                'Restore subscription',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Auto-renews for \$25/month until canceled',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.75),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(300),
                ),
                color: Colors.black,
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              child: const Text(
                'Subscribe',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
