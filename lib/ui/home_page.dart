import 'package:flutter/material.dart';
import 'package:orm_risk_assessment/ui/assessment_tab.dart';
import 'package:orm_risk_assessment/ui/history_tab.dart';
import 'package:orm_risk_assessment/ui/landing_page.dart';
import 'package:orm_risk_assessment/ui/reference_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    AssessmentTab(),
    HistoryTab(),
    ReferenceTab(),
  ];

  void _goToLanding() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const LandingPage(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 450),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        leadingWidth: 120,
        title: const Text(
          'ORM SHEET',
          overflow: TextOverflow.visible,
          softWrap: false,
        ),
        backgroundColor: const Color(0xFF191970),
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Image.asset(
            'assets/images/left.png',
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/images/right.png',
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: _tabs[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFF191970), width: 2),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex + 1,
          onTap: (index) {
            if (index == 0) {
              _goToLanding();
            } else if (index > 0 && index < 4) {
              setState(() {
                _currentIndex = index - 1;
              });
            }
          },
          backgroundColor: const Color(0xFF080838),
          selectedItemColor: const Color(0xFF4169E1),
          unselectedItemColor: const Color(0xFF888888),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.security),
              label: 'Risk Assessment',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.table_chart),
              label: 'Reference Tables',
            ),
          ],
        ),
      ),
    );
  }
}
