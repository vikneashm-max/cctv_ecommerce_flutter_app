import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'products_screen.dart';
import 'contact_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import '../services/cart_service.dart';

import 'account_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  // Controllers for scroll-to-top feature
  late final ScrollController _productsScrollController = ScrollController();
  late final ScrollController _contactScrollController = ScrollController();
  late final ScrollController _accountScrollController = ScrollController();

  void _onTabTapped(int index) {
    if (_currentIndex == index) {
      // Scroll to top if clicking the same tab
      ScrollController currentController;
      if (index == 0) currentController = _productsScrollController;
      else if (index == 1) currentController = _contactScrollController;
      else currentController = _accountScrollController;

      if (currentController.hasClients) {
        currentController.animateTo(
          0,
          duration: const Duration(milliseconds: 700),
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
      ProductsScreen(controller: _productsScrollController),
      ContactScreen(controller: _contactScrollController),
      AccountScreen(controller: _accountScrollController),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Use theme background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            Image.asset(
              'assets/images/icon.png',
              height: 32,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.security, color: Color(0xFF5538C9)),
            ),
            const SizedBox(width: 10),
            const Text(
              "TN AUTOMATION",
              style: TextStyle(
                color: Color(0xFF5538C9),
                fontWeight: FontWeight.w900,
                letterSpacing: 0.8,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          _buildAppBarAction(
            Icons.favorite_outline_rounded, 
            CartService().favoriteItems, 
            () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesScreen()));
            }
          ),
          _buildAppBarAction(
            Icons.shopping_cart_outlined, 
            CartService().cartItems, 
            () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
            }
          ),
          const SizedBox(width: 8),
        ],
      ),
      // Improved Page Transition Animation
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (Widget child, Animation<double> animation) {
          final fadeAnimation = CurvedAnimation(
            parent: animation,
            curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
          );
          final scaleAnimation = Tween<double>(begin: 0.98, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          );
          
          return FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: screens[_currentIndex],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.3), width: 1.5)),
            ),
            child: NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: _onTabTapped,
              backgroundColor: Colors.transparent,
              elevation: 0,
              indicatorColor: const Color(0xFF7039F7).withOpacity(0.12),
              height: 70,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home_rounded, color: Color(0xFF7039F7)),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.contact_support_outlined),
                  selectedIcon: Icon(Icons.contact_support_rounded, color: Color(0xFF7039F7)),
                  label: 'Contact',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline_rounded),
                  selectedIcon: Icon(Icons.person_rounded, color: Color(0xFF7039F7)),
                  label: 'Account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildAppBarAction<T>(IconData icon, ValueListenable<List<T>> listenable, VoidCallback onTap) {
    return ValueListenableBuilder<List<T>>(
      valueListenable: listenable,
      builder: (context, items, child) {
        return Stack(
          children: [
             IconButton(
              icon: Icon(icon, color: Color(0xFF2A1263)),
              onPressed: onTap,
            ),
            if (items.isNotEmpty)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
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
    );
  }
}



