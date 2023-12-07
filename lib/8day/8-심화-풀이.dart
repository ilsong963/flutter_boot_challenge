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
      home: const SlackHome(),
    );
  }
}

class SlackHome extends StatelessWidget {
  const SlackHome({super.key});

  Widget _buildDivider() {
    return const Divider(
      height: 0.3,
      thickness: 0.3,
      color: Colors.grey,
    );
  }

  Widget _buildTextIcon(IconData iconData, String text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(iconData),
        const SizedBox(height: 2),
        Text(text),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black, width: 1)),
          color: Colors.white,
        ),
        height: 70,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTextIcon(Icons.home, 'Home'),
            _buildTextIcon(Icons.comment, 'DM'),
            _buildTextIcon(Icons.alarm, 'Alerm'),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SlackHomeSearchBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              const SlackHomeInfoContainer(),
              _buildDivider(),
              const SlackExpansionPanelList(),
            ]),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: const Text('+ Add team members'),
            ),
          ),
        ],
      ),
    );
  }
}

class SlackHomeSearchBar extends StatelessWidget {
  const SlackHomeSearchBar({super.key});

  Widget _buildChannelText() {
    return const Text(
      'FlutterBoot',
      style: TextStyle(
          fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSearchBar() {
    final color = Colors.white.withOpacity(0.8);

    return _buildContainer(Row(
      children: [
        Icon(Icons.search, color: color),
        const SizedBox(width: 4),
        Expanded(
            child: Text(
              'move or search...',
              style: TextStyle(color: color, fontSize: 16),
            )),
        Icon(Icons.mic, color: color),
      ],
    ));
  }

  Widget _buildMenu() {
    final color = Colors.white.withOpacity(0.8);
    return _buildContainer(Icon(Icons.menu, color: color));
  }

  Widget _buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.white.withOpacity(0.3),
      ),
      padding: const EdgeInsets.all(4),
      child: child,
    );
  }

  Widget _buildFlexibleSpaceBarTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(child: _buildSearchBar()),
          const SizedBox(width: 8),
          _buildMenu(),
        ],
      ),
    );
  }

  Widget _buildFlexibleSpaceBarBackground() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: _buildChannelText(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.purple,
      flexibleSpace: FlexibleSpaceBar(
        title: _buildFlexibleSpaceBarTitle(),
        background: _buildFlexibleSpaceBarBackground(),
        expandedTitleScale: 1,
      ),
      stretch: false,
      expandedHeight: 110,
      pinned: true,
    );
  }
}

class SlackHomeInfoContainer extends StatelessWidget {
  const SlackHomeInfoContainer({super.key});

  Widget _buildInfoItem(IconData iconData, String title, String desc) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: Colors.grey.withOpacity(0.6))),
      padding: const EdgeInsets.all(4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData),
          const SizedBox(height: 4),
          Text(title),
          Text(
            desc,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildInfoItem(
            Icons.message,
            'Thread',
            'Confirmed',
          ),
          _buildInfoItem(
            Icons.flag,
            'Late',
            '2 Contents',
          ),
          _buildInfoItem(
            Icons.message,
            'Drafted and sent',
            '2 Drafts',
          ),
          _buildInfoItem(
            Icons.flutter_dash,
            'FlutterBoot',
            'you can do it',
          ),
        ],
      ),
    );
  }
}

class SlackExpansionPanelList extends StatefulWidget {
  const SlackExpansionPanelList({super.key});

  @override
  State<SlackExpansionPanelList> createState() =>
      _SlackExpansionPanelListState();
}

class _SlackExpansionPanelListState extends State<SlackExpansionPanelList> {
  final headers = [
    'Mentions',
    'Channels',
    'Favorites',
    'DMs',
    'Recent Apps',
    'Flutter',
    'Boot',
    'is',
    'the',
    'best',
    'You can do it!',
  ];
  late List<bool> isExapndeds = List.generate(headers.length, (_) => false);

  List<ExpansionPanel> _buildExpansionPanels() {
    return headers
        .map(
          (h) => ExpansionPanel(
        backgroundColor: Colors.white,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 12,
              ),
              child: Text(
                h,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ));
        },
        canTapOnHeader: true,
        body: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.centerLeft,
            child: const Text('now Opend')),
        isExpanded: isExapndeds[headers.indexOf(h)],
      ),
    )
        .toList();
  }

  void expansionCallback(int panelIndex, bool isExpanded) {
    final newIsExpandeds = [...isExapndeds];
    newIsExpandeds[panelIndex] = isExpanded;
    setState(() => isExapndeds = newIsExpandeds);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expandedHeaderPadding: EdgeInsets.zero,
      dividerColor: Colors.grey,
      materialGapSize: 0,
      expansionCallback: expansionCallback,
      children: _buildExpansionPanels(),
    );
  }
}
