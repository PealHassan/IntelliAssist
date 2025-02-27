import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intelliassist/chatScreen.dart';
import 'package:intelliassist/history.dart';
import 'package:intelliassist/homePage.dart';
import 'package:intelliassist/settings.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    homePage(),
    chatScreen(""),
    HistoryPage(),
    AccountScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GNav(
            gap: 8,
            tabBackgroundGradient: LinearGradient(colors: [Colors.white,Color.fromARGB(255, 69, 65, 90)]),
            backgroundColor: Color.fromARGB(0, 110, 97, 168),
            color: Color.fromARGB(255, 99, 93, 130),
            activeColor: Colors.black,
            tabBackgroundColor: Color.fromARGB(255, 69, 152, 215),
            padding: EdgeInsets.all(10),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
                
              });
            },
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.chat,
                text: 'Chat',
              ),
              GButton(
                icon: Icons.history,
                text: 'History',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
