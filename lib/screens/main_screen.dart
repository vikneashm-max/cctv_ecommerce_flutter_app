import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
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
  
  late final ScrollController _productsScrollController = ScrollController();
  late final ScrollController _contactScrollController = ScrollController();
  late final ScrollController _accountScrollController = ScrollController();

  void _onTabTapped(int index) {
    if (_currentIndex == index) {
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
      backgroundColor: AppColors.foundation,
      extendBody: true, // Allow body to extend behind bottom nav
      appBar: AppBar(
        backgroundColor: AppColors.foundation.withOpacity(0.8),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        title: Row(
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.onSurface.withOpacity(0.05),
              ),
              child: ClipOval(
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.multiply),
                  child: Image.asset(
                    'assets/images/icon.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.shield_outlined, color: AppColors.primary, size: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "TN AUTOMATION",
              style: GoogleFonts.inter(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                fontSize: 16,
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
            Icons.shopping_bag_outlined, 
            CartService().cartItems, 
            () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
            }
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: screens[_currentIndex],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 90,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.surfaceLevel2.withOpacity(0.8),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.onSurfaceVariant.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.home_rounded, Icons.home_outlined, "HOME"),
                _buildNavItem(1, Icons.contact_support_rounded, Icons.contact_support_outlined, "CONTACT"),
                _buildNavItem(2, Icons.person_rounded, Icons.person_outline_rounded, "ACCOUNT"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData selectedIcon, IconData unselectedIcon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryContainer.withOpacity(0.15) : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              isSelected ? selectedIcon : unselectedIcon,
              color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
              size: 26,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
              color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarAction<T>(IconData icon, ValueListenable<List<T>> listenable, VoidCallback onTap) {
    return ValueListenableBuilder<List<T>>(
      valueListenable: listenable,
      builder: (context, items, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
             IconButton(
              icon: Icon(icon, color: AppColors.onSurface, size: 24),
              onPressed: onTap,
            ),
            if (items.isNotEmpty)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: AppColors.primaryContainer, shape: BoxShape.circle),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    '${items.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
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




