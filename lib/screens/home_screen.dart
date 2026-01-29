import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. The Master List of all categories
  final List<Map<String, dynamic>> allCategories = const [
    {'name': 'Electrical', 'icon': Icons.bolt, 'color': Color(0xFF00D2FF)},
    {'name': 'Plumbing', 'icon': Icons.water_drop, 'color': Color(0xFF3A7BD5)},
    {'name': 'Home Cleaning', 'icon': Icons.cleaning_services, 'color': Color(0xFF00FF87)},
    {'name': 'Wall Painting', 'icon': Icons.format_paint, 'color': Color(0xFFFF5F6D)},
    {'name': 'Lawn Care', 'icon': Icons.yard, 'color': Color(0xFF6A11CB)},
    {'name': 'AC Specialist', 'icon': Icons.ac_unit, 'color': Color(0xFF2193B0)},
    {'name': 'Carpentry', 'icon': Icons.handyman, 'color': Color(0xFFED6A5A)},
    {'name': 'Smart Tech', 'icon': Icons.settings_remote, 'color': Color(0xFF4CA1AF)},
    {'name': 'Auto Care', 'icon': Icons.directions_car, 'color': Color(0xFF2C3E50)},
    {'name': 'Security', 'icon': Icons.security, 'color': Color(0xFFF09819)},
  ];

  // 2. The list that the UI actually displays
  List<Map<String, dynamic>> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    // At the start, show everything
    filteredCategories = allCategories;
  }

  // 3. Search logic function
  void _runFilter(String keyword) {
    List<Map<String, dynamic>> results = [];
    if (keyword.isEmpty) {
      results = allCategories;
    } else {
      results = allCategories
          .where((item) =>
              item["name"].toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      filteredCategories = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    
    // Dynamic column count for Web vs Mobile
    int crossAxisCount = width < 600 ? 2 : (width < 1000 ? 3 : 5);
    double hPadding = width > 1000 ? width * 0.12 : 16.0;

    return CustomScrollView(
      slivers: [
        // --- COOL SLIDING HEADER ---
        _buildHeader(context, width),

        // --- PROMO BANNER ---
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: 25),
            child: _buildPromoBanner(),
          ),
        ),

        // --- SECTION TITLE ---
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: hPadding),
          sliver: SliverToBoxAdapter(
            child: const Text(
              "Recommended Services",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1A1A2E)),
            ),
          ),
        ),

        // --- DYNAMIC GRID ---
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: 15),
          sliver: filteredCategories.isNotEmpty
              ? SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildServiceCard(filteredCategories[index]),
                    childCount: filteredCategories.length,
                  ),
                )
              : const SliverToBoxAdapter(
                  child: Center(child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text("No services match your search."),
                  )),
                ),
        ),

        // Bottom spacing for scroll
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  // UI Components inside the Home Screen class
  Widget _buildHeader(BuildContext context, double width) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFF1A1A2E),
      // leading icon that opens the drawer from MainWrapper
      leading: IconButton(
        icon: const Icon(Icons.notes_rounded, color: Colors.white, size: 28),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              const Text("SevaX", style: TextStyle(color: Color(0xFF00D2FF), fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: 4)),
              const SizedBox(height: 15),
              _buildSearchInput(width),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchInput(double width) {
    return Container(
      width: width * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white10),
      ),
      child: TextField(
        onChanged: (val) => _runFilter(val),
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: "What are you looking for?",
          hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
          border: InputBorder.none,
          icon: Icon(Icons.search_rounded, color: Color(0xFF00D2FF)),
        ),
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: item['color'].withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: item['color'].withOpacity(0.1),
            child: Icon(item['icon'], color: item['color'], size: 28),
          ),
          const SizedBox(height: 12),
          Text(item['name'], textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF00D2FF), Color(0xFF3A7BD5)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.stars_rounded, color: Colors.white, size: 30),
          SizedBox(width: 15),
          Expanded(child: Text("UP TO 30% OFF ON HOME CLEANING", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}