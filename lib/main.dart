import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/about_screen.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(const DividendCalculatorApp());
}

class DividendCalculatorApp extends StatelessWidget {
  const DividendCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Trust Dividend Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 39, 25, 77),
          onPrimary: Color.fromARGB(255, 254, 255, 240),
          secondary: Color(0xFF625B71),
          onSecondary: Color(0xFFFFFFFF),
          primaryContainer: Color.fromARGB(255, 77, 34, 126),
          onPrimaryContainer: Color.fromARGB(255, 210, 200, 243),
          secondaryContainer: Color.fromARGB(255, 159, 130, 207),
          onSecondaryContainer: Color(0xFF1C1B1F),
          surface: Color.fromARGB(255, 228, 219, 252),
          onSurface: Color.fromARGB(255, 28, 24, 38),
          error: Color(0xFFB3261E),
          onError: Color(0xFFFFFFFF),
        ),
        scaffoldBackgroundColor: const Color(0xFF18171C),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1; // Set Home as default (index 1)

  // Calculation history (latest first)
  final List<Map<String, dynamic>> _history = [];

  late List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      AboutScreen(),
      HomeScreen(
        onNewCalculation: (fund, rate, months, monthly, total) {
          setState(() {
            _history.insert(0, {
              'fund': fund,
              'rate': rate,
              'months': months,
              'monthlyDividend': monthly,
              'totalDividend': total,
              'timestamp': _formattedNow(),
            });
            if (_history.length > 10) _history.removeLast();
          });
        },
      ),
      HistoryScreen(history: _history),
    ];
  }

  String _formattedNow() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).colorScheme.primary;
    final Color onPrimary = Theme.of(context).colorScheme.onPrimary;
    return Scaffold(
      // The body is whichever page is selected
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: primary,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: onPrimary,
        unselectedItemColor: onPrimary.withAlpha((0.7 * 255).toInt()),
        selectedLabelStyle: TextStyle(color: onPrimary),
        unselectedLabelStyle: TextStyle(color: onPrimary.withAlpha((0.7 * 255).toInt())),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
        icon: Icon(Icons.info_outline),
        label: 'About',
          ),
          BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
          ),
          BottomNavigationBarItem(
        icon: Icon(Icons.history),
        label: 'History',
          ),
        ],
      ),
    );
  }
}
