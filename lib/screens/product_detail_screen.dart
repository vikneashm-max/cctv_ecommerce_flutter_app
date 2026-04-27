import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../services/cart_service.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedStorage = "128GB";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF0052FF)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "TN Automation",
          style: GoogleFonts.manrope(
            color: const Color(0xFF0052FF),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          ValueListenableBuilder<List<Product>>(
            valueListenable: CartService().favoriteItems,
            builder: (context, favorites, child) {
              final bool isFav = favorites.any((p) => p.name == widget.product.name);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                  color: isFav ? const Color(0xFFFF4D4D) : Colors.grey,
                ),
                onPressed: () => CartService().toggleFavorite(widget.product),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF0052FF)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen())),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumbs
            Text(
              "Catalog   >   Security Cameras   >   ProVue 4K Indoor",
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            
            // Product Image Container
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset("assets/images/camera_front.png", fit: BoxFit.contain),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9ECEF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        "BEST SELLER",
                        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildPageDot(true),
                        _buildPageDot(false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Thumbnails
            Row(
              children: [
                _buildThumbnail("assets/images/camera_front.png", true),
                _buildThumbnail("assets/images/camera_side.png", false),
                _buildThumbnail("assets/images/camera_box.png", false),
                _buildThumbnail("assets/images/camera_front.png", false, isMore: true),
              ],
            ),
            const SizedBox(height: 24),
            
            Text(
              "ProVue 4K Indoor",
              style: GoogleFonts.manrope(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 18),
                const Icon(Icons.star, color: Colors.orange, size: 18),
                const Icon(Icons.star, color: Colors.orange, size: 18),
                const Icon(Icons.star, color: Colors.orange, size: 18),
                const Icon(Icons.star, color: Colors.orange, size: 18),
                const SizedBox(width: 8),
                Text("4.9", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(width: 8),
                Text("(1,284 Reviews)", style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 14)),
              ],
            ),
            const SizedBox(height: 24),
            
            // Price
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "₹14,999",
                  style: GoogleFonts.manrope(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(width: 12),
                Text(
                  "₹18,500",
                  style: TextStyle(fontSize: 18, color: Colors.grey[400], decoration: TextDecoration.lineThrough),
                ),
                const SizedBox(width: 12),
                Text(
                  "19% OFF",
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF0052FF)),
                ),
              ],
            ),
            Text(
              "Inclusive of all taxes",
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500]),
            ),
            const SizedBox(height: 32),
            
            // Grid Specs
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 2.2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildSpecItem(Icons.videocam_rounded, "Resolution", "Ultra HD 4K"),
                _buildSpecItem(Icons.nightlight_round, "Night Vision", "Color IR (30m)"),
                _buildSpecItem(Icons.remove_red_eye, "Field of View", "140° Wide Angle"),
                _buildSpecItem(Icons.memory, "AI Features", "Human Detection"),
              ],
            ),
            const SizedBox(height: 32),
            
            // Storage
            Text(
              "STORAGE CAPACITY",
              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[600]),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildStorageChip("128GB"),
                const SizedBox(width: 12),
                _buildStorageChip("256GB"),
                const SizedBox(width: 12),
                _buildStorageChip("512GB"),
              ],
            ),
            const SizedBox(height: 32),
            
            // Buttons
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0052FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Buy Now", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () {
                  CartService().addToCart(widget.product);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF0052FF)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Add to Cart", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF0052FF))),
              ),
            ),
            const SizedBox(height: 32),
            
            // Delivery
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on_rounded, color: Colors.grey),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("DELIVERY TO", style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[600], fontWeight: FontWeight.bold)),
                        Text("Mumbai, 400001", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  Text("CHANGE", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: const Color(0xFF0052FF))),
                ],
              ),
            ),
            const SizedBox(height: 48),
            
            // Tech Specs
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Technical Specifications",
                    style: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  _buildTechRow("Sensor Type", "1/2.8\" Progressive CMOS"),
                  _buildTechRow("Compression", "H.265 / H.264+"),
                  _buildTechRow("Frame Rate", "4K @ 20fps"),
                  _buildTechRow("Audio", "Two-way Talk"),
                  _buildTechRow("Weather Rating", "IP66 (Dust & Water)"),
                  _buildTechRow("Connectivity", "Wi-Fi 6 / RJ45 PoE"),
                  _buildTechRow("Smart Integration", "Alexa, Google Home"),
                  _buildTechRow("Warranty", "2 Years Brand Warranty", isLast: true),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildPageDot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 16 : 8,
      height: 4,
      decoration: BoxDecoration(
        color: active ? Colors.black : Colors.grey[400],
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildThumbnail(String img, bool active, {bool isMore = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: isMore ? Colors.grey[400] : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: active ? const Color(0xFF0052FF) : Colors.grey[200]!),
      ),
      child: isMore 
        ? const Center(child: Text("+4", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)))
        : Padding(
            padding: const EdgeInsets.all(4),
            child: Image.asset(img, fit: BoxFit.contain),
          ),
    );
  }

  Widget _buildSpecItem(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[100]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF0052FF), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[500])),
                Text(value, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStorageChip(String capacity) {
    final bool isSelected = _selectedStorage == capacity;
    return GestureDetector(
      onTap: () => setState(() => _selectedStorage = capacity),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F4FF) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? const Color(0xFF0052FF) : Colors.grey[300]!),
        ),
        child: Text(
          capacity,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? const Color(0xFF0052FF) : Colors.grey[700],
          ),
        ),
      ),
    );
  }

  Widget _buildTechRow(String label, String value, {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600])),
              Text(value, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
            ],
          ),
        ),
        if (!isLast) const Divider(),
      ],
    );
  }
}
