import 'dart:async';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/animated_scale_card.dart';
import 'product_detail_screen.dart';
import '../services/cart_service.dart';

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
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_bannerController.hasClients) {
        _currentBannerPage = (_currentBannerPage + 1) % 2;
        _bannerController.animateToPage(
          _currentBannerPage,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutQuart,
        );
      }
    });
  }

  final List<Product> _allProducts = [
    // Cameras
    Product(name: "4MP IP Bullet Camera", category: "Cameras", price: 3500, icon: Icons.camera_alt_rounded, rating: 4.5, popularity: 120, addedDate: DateTime(2023, 10, 1)),
    Product(name: "2MP PTZ Dome Camera", category: "Cameras", price: 4800, icon: Icons.camera_indoor_rounded, rating: 4.2, popularity: 85, addedDate: DateTime(2023, 11, 5)),
    Product(name: "Outdoor Night Vision Cam", category: "Cameras", price: 5200, icon: Icons.nightlight_round, rating: 4.8, popularity: 210, addedDate: DateTime(2023, 12, 10)),
    Product(name: "Wifi Smart Link Camera", category: "Cameras", price: 3100, icon: Icons.wifi_tethering_rounded, rating: 3.9, popularity: 60, addedDate: DateTime(2024, 1, 2)),
    // Recording Devices
    Product(name: "8-Channel 4K NVR", category: "Recording Devices", price: 12500, icon: Icons.security_rounded, rating: 4.7, popularity: 45, addedDate: DateTime(2023, 9, 15)),
    Product(name: "16-Channel HD DVR", category: "Recording Devices", price: 8500, icon: Icons.videocam_rounded, rating: 4.1, popularity: 30, addedDate: DateTime(2023, 11, 20)),
    Product(name: "Smart Hybrid XVR", category: "Recording Devices", price: 15400, icon: Icons.settings_system_daydream_rounded, rating: 4.6, popularity: 15, addedDate: DateTime(2024, 2, 1)),
    // Storage
    Product(name: "2TB Surveillance HDD", category: "Storage", price: 6800, icon: Icons.storage_rounded, rating: 4.9, popularity: 300, addedDate: DateTime(2023, 8, 5)),
    Product(name: "4TB SkyHawk Drive", category: "Storage", price: 9200, icon: Icons.save_rounded, rating: 4.8, popularity: 150, addedDate: DateTime(2023, 12, 1)),
    Product(name: "128GB High Endurance SD", category: "Storage", price: 3200, icon: Icons.sd_card_rounded, rating: 4.3, popularity: 500, addedDate: DateTime(2024, 1, 15)),
    // Power Supply
    Product(name: "8-Port POE Switch 120W", category: "Power Supply Element", price: 4200, icon: Icons.power_rounded, rating: 4.4, popularity: 80, addedDate: DateTime(2023, 10, 25)),
    Product(name: "Security Power Box 10A", category: "Power Supply Element", price: 5400, icon: Icons.settings_input_component_rounded, rating: 4.0, popularity: 40, addedDate: DateTime(2023, 11, 30)),
    Product(name: "Outdoor Waterproof Box", category: "Power Supply Element", price: 3100, icon: Icons.battery_charging_full_rounded, rating: 3.8, popularity: 95, addedDate: DateTime(2024, 1, 5)),
    // Networking
    Product(name: "Gigabit Ethernet Router", category: "Networking Equipment", price: 4500, icon: Icons.router_rounded, rating: 4.3, popularity: 110, addedDate: DateTime(2023, 11, 10)),
    Product(name: "Long Range Wi-Fi Bridge", category: "Networking Equipment", price: 18500, icon: Icons.settings_input_antenna_rounded, rating: 4.7, popularity: 25, addedDate: DateTime(2023, 12, 25)),
    Product(name: "Industrial Fiber Switch", category: "Networking Equipment", price: 22400, icon: Icons.hub_rounded, rating: 4.9, popularity: 10, addedDate: DateTime(2024, 3, 10)),
    // Display
    Product(name: "21.5-inch LED Monitor", category: "Display", price: 8500, icon: Icons.monitor_rounded, rating: 4.2, popularity: 70, addedDate: DateTime(2023, 11, 15)),
    Product(name: "32-inch 4K Security TV", category: "Display", price: 24500, icon: Icons.tv_rounded, rating: 4.8, popularity: 20, addedDate: DateTime(2024, 1, 20)),
    Product(name: "Dual-Display VGA Box", category: "Display", price: 6200, icon: Icons.screenshot_monitor_rounded, rating: 3.7, popularity: 55, addedDate: DateTime(2024, 2, 10)),
  ];

  List<Product> _getProcessedProducts() {
    List<Product> list = _selectedCategory == "All Products"
        ? List<Product>.from(_allProducts)
        : _allProducts.where((p) => p.category == _selectedCategory).toList();

    switch (_sortBy) {
      case 'Price: Low → High': list.sort((a, b) => a.price.compareTo(b.price)); break;
      case 'Price: High → Low': list.sort((a, b) => b.price.compareTo(a.price)); break;
      case 'Newest First': list.sort((a, b) => b.addedDate.compareTo(a.addedDate)); break;
      case 'Rating (High → Low)': list.sort((a, b) => b.rating.compareTo(a.rating)); break;
      case 'Rating (Low → High)': list.sort((a, b) => a.rating.compareTo(b.rating)); break;
      case 'Popularity': default: list.sort((a, b) => b.popularity.compareTo(a.popularity)); break;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final displayProducts = _getProcessedProducts();
    return Scaffold(
      backgroundColor: Colors.transparent, // Background handled by MainScreen or Theme
      body: SingleChildScrollView(
        controller: widget.controller,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Premium Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5538C9).withOpacity(0.08),
                      blurRadius: 25,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search security equipment...",
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 15, fontWeight: FontWeight.w400),
                    prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF5538C9), size: 22),
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF5538C9).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(Icons.tune_rounded, color: Color(0xFF5538C9), size: 18),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 17),
                  ),
                ),
              ),
            ),

            // Hero Promotion Section
            _buildHeroBanner(),

            const SizedBox(height: 32),

            // Categories Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Categories", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                  TextButton(
                    onPressed: () => setState(() => _selectedCategory = "All Products"),
                    style: TextButton.styleFrom(foregroundColor: const Color(0xFF5538C9)),
                    child: const Text("See All", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20, right: 20),
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildCategoryChip(Icons.grid_view_rounded, "All Products"),
                  _buildCategoryChip(Icons.camera_alt_rounded, "Cameras"),
                  _buildCategoryChip(Icons.videocam_rounded, "Recording Devices"),
                  _buildCategoryChip(Icons.storage_rounded, "Storage"),
                  _buildCategoryChip(Icons.power_rounded, "Power Supply Element"),
                  _buildCategoryChip(Icons.router_rounded, "Networking Equipment"),
                  _buildCategoryChip(Icons.monitor_rounded, "Display"),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Products Grid Section Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_selectedCategory, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -1)),
                      Text("${displayProducts.length} premium products", style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const Spacer(),
                  _buildSortDropdown(),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Products Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.68,
                ),
                itemBuilder: (context, index) => _buildProductCard(displayProducts[index]),
              ),
            ),
            const SizedBox(height: 100), // More bottom space
          ],
        ),
      ),
    );
  }

  Widget _buildHeroBanner() {
    return SizedBox(
      height: 170,
      child: PageView(
        controller: _bannerController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) => _currentBannerPage = index,
        children: [
          _buildBannerItem(
            "Security Reimagined",
            "Up to 40% OFF on IP Systems",
            const Color(0xFF5538C9),
            const Color(0xFF7C61EF),
            'assets/images/cctv_banner_1.png',
          ),
          _buildBannerItem(
            "Smart Monitoring",
            "New AI Cameras Arrived",
            const Color(0xFF1E40AF),
            const Color(0xFF3B82F6),
            'assets/images/cctv_banner_2.png',
          ),
        ],
      ),
    );
  }

  Widget _buildBannerItem(String title, String subtitle, Color color1, Color color2, String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: color1.withOpacity(0.35),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              bottom: -10,
              child: Image.asset(
                imagePath,
                height: 150,
                fit: BoxFit.contain,
                color: Colors.white.withOpacity(0.9),
                colorBlendMode: BlendMode.modulate, // Helps blend white background if any
                errorBuilder: (context, error, stackTrace) => Icon(Icons.security, size: 140, color: Colors.white.withOpacity(0.15)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text("LIMITED OFFER", style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 1.2)),
                  ),
                  const SizedBox(height: 16),
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, height: 1.1)),
                  const SizedBox(height: 6),
                  Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 15, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(IconData icon, String label) {
    final bool isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuart,
        margin: const EdgeInsets.only(right: 14),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5538C9) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            if (isSelected)
              BoxShadow(color: const Color(0xFF5538C9).withOpacity(0.25), blurRadius: 15, offset: const Offset(0, 6))
            else
              BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4)),
          ],
          border: Border.all(
            color: isSelected ? const Color(0xFF5538C9) : Colors.white,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : const Color(0xFF5538C9), size: 20),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _sortBy,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Color(0xFF5538C9)),
          onChanged: (val) { if (val != null) setState(() => _sortBy = val); },
          borderRadius: BorderRadius.circular(16),
          items: ['Popularity', 'Price: Low → High', 'Price: High → Low', 'Newest First', 'Rating (High → Low)']
              .map((val) => DropdownMenuItem(value: val, child: Text(val, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700)))).toList(),
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return AnimatedScaleCard(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => ProductDetailScreen(product: product),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(animation),
                    child: child,
                  ),
                );
              },
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF5538C9).withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [const Color(0xFFF6F8FE), Colors.grey.shade50],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Center(
                        child: Hero(
                          tag: product.name,
                          child: Icon(product.icon, color: const Color(0xFF5538C9).withOpacity(0.25), size: 60),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 18,
                      right: 18,
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9), 
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
                        ),
                        child: const Icon(Icons.favorite_border_rounded, size: 17, color: Colors.grey),
                      ),
                    ),
                    if (product.popularity > 200)
                      Positioned(
                        top: 18,
                        left: 18,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [Color(0xFFFF9900), Color(0xFFFFB800)]),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [BoxShadow(color: const Color(0xFFFF9900).withOpacity(0.3), blurRadius: 8)],
                          ),
                          child: const Text("HOT", style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Row(
                      children: [
                        Icon(Icons.star_rounded, color: Colors.amber.shade700, size: 16),
                        const SizedBox(width: 4),
                        Text(product.rating.toString(), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: -0.3)),
                    const SizedBox(height: 2),
                    Text(product.category.toUpperCase(), style: TextStyle(color: Colors.grey.shade400, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("₹${product.price}", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 19, color: Color(0xFF5538C9))),
                        GestureDetector(
                          onTap: () {
                            CartService().addToCart(product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(Icons.check_circle_rounded, color: Colors.white, size: 18),
                                    const SizedBox(width: 10),
                                    const Text("Added to Cart"),
                                  ],
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: const Color(0xFF333333),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                duration: const Duration(seconds: 1),
                                margin: const EdgeInsets.all(20),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(9),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5538C9),
                              boxShadow: [
                                 BoxShadow(color: const Color(0xFF5538C9).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 5)),
                              ],
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

