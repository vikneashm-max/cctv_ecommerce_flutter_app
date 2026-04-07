import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const TNAutomationApp());
}

class Product {
  final String name;
  final String category;
  final int price;
  final IconData icon;
  final double rating;
  final int popularity;
  final DateTime addedDate;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.icon,
    required this.rating,
    required this.popularity,
    required this.addedDate,
  });
}

class TNAutomationApp extends StatelessWidget {
  const TNAutomationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TN Automation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF5538C9),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5538C9)),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainScreen(),
    );
  }
}

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
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87),
            onPressed: () {},
          ),
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
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: _onTabTapped,
        backgroundColor: Colors.white,
        elevation: 10,
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
    );
  }
}

class ProductsScreen extends StatefulWidget {
  final ScrollController controller;
  const ProductsScreen({super.key, required this.controller});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _selectedCategory = "All Products";
  String _sortBy = "Popularity";

  final List<Product> _allProducts = [
    // Cameras
    Product(name: "4MP IP Bullet Camera", category: "Cameras", price: 3500, icon: Icons.camera_alt, rating: 4.5, popularity: 120, addedDate: DateTime(2023, 10, 1)),
    Product(name: "2MP PTZ Dome Camera", category: "Cameras", price: 4800, icon: Icons.camera_indoor, rating: 4.2, popularity: 85, addedDate: DateTime(2023, 11, 5)),
    Product(name: "Outdoor Night Vision Cam", category: "Cameras", price: 5200, icon: Icons.nightlight_round, rating: 4.8, popularity: 210, addedDate: DateTime(2023, 12, 10)),
    Product(name: "Wifi Smart Link Camera", category: "Cameras", price: 3100, icon: Icons.wifi_tethering, rating: 3.9, popularity: 60, addedDate: DateTime(2024, 1, 2)),
    // Recording Devices
    Product(name: "8-Channel 4K NVR", category: "Recording Devices", price: 12500, icon: Icons.security, rating: 4.7, popularity: 45, addedDate: DateTime(2023, 9, 15)),
    Product(name: "16-Channel HD DVR", category: "Recording Devices", price: 8500, icon: Icons.videocam, rating: 4.1, popularity: 30, addedDate: DateTime(2023, 11, 20)),
    Product(name: "Smart Hybrid XVR", category: "Recording Devices", price: 15400, icon: Icons.settings_system_daydream, rating: 4.6, popularity: 15, addedDate: DateTime(2024, 2, 1)),
    // Storage
    Product(name: "2TB Surveillance HDD", category: "Storage", price: 6800, icon: Icons.storage, rating: 4.9, popularity: 300, addedDate: DateTime(2023, 8, 5)),
    Product(name: "4TB SkyHawk Drive", category: "Storage", price: 9200, icon: Icons.save, rating: 4.8, popularity: 150, addedDate: DateTime(2023, 12, 1)),
    Product(name: "128GB High Endurance SD", category: "Storage", price: 3200, icon: Icons.sd_card, rating: 4.3, popularity: 500, addedDate: DateTime(2024, 1, 15)),
    // Power Supply
    Product(name: "8-Port POE Switch 120W", category: "Power Supply Element", price: 4200, icon: Icons.power, rating: 4.4, popularity: 80, addedDate: DateTime(2023, 10, 25)),
    Product(name: "Security Power Box 10A", category: "Power Supply Element", price: 5400, icon: Icons.settings_input_component, rating: 4.0, popularity: 40, addedDate: DateTime(2023, 11, 30)),
    Product(name: "Outdoor Waterproof Box", category: "Power Supply Element", price: 3100, icon: Icons.battery_charging_full, rating: 3.8, popularity: 95, addedDate: DateTime(2024, 1, 5)),
    // Networking
    Product(name: "Gigabit Ethernet Router", category: "Networking Equipment", price: 4500, icon: Icons.router, rating: 4.3, popularity: 110, addedDate: DateTime(2023, 11, 10)),
    Product(name: "Long Range Wi-Fi Bridge", category: "Networking Equipment", price: 18500, icon: Icons.settings_input_antenna, rating: 4.7, popularity: 25, addedDate: DateTime(2023, 12, 25)),
    Product(name: "Industrial Fiber Switch", category: "Networking Equipment", price: 22400, icon: Icons.hub, rating: 4.9, popularity: 10, addedDate: DateTime(2024, 3, 10)),
    // Display
    Product(name: "21.5-inch LED Monitor", category: "Display", price: 8500, icon: Icons.monitor, rating: 4.2, popularity: 70, addedDate: DateTime(2023, 11, 15)),
    Product(name: "32-inch 4K Security TV", category: "Display", price: 24500, icon: Icons.tv, rating: 4.8, popularity: 20, addedDate: DateTime(2024, 1, 20)),
    Product(name: "Dual-Display VGA Box", category: "Display", price: 6200, icon: Icons.screenshot_monitor, rating: 3.7, popularity: 55, addedDate: DateTime(2024, 2, 10)),
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: widget.controller, // Connected controller
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Search for cameras, DVRs, etc...",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHorizontalCategoryItem(Icons.grid_view_rounded, "All Products"),
                        _buildHorizontalCategoryItem(Icons.camera_alt, "Cameras"),
                        _buildHorizontalCategoryItem(Icons.videocam, "Recording Devices"),
                        _buildHorizontalCategoryItem(Icons.storage, "Storage"),
                        _buildHorizontalCategoryItem(Icons.power, "Power Supply Element"),
                        _buildHorizontalCategoryItem(Icons.router, "Networking Equipment"),
                        _buildHorizontalCategoryItem(Icons.monitor, "Display"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(_selectedCategory, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        ),
                        _buildSortDropdown(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
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
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _sortBy,
          icon: const Icon(Icons.sort_rounded, size: 18, color: Color(0xFF5538C9)),
          onChanged: (val) { if (val != null) setState(() => _sortBy = val); },
          items: ['Popularity', 'Price: Low → High', 'Price: High → Low', 'Newest First', 'Rating (High → Low)', 'Rating (Low → High)']
              .map((val) => DropdownMenuItem(value: val, child: Text(val, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)))).toList(),
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    return _AnimatedScaleCard(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 40, offset: const Offset(0, 20)),
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: const BorderRadius.vertical(top: Radius.circular(16))),
                child: Icon(product.icon, color: Colors.grey.shade300, size: 48),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, height: 1.2)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      ...List.generate(5, (index) => Icon(index < product.rating.floor() ? Icons.star : Icons.star_border, color: Colors.amber, size: 14)),
                      const SizedBox(width: 4),
                      Text(product.rating.toString(), style: TextStyle(color: Colors.grey.shade600, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(product.category, style: TextStyle(color: Colors.grey.shade500, fontSize: 10)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("₹ ${product.price}", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF5538C9))),
                      Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFF5538C9), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.add, color: Colors.white, size: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalCategoryItem(IconData icon, String label) {
    final bool isSelected = _selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: InkWell(
        onTap: () => setState(() => _selectedCategory = label),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(color: isSelected ? const Color(0xFF5538C9) : const Color(0xFFF0F2FF), borderRadius: BorderRadius.circular(16)),
              child: Icon(icon, color: isSelected ? Colors.white : const Color(0xFF5538C9), size: 24),
            ),
            const SizedBox(height: 8),
            SizedBox(width: 72, child: Text(label, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500, color: isSelected ? const Color(0xFF5538C9) : Colors.black87, height: 1.1))),
          ],
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  final ScrollController controller;
  const AboutScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              child: _buildTextCard(
                "About TN Automation",
                "Smart CCTV Solutions for Modern Security\n\nWe provide advanced surveillance systems including HD cameras, AI-enabled monitoring, and complete security solutions for homes and businesses.",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextCard("Our Mission", "At TN Automation, our mission is to deliver reliable and intelligent security solutions that protect what matters most. We aim to make modern surveillance accessible, affordable, and easy to use for everyone."),
                  const SizedBox(height: 48),
                  const Text("Our Values", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  _buildIconCard(Icons.verified_user_outlined, "Security", "We prioritize safety with high-quality surveillance systems."),
                  const SizedBox(height: 16),
                  _buildIconCard(Icons.memory_outlined, "Innovation", "We integrate the latest AI and smart monitoring technologies."),
                  const SizedBox(height: 16),
                  _buildIconCard(Icons.beenhere_outlined, "Reliability", "Our products are tested for long-term durability and performance."),
                  const SizedBox(height: 16),
                  _buildIconCard(Icons.support_agent_outlined, "Customer Support", "We provide installation guidance and 24/7 support."),
                  const SizedBox(height: 48),
                  _buildTextCard("Why Choose Us?", "With years of experience in the CCTV and security industry, TN Automation understands the importance of protection and reliability. We offer a wide range of products including bullet cameras, dome cameras, DVR/NVR systems, and complete installation services."),
                  const SizedBox(height: 48),
                  const Text("Security Features", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: _buildSmallFeatureCard(Icons.camera_alt_outlined, "HD Camera Systems")),
                      const SizedBox(width: 16),
                      Expanded(child: _buildSmallFeatureCard(Icons.nightlight_round_outlined, "Night Vision Technology")),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildSmallFeatureCard(Icons.smartphone_outlined, "Mobile Monitoring")),
                      const SizedBox(width: 16),
                      Expanded(child: _buildSmallFeatureCard(Icons.build_outlined, "Easy Installation")),
                    ],
                  ),
                  const SizedBox(height: 48),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                    decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      children: [
                        const Text("Our Service Process", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        const SizedBox(height: 8),
                        Text("Simple, fast and professional CCTV Installation workflow", style: TextStyle(color: Colors.grey.shade600, fontSize: 14), textAlign: TextAlign.center),
                        const SizedBox(height: 48),
                        _buildProcessStep("STEP 1", Icons.phone_in_talk_outlined, "Consultation", "Share your security needs and get expert CCTV recommendations for your space."),
                        const SizedBox(height: 24),
                        _buildProcessStep("STEP 2", Icons.location_on_outlined, "Site Inspection", "Our team evaluates your location and suggests ideal camera positions and coverage."),
                        const SizedBox(height: 24),
                        _buildProcessStep("STEP 3", Icons.rocket_launch_outlined, "Fast Installation", "Quick and clean installation by our certified technicians with minimal disruption."),
                        const SizedBox(height: 24),
                        _buildProcessStep("STEP 4", Icons.verified_outlined, "Setup & Demo", "We configure mobile monitoring and provide a complete walkthrough of your new system."),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextCard(String title, String text) {
    return _AnimatedScaleCard(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 50, offset: const Offset(0, 25)),
            BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 15, offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2563EB))),
            const SizedBox(height: 12),
            Text(text, style: TextStyle(fontSize: 15, color: Colors.grey.shade700, height: 1.6)),
          ],
        ),
      ),
    );
  }

  Widget _buildIconCard(IconData icon, String title, String text) {
    return _AnimatedScaleCard(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 35, offset: const Offset(0, 15)),
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFF2563EB).withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: const Color(0xFF2563EB), size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(text, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.4)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallFeatureCard(IconData icon, String label) {
    return _AnimatedScaleCard(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 20, offset: const Offset(0, 8))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF2563EB), size: 32),
            const SizedBox(height: 12),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, height: 1.2)),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessStep(String step, IconData icon, String title, String text) {
    return _AnimatedScaleCard(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 25, offset: const Offset(0, 10))],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: const Color(0xFF2563EB), borderRadius: BorderRadius.circular(20)),
                  child: Text(step, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
                const Spacer(),
                Icon(icon, color: const Color(0xFF2563EB), size: 24),
              ],
            ),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.4)),
          ],
        ),
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  final ScrollController controller;
  const ContactScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
              child: _AnimatedScaleCard(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 60, offset: const Offset(0, 30)),
                      BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Get In Touch", style: TextStyle(color: Color(0xFF5538C9), fontSize: 13, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text("Contact Us", style: TextStyle(color: Colors.black87, fontSize: 32, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 12),
                      Text("Have questions about our CCTV products or services? Our team is here to help you secure your space.", style: TextStyle(color: Colors.grey.shade600, fontSize: 15, height: 1.5)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _AnimatedScaleCard(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade100),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 60, offset: const Offset(0, 30)),
                          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildContactCard(Icons.location_on_outlined, "Visit Us", "2/206, main road, Thittai, Sirkali, Tamil Nadu 609111"),
                          const Divider(height: 48),
                          _buildContactCard(Icons.phone_outlined, "Call Us", "+91 97863 37243"),
                          const Divider(height: 48),
                          _buildContactCard(Icons.email_outlined, "Email Us", "tnautomations@gmail.com"),
                          const Divider(height: 48),
                          _buildContactCard(Icons.access_time, "Working Hours", "Mon - Sat: 9:00 AM - 8:00 PM\nSunday: Closed"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.facebook, color: Color(0xFF5538C9), size: 30),
                      SizedBox(width: 24),
                      Icon(Icons.camera_alt, color: Color(0xFF5538C9), size: 30),
                      SizedBox(width: 24),
                      Icon(Icons.business, color: Color(0xFF5538C9), size: 30),
                    ],
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String title, String text) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF5538C9), size: 32),
        const SizedBox(height: 16),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(text, textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600, fontSize: 16, height: 1.5)),
      ],
    );
  }
}

// Custom Premium Animation Wrapper for Cards
class _AnimatedScaleCard extends StatefulWidget {
  final Widget child;
  const _AnimatedScaleCard({required this.child});

  @override
  _AnimatedScaleCardState createState() => _AnimatedScaleCardState();
}

class _AnimatedScaleCardState extends State<_AnimatedScaleCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 150));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
    );
  }
}
