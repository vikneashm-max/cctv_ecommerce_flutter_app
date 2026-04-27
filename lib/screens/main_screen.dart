import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/cart_service.dart';
import '../theme/app_colors.dart';
import 'products_screen.dart';
import 'contact_screen.dart';
import 'account_screen.dart';
import 'favorites_screen.dart';
import 'cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  late final ScrollController _productsScrollController = ScrollController();
  late final ScrollController _contactScrollController = ScrollController();
  late final ScrollController _accountScrollController = ScrollController();

  void _onTabTapped(int index) {
    if (_currentIndex == index) {
      // Scroll to top smoothly if the same tab is tapped
      ScrollController? controller;
      switch (index) {
        case 0: controller = _productsScrollController; break;
        case 1: controller = _contactScrollController; break;
        case 2: controller = _accountScrollController; break;
      }
      
      if (controller != null && controller.hasClients) {
        controller.animateTo(
          0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutQuart,
        );
      }
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  void dispose() {
    _productsScrollController.dispose();
    _contactScrollController.dispose();
    _accountScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      ProductsScreen(
        controller: _productsScrollController,
        onTabChanged: (index) => setState(() => _currentIndex = index),
      ),
      ContactScreen(controller: _contactScrollController),
      AccountScreen(controller: _accountScrollController),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            Image.asset(
              'assets/images/icon.png',
              height: 32,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.shield_rounded, color: AppColors.primary, size: 28),
            ),
            const SizedBox(width: 10),
            Text(
              "TN Automation",
              style: GoogleFonts.manrope(
                color: const Color(0xFF0052FF),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_outline_rounded, color: Colors.grey[600], size: 24),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen())),
          ),
          ValueListenableBuilder<List>(
            valueListenable: CartService().cartItems,
            builder: (context, items, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart_outlined, color: Colors.grey[600], size: 24),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen())),
                  ),
                  if (items.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(color: Color(0xFF0052FF), shape: BoxShape.circle),
                        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Text(
                          '${items.length}',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey[400], size: 20),
                  hintText: "Search for cameras, security kits...",
                  hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          Expanded(
            child: screens[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_rounded, "Home"),
          _buildNavItem(1, Icons.build_rounded, "Service"),
          _buildNavItem(2, Icons.person_rounded, "Account"),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFF0F4FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: isSelected ? const Color(0xFF0052FF) : Colors.grey[400],
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? const Color(0xFF0052FF) : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
