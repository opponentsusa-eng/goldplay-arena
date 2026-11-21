lib/main.dart
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const GoldPlayApp());

const gold = Color(0xFFD7AF55);
const dark = Color(0xFF101510);
const panel = Color(0xFF1C281F);
const green = Color(0xFF1D6B3A);

class GoldPlayApp extends StatelessWidget {
  const GoldPlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GoldPlay Arena',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: dark,
        colorScheme: const ColorScheme.dark(
          primary: gold, secondary: green, surface: panel,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int points = 120;
  bool bonusClaimed = false;
  int selectedTab = 0;

  void claimBonus() {
    if (bonusClaimed) return;
    setState(() {
      points += 10;
      bonusClaimed = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('10 practice points added!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dark,
        title: const Text('GOLDPLAY ARENA',
            style: TextStyle(color: gold, fontWeight: FontWeight.w900,
                letterSpacing: 1.4)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Chip(
                avatar: const Icon(Icons.stars, color: gold, size: 18),
                label: Text('$points pts',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                backgroundColor: panel,
                side: BorderSide.none,
              ),
            ),
          )
        ],
      ),
      body: selectedTab == 0
          ? _homeBody()
          : selectedTab == 1
              ? const InfoPage(title: 'My Games',
                  message: 'Your recently played free arcade games will appear here.')
              : const InfoPage(title: 'Profile',
                  message: 'Player profile, settings and help will appear here.'),
      bottomNavigationBar: NavigationBar(
        backgroundColor: panel,
        indicatorColor: green,
        selectedIndex: selectedTab,
        onDestinationSelected: (v) => setState(() => selectedTab = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.sports_esports_outlined),
              selectedIcon: Icon(Icons.sports_esports), label: 'My Games'),
          NavigationDestination(icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _homeBody() {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: const LinearGradient(
              colors: [Color(0xFF245B35), Color(0xFF17241B)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            border: Border.all(color: gold.withOpacity(.55)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('WELCOME TO THE ARENA',
                  style: TextStyle(color: gold, fontWeight: FontWeight.bold,
                      letterSpacing: 1.2)),
              const SizedBox(height: 8),
              const Text('Play. Practice. Have Fun.',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
              const SizedBox(height: 14),
              Row(children: [
                const Expanded(child: Text(
                  'Free games • Practice points • No cash wagers',
                  style: TextStyle(color: Colors.white70))),
                FilledButton(
                  onPressed: claimBonus,
                  child: Text(bonusClaimed ? 'Claimed' : 'Daily +10'),
                ),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text('CHOOSE YOUR GAME',
            style: TextStyle(color: gold, fontWeight: FontWeight.w800,
                letterSpacing: 1.2, fontSize: 16)),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.05,
          children: [
            GameTile(icon: Icons.casino, title: 'Lucky Reels',
                subtitle: 'Free spin arcade', color: const Color(0xFF24643B),
                onTap: () => openGame(context, 'Lucky Reels',
                    'A simple slot-inspired animation using practice points only. No wagers or cash prizes.')),
            GameTile(icon: Icons.style, title: 'Rummy Practice',
                subtitle: 'Learn card sequences', color: const Color(0xFF38543A),
                onTap: () => openGame(context, 'Rummy Practice',
                    'Practice card grouping and learn sequences against a simple tutorial.')),
            GameTile(icon: Icons.extension, title: 'Mini Games',
                subtitle: 'Puzzle & memory', color: const Color(0xFF4C5730),
                onTap: () => openGame(context, 'Mini Games',
                    'A collection of casual puzzle, memory and tapping challenges.')),
            GameTile(icon: Icons.flight_takeoff, title: 'Sky Flight',
                subtitle: 'Arcade flight score', color: const Color(0xFF24505A),
                onTap: () => openGame(context, 'Sky Flight',
                    'Fly through checkpoints and earn a high score. This is not a betting or multiplier game.')),
          ],
        ),
        const SizedBox(height: 18),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: panel,
              borderRadius: BorderRadius.circular(16)),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.shield_outlined, color: gold),
              SizedBox(width: 10),
              Expanded(child: Text(
                'GoldPlay is a free entertainment prototype. Points have no cash value and cannot be bought, sold, transferred or withdrawn.',
                style: TextStyle(color: Colors.white70, fontSize: 12))),
            ],
          ),
        ),
      ],
    );
  }
}

void openGame(BuildContext context, String title, String description) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (_) => GamePage(title: title, description: description),
  ));
}

class GameTile extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final Color color;
  final VoidCallback onTap;
  const GameTile({super.key, required this.icon, required this.title,
    required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: panel, borderRadius: BorderRadius.circular(18),
          border: Border.all(color: gold.withOpacity(.35)),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircleAvatar(radius: 31, backgroundColor: color,
              child: Icon(icon, size: 34, color: gold)),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(
              color: Colors.white60, fontSize: 11)),
        ]),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  final String title, description;
  const GamePage({super.key, required this.title, required this.description});
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final random = Random();
  int score = 0;
  String result = 'Ready when you are!';

  void playRound() {
    setState(() {
      score += random.nextInt(10) + 1;
      result = widget.title == 'Lucky Reels'
          ? '✨  ${['🍀  🍋  ⭐', '💎  🍀  🍀', '⭐  ⭐  🍋'][random.nextInt(3)]}'
          : 'Nice round! Your practice score increased.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),
          backgroundColor: dark, foregroundColor: gold),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sports_esports, size: 72, color: gold),
            const SizedBox(height: 18),
            Text(widget.description, textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 15)),
            const SizedBox(height: 28),
            Container(
              width: double.infinity, padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: panel,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: gold.withOpacity(.4))),
              child: Column(children: [
                Text(result, textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 14),
                Text('Practice score: $score',
                    style: const TextStyle(color: gold, fontSize: 18)),
              ]),
            ),
            const SizedBox(height: 22),
            SizedBox(width: double.infinity,
              child: FilledButton.icon(
                onPressed: playRound,
                icon: const Icon(Icons.play_arrow),
                label: const Text('PLAY FREE ROUND'),
              )),
          ],
        ),
      ),
    );
  }
}

class InfoPage extends StatelessWidget {
  final String title, message;
  const InfoPage({super.key, required this.title, required this.message});
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(28),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.stars, color: gold, size: 56),
        const SizedBox(height: 14),
        Text(title, style: const TextStyle(fontSize: 24,
            fontWeight: FontWeight.bold, color: gold)),
        const SizedBox(height: 8),
        Text(message, textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70)),
      ]),
    ),
  );
}
