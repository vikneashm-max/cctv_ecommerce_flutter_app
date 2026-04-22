import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../widgets/animated_scale_card.dart';
import '../theme/app_colors.dart';
import 'product_detail_screen.dart';
import '../services/cart_service.dart';
import '../services/theme_service.dart';

class ProductsScreen extends StatefulWidget {
  final ScrollController controller;
  const ProductsScreen({super.key, required this.controller});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _selectedCategory = "All Products";
  String _sortBy = "Popularity";
  final PageController _bannerController = PageController();
  Timer? _bannerTimer;
  int _currentBannerPage = 0;

  @override
  void initState() {
    super.initState();
    _startBannerTimer();
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  void _startBannerTimer() {
    _bannerTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_bannerController.hasClients) {
        _currentBannerPage = (_currentBannerPage + 1) % 3;
        _bannerController.animateToPage(
          _currentBannerPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutQuart,
        );
      }
    });
  }

  final List<Product> _allProducts = [
    Product(name: "4K Night Vision Camera", category: "Surveillance", price: 24999, icon: Icons.videocam_rounded, rating: 4.9, popularity: 120, addedDate: DateTime(2023, 10, 1), images: ['new_design/home.png']),
    Product(name: "Smart Biometric Lock", category: "Access Control", price: 15499, icon: Icons.lock_rounded, rating: 4.8, popularity: 85, addedDate: DateTime(2023, 11, 5), images: ['new_design/product_detail.png']),
    Product(name: "Sentinel Hub Pro", category: "Ecosystem", price: 36999, icon: Icons.hub_rounded, rating: 4.7, popularity: 210, addedDate: DateTime(2023, 12, 10), images: ['new_design/product_description.png']),
    Product(name: "Neural IP Bullet", category: "Surveillance", price: 12500, icon: Icons.camera_alt_rounded, rating: 4.5, popularity: 120, addedDate: DateTime(2023, 10, 1), images: ['assets/images/camera_front.png']),
    Product(name: "AI Dome Camera", category: "Surveillance", price: 8800, icon: Icons.camera_indoor_rounded, rating: 4.2, popularity: 85, addedDate: DateTime(2023, 11, 5), images: ['assets/images/camera_side.png']),
    Product(name: "Quantum NVR 8CH", category: "Storage", price: 22500, icon: Icons.storage_rounded, rating: 4.7, popularity: 45, addedDate: DateTime(2023, 9, 15), images: ['assets/images/camera_box.png']),
  ];

  List<Product> _getProcessedProducts() {
    List<Product> list = _selectedCategory == "All Products"
        ? List<Product>.from(_allProducts)
        : _allProducts.where((p) => p.category == _selectedCategory).toList();

    switch (_sortBy) {
      case 'Price: Low → High': list.sort((a, b) => a.price.compareTo(b.price)); break;
      case 'Price: High → Low': list.sort((a, b) => b.price.compareTo(a.price)); break;
      default: list.sort((a, b) => b.popularity.compareTo(a.popularity)); break;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final displayProducts = _getProcessedProducts();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        controller: widget.controller,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Premium Search
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLevel1,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.onSurfaceVariant.withOpacity(0.05)),
                ),
                child: TextField(
                  style: GoogleFonts.inter(color: AppColors.onSurface),
                  decoration: InputDecoration(
                    hintText: "Search products...",
                    hintStyle: GoogleFonts.inter(color: AppColors.onSurfaceVariant.withOpacity(0.3), fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.5),
                    prefixIcon: Icon(Icons.search_rounded, color: AppColors.primary, size: 22),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 22),
                  ),
                ),
              ),
            ),

            // Featured Banner
            _buildEditorialBanner(),

            const SizedBox(height: 48),

            // Category Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "CATEGORIES",
                style: GoogleFonts.inter(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildCategoryChip("All Products"),
                  _buildCategoryChip("Surveillance"),
                  _buildCategoryChip("Access Control"),
                  _buildCategoryChip("Ecosystem"),
                  _buildCategoryChip("Storage"),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // Product Catalog
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "OUR\nPRODUCTS",
                    style: GoogleFonts.inter(
                      color: AppColors.onSurface,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1,
                    ),
                  ),
                  const Spacer(),
                  _buildSortDropdown(),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Product Pages
            SizedBox(
              height: 600,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.85),
                itemCount: displayProducts.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => _buildProductPage(displayProducts[index]),
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildProductPage(Product product) {
    return AnimatedScaleCard(
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)));
        },
        child: Container(
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: AppColors.surfaceLevel1,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: AppColors.onSurfaceVariant.withOpacity(0.05)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  child: Hero(
                    tag: product.name,
                    child: product.images.first.contains('new_design') 
                      ? Image.asset(product.images.first, fit: BoxFit.cover, width: double.infinity)
                      : Container(
                          width: double.infinity,
                          color: AppColors.surfaceLevel2,
                          child: Icon(product.icon, color: AppColors.primary.withOpacity(0.4), size: 120),
                        ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.category.toUpperCase(),
                        style: GoogleFonts.inter(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          height: 1.1,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "PRICE",
                                style: GoogleFonts.inter(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                "₹${product.price}",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22,
                                  color: AppColors.onSurface,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryContainer.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 24),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditorialBanner() {
    return SizedBox(
      height: 300,
      child: PageView(
        controller: _bannerController,
        onPageChanged: (index) => setState(() => _currentBannerPage = index),
        children: [
          _buildBannerSlide("FLASH SALE", "Smart Doorbells", "Secure your entrance with 4K clarity and instant alerts."),
          _buildBannerSlide("NEW ARRIVAL", "Neural Surveillance", "Advanced AI object detection for impenetrable monitoring."),
          _buildBannerSlide("PREMIUM HUB", "Sentinel Ecosystem", "Connect and control your entire security network from one place."),
        ],
      ),
    );
  }

  Widget _buildBannerSlide(String label, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.onSurfaceVariant.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(ThemeService().isDarkMode ? 0.3 : 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(32.0),
            decoration: BoxDecoration(
              color: AppColors.surfaceLevel2.withOpacity(ThemeService().isDarkMode ? 0.5 : 0.8),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.surfaceLevel2.withOpacity(0.4),
                  AppColors.surfaceLevel1.withOpacity(0.1),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: AppColors.onSurface,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    color: AppColors.onSurfaceVariant,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildCategoryChip(String label) {
    final bool isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.tertiary : AppColors.surfaceLevel1,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? AppColors.tertiary : AppColors.onSurfaceVariant.withOpacity(0.1)),
          boxShadow: isSelected ? [
            BoxShadow(
              color: AppColors.tertiary.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            )
          ] : null,
        ),
        child: Text(
          label.toUpperCase(),
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildSortDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceLevel1,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _sortBy,
          dropdownColor: AppColors.surfaceLevel2,
          icon: Icon(Icons.tune_rounded, size: 16, color: AppColors.primary),
          onChanged: (val) { if (val != null) setState(() => _sortBy = val); },
          items: ['Popularity', 'Price: Low → High', 'Price: High → Low']
              .map((val) => DropdownMenuItem(value: val, child: Text(val, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.onSurface)))).toList(),
        ),
      ),
    );
  }

}


