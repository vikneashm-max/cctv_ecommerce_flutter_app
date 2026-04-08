import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'products_screen.dart';
import 'about_screen.dart';
import 'contact_screen.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';
import '../services/cart_service.dart';
import '../models/product.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  // Controllers for scroll-to-top feature
  late final ScrollController _productsScrollController = ScrollController();
  late final ScrollController _aboutScrollController = ScrollController();
  late final ScrollController _contactScrollController = ScrollController();

  void _onTabTapped(int index) {
    if (_currentIndex == index) {
      // Scroll to top if clicking the same tab
      ScrollController currentController;
      if (index == 0) currentController = _productsScrollController;
      else if (index == 1) currentController = _aboutScrollController;
      else currentController = _contactScrollController;

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
    _aboutScrollController.dispose();
    _contactScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      ProductsScreen(controller: _productsScrollController),
      AboutScreen(controller: _aboutScrollController),
      ContactScreen(controller: _contactScrollController),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF), // Subtle lavender tint background
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      // Animated Switcher for premium smooth page transitions
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOutSine,
        switchOutCurve: Curves.easeInSine,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: screens[_currentIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: _onTabTapped,
          backgroundColor: Colors.white,
          elevation: 0,
          indicatorColor: const Color(0xFF5538C9).withOpacity(0.12),
          height: 65,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: Color(0xFF5538C9)),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.info_outline),
              selectedIcon: Icon(Icons.info, color: Color(0xFF5538C9)),
              label: 'About',
            ),
            NavigationDestination(
              icon: Icon(Icons.contact_support_outlined),
              selectedIcon: Icon(Icons.contact_support, color: Color(0xFF5538C9)),
              label: 'Contact',
            ),
          ],
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
              icon: Icon(icon, color: Colors.black87),
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



