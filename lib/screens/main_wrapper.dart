import 'package:flutter/material.dart';
import 'home_screen.dart'; 
import 'search_screen.dart';
import 'account_screen.dart';
import 'booking_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  // This variable tracks which tab is currently selected
  int _selectedIndex = 0;

  // This list holds the different "Pages" of your app
  // When _selectedIndex is 0, it shows HomeScreen.
  // When it's 1, it shows the "Search" placeholder, and so on.
  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const BookingScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- THE DRAWER (Side Menu) ---
      // Placing it here makes it accessible from ALL pages in the _pages list.
      drawer: Drawer(
        backgroundColor: const Color(0xFF1A1A2E),
        child: Column(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text("SevaX Menu", style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text("Settings", style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      // --- THE BODY ---
      // This displays the screen corresponding to the current index
      body: _pages[_selectedIndex],

      // --- THE BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Tells the bar which icon to highlight
        onTap: (index) {
          // This function runs when you tap an icon
          setState(() {
            _selectedIndex = index; // Updates the index and rebuilds the UI
          });
        },
        type: BottomNavigationBarType.fixed, // Keeps all icons visible
        selectedItemColor: const Color(0xFF00D2FF), // Cool Blue
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Bookings"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}