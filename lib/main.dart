import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TN Automation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5538C9),
          primary: const Color(0xFF5538C9),
        ),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
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
  final ScrollController _homeScrollController = ScrollController();

  void _onTabTapped(int index) {
    if (index == 0 && _currentIndex == 0) {
      // If Home is tapped while already on Home, scroll to top
      _homeScrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  void dispose() {
    _homeScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/images/icon.png', height: 28, width: 40, fit: BoxFit.contain),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                "TN AUTOMATION",
                style: TextStyle(
                  color: Color(0xFF5538C9),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.build_outlined), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: 'About'),
          BottomNavigationBarItem(icon: Icon(Icons.contact_support_outlined), label: 'Contact'),
        ],
        selectedItemColor: const Color(0xFF5538C9),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeBody(),
          const ProductsScreen(),
          const ServicesScreen(),
          const AboutScreen(),
          const ContactScreen(),
        ],
      ),
    );
  }

  Widget _buildHomeBody() {
    return SingleChildScrollView(
      controller: _homeScrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeroSection(context),
          const SizedBox(height: 32),
          _buildFeaturesSection(),
          const SizedBox(height: 48),
          _buildShopByCategory(),
          const SizedBox(height: 48),
          _buildRecentProducts(),
          const SizedBox(height: 48),
          _buildWhyChooseUs(),
          const SizedBox(height: 48),
          _buildServices(),
          const SizedBox(height: 48),
          _buildTestimonials(),
          const SizedBox(height: 48),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      color: const Color(0xFF5538C9),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Advanced CCTV Security for Modern Protection",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "From HD surveillance cameras to complete installation and support, TN Automation helps you secure every corner with confidence.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              ElevatedButton(
                onPressed: () => _onTabTapped(1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: const Text("Shop Cameras"),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Get Free Consultation", textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Hero Image
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage('assets/images/hero.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.25,
        children: [
          _buildFeatureCard(Icons.check_circle_outline, "Free\nInstallation", "Available on\nselected plans"),
          _buildFeatureCard(Icons.support_agent, "24/7 Support", "Always-on customer\nassistance"),
          _buildFeatureCard(Icons.verified_user_outlined, "1 Year\nWarranty", "Peace of mind on\nevery purchase"),
          _buildFeatureCard(Icons.payment, "Secure\nPayments", "Safe and trusted\ncheckout process"),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.blue.shade700, size: 20),
          ),
          const Spacer(),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, height: 1.1)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 11, height: 1.2)),
        ],
      ),
    );
  }

  Widget _buildShopByCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Shop by Category", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Choose the right surveillance setup for your space", style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Browse All", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, size: 16, color: Colors.blue),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentProducts() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Recent Products", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("Top picks from our newest and best-selling inventory", style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue,
                side: const BorderSide(color: Colors.blue),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Explore Full Catalog"),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(32),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text("No recent products available", style: TextStyle(color: Colors.grey.shade500)),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseUs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const Text("Why Choose TN Automation", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text("Designed for performance, reliability, and long-term support", style: TextStyle(color: Colors.grey.shade600), textAlign: TextAlign.center),
          const SizedBox(height: 24),
          _buildWhyChooseCard(Icons.build_circle_outlined, "Professional Installation", "Certified technicians for accurate setup and cable management."),
          const SizedBox(height: 12),
          _buildWhyChooseCard(Icons.camera_alt_outlined, "High Quality Cameras", "Reliable surveillance hardware from trusted industry brands."),
          const SizedBox(height: 12),
          _buildWhyChooseCard(Icons.currency_rupee, "Affordable Pricing", "Cost-effective packages for homes, shops, and enterprises."),
          const SizedBox(height: 12),
          _buildWhyChooseCard(Icons.headset_mic_outlined, "Expert Support", "Prompt guidance for troubleshooting, upgrades, and maintenance."),
        ],
      ),
    );
  }

  Widget _buildWhyChooseCard(IconData icon, String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E8FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF5538C9), size: 24),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text(subtitle, style: TextStyle(color: Colors.grey.shade600, height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildServices() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Our Services", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text("End-to-end support for planning, installation, and maintenance", style: TextStyle(color: Colors.grey.shade600)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5538C9),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Book Service"),
          ),
          const SizedBox(height: 24),
          _buildServiceCard(Icons.handyman_outlined, "Installation", "Site survey, camera placement, and complete professional setup."),
          const SizedBox(height: 12),
          _buildServiceCard(Icons.health_and_safety_outlined, "Maintenance", "Preventive checks and fast issue resolution to avoid downtime."),
          const SizedBox(height: 12),
          _buildServiceCard(Icons.help_outline, "Consultation", "Expert guidance on coverage, camera type, and security planning."),
        ],
      ),
    );
  }

  Widget _buildServiceCard(IconData icon, String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
           BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.blue, size: 20),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text(subtitle, style: TextStyle(color: Colors.grey.shade600, height: 1.4)),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(padding: EdgeInsets.zero, alignment: Alignment.centerLeft),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Book Service", style: TextStyle(color: Colors.blue)),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward, size: 16, color: Colors.blue),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonials() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
               Text("Customer Testimonials", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
               SizedBox(height: 8),
               Text("What our clients say about our products and service quality", style: TextStyle(color: Colors.grey), textAlign: TextAlign.center),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            children: [
              _buildReviewCard("Arun Kumar", "Retail Store Owner", "TN Automation gave us a complete CCTV setup with clean installation and excellent clarity. Highly recommended."),
              _buildReviewCard("Priya Natarajan", "Homeowner", "The team was professional and patient. The mobile monitoring setup works perfectly even at night."),
              _buildReviewCard("Suresh Babu", "Warehouse Manager", "Great pricing and fast support. Their consultation helped us cover all blind spots efficiently."),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(String name, String role, String review) {
    return Container(
      width: 280,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
             children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.amber, size: 16)),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Text('"$review"', style: TextStyle(color: Colors.grey.shade700, fontSize: 13, height: 1.4)),
          ),
          const SizedBox(height: 12),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(role, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
        ],
      ),
    );
  }
}

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Our Products",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Browse our complete selection of CCTV cameras and security equipment",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  // Categories Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Categories", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1D4ED8), // Blue block in screenshot
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.sell_outlined, color: Colors.white, size: 18),
                              const SizedBox(width: 8),
                              const Expanded(child: Text("All Categories", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500))),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text("0", style: TextStyle(color: Colors.white, fontSize: 12)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Search/Filter Options
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Showing 0 products", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Text("Featured", style: TextStyle(fontSize: 13)),
                              const SizedBox(width: 8),
                              Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600, size: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                  // Empty State
                  Center(
                    child: Column(
                      children: [
                        Text("No products found matching your criteria.", style: TextStyle(color: Colors.grey.shade600, fontSize: 16)),
                        const SizedBox(height: 24),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black87,
                            side: BorderSide(color: Colors.grey.shade300),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("View All Products"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Our Services",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Professional security solutions and support from our expert team",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  
                  // Our Service Process
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Our Service Process",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Simple, fast and professional CCTV Installation workflow",
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
                        // Steps stacked for mobile
                        _buildProcessStep("STEP 1", Icons.phone_in_talk_outlined, "Consultation", "Share your security needs and get expert CCTV recommendations for your space."),
                        const SizedBox(height: 24),
                        _buildProcessStep("STEP 2", Icons.location_on_outlined, "Site Inspection", "Our team evaluates your location and suggests ideal camera positions and coverage."),
                        const SizedBox(height: 24),
                        _buildProcessStep("STEP 3", Icons.build_outlined, "Installation", "Professional setup with clean wiring, quick configuration, and quality checks."),
                        const SizedBox(height: 24),
                        _buildProcessStep("STEP 4", Icons.smartphone_outlined, "Live Monitoring", "Access live feeds and alerts from mobile with reliable remote monitoring support."),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessStep(String step, IconData icon, String title, String desc) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(step, style: const TextStyle(color: Color(0xFF1D4ED8), fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.blue.shade50, width: 2),
            ),
            child: Icon(icon, color: const Color(0xFF1D4ED8), size: 28),
          ),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          const SizedBox(height: 12),
          Text(
            desc,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 15, height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF0EA5E9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About TN Automation", style: TextStyle(color: Colors.white70, fontSize: 14)),
                  SizedBox(height: 12),
                  Text(
                    "Smart CCTV Solutions for Modern Security",
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, height: 1.2),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "We provide advanced surveillance systems including HD cameras, AI-enabled monitoring, and complete security solutions for homes and businesses.",
                    style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Our Mission
                  _buildTextCard(
                    "Our Mission",
                    "At TN Automation, our mission is to deliver reliable and intelligent security solutions that protect what matters most. We aim to make modern surveillance accessible, affordable, and easy to use for everyone."
                  ),
                  const SizedBox(height: 48),
                  
                  // Our Values
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
                  
                  // Why Choose Us?
                  _buildTextCard(
                    "Why Choose Us?",
                    "With years of experience in the CCTV and security industry, TN Automation understands the importance of protection and reliability. We offer a wide range of products including bullet cameras, dome cameras, DVR/NVR systems, and complete installation services.\n\nWhether you're securing your home, office, or business, we provide tailored solutions to meet your needs."
                  ),
                  const SizedBox(height: 48),
                  
                  // Security Features
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
                  
                  // CTA
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text("Secure Your Property with TN Automation", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, height: 1.2)),
                        const SizedBox(height: 12),
                        const Text("Choose trusted surveillance solutions designed for modern safety.", style: TextStyle(color: Colors.white70, fontSize: 15)),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1D4ED8),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Explore Products", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            side: BorderSide.none,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Contact Us", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextCard(String title, String text) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text(text, style: TextStyle(color: Colors.grey.shade600, fontSize: 16, height: 1.6)),
        ],
      ),
    );
  }

  Widget _buildIconCard(IconData icon, String title, String text) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF1D4ED8), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 8),
                Text(text, style: TextStyle(color: Colors.grey.shade600, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallFeatureCard(IconData icon, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF1D4ED8)),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Have a question about products or installation? Our team is here to help.",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  
                  // Left/Top Column: Send us a Message
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Send us a Message",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 24),
                      _buildTextField("Full Name"),
                      const SizedBox(height: 16),
                      _buildTextField("Email Address"),
                      const SizedBox(height: 16),
                      _buildTextField("Phone Number"),
                      const SizedBox(height: 16),
                      _buildTextField("Subject"),
                      const SizedBox(height: 16),
                      _buildTextField("Message", maxLines: 4),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1D4ED8),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 0,
                          ),
                          child: const Text("Send Message", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  
                  // Right/Bottom Column: Contact Details
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Contact Details",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 32),
                        _buildContactInfo(Icons.phone_outlined, "PHONE", "+91 78452 83678"),
                        const Divider(height: 32, color: Colors.black12),
                        _buildContactInfo(Icons.email_outlined, "EMAIL", "tnautomation@yahoo.com"),
                        const Divider(height: 32, color: Colors.black12),
                        _buildContactInfo(Icons.location_on_outlined, "ADDRESS", "33F, Sai Complex,\nEvk Sampath Salai,\nMoolapatrai Road,\nErode - 638003"),
                        const Divider(height: 32, color: Colors.black12),
                        _buildContactInfo(Icons.access_time, "BUSINESS HOURS", "Mon - Sat: 9:00 AM - 8:00 PM\nSunday: 10:00 AM - 6:00 PM"),
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

  Widget _buildTextField(String hint, {int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF1D4ED8)),
        ),
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String title, String details) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF1D4ED8), size: 20),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 4),
              Text(details, style: TextStyle(color: Colors.grey.shade700, height: 1.5)),
            ],
          ),
        ),
      ],
    );
  }
}

