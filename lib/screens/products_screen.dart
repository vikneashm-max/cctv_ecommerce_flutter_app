import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../services/cart_service.dart';
import 'product_detail_screen.dart';

class ProductsScreen extends StatefulWidget {
  final ScrollController controller;
  final Function(int)? onTabChanged;
  const ProductsScreen({super.key, required this.controller, this.onTabChanged});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<Product> _allProducts = [
    Product(name: "ProVue 4K Indoor", category: "Surveillance", price: 10699, icon: Icons.videocam_rounded, rating: 4.9, popularity: 128, addedDate: DateTime(2023, 10, 1), images: ['assets/images/camera_front.png']),
    Product(name: "NightGuard...", category: "Surveillance", price: 15499, icon: Icons.camera_indoor_rounded, rating: 4.7, popularity: 84, addedDate: DateTime(2023, 11, 5), images: ['assets/images/camera_side.png']),
    Product(name: "Halo Smart Bell 2", category: "Access Control", price: 8150, icon: Icons.lock_rounded, rating: 4.8, popularity: 215, addedDate: DateTime(2023, 12, 10), images: ['assets/images/camera_box.png']),
    Product(name: "OmniView 360 Dome", category: "Surveillance", price: 28999, icon: Icons.camera_alt_rounded, rating: 5.0, popularity: 42, addedDate: DateTime(2023, 10, 1), images: ['assets/images/camera_front.png']),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.controller,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          // Featured Products Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Featured Products",
                  style: GoogleFonts.manrope(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(
                  children: [
                    _buildNavArrow(Icons.chevron_left),
                    const SizedBox(width: 12),
                    _buildNavArrow(Icons.chevron_right),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Products Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _allProducts.length,
              itemBuilder: (context, index) => _buildProductCard(_allProducts[index]),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Need Installation Banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4FF),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFDDE4FF)),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Text(
                    "Need Installation?",
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0052FF),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Our certified engineers provide professional setup within 24 hours.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (widget.onTabChanged != null) {
                        widget.onTabChanged!(1); // Switch to Service tab
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0052FF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      elevation: 0,
                    ),
                    child: Text(
                      "Book Service",
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1558002038-1055907df827?w=600",
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildNavArrow(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Icon(icon, size: 20, color: Colors.grey[400]),
    );
  }

  Widget _buildProductCard(Product product) {
    final bool isSale = product.name.contains("NightGuard");
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Image.asset(product.images.first, fit: BoxFit.contain),
                    ),
                  ),
                  if (isSale)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B6B),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "SALE",
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: ValueListenableBuilder<List<Product>>(
                      valueListenable: CartService().favoriteItems,
                      builder: (context, favorites, child) {
                        final bool isFav = favorites.any((p) => p.name == product.name);
                        return GestureDetector(
                          onTap: () => CartService().toggleFavorite(product),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: isFav ? const Color(0xFFFFEEEE) : Colors.grey[200]!,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                              color: isFav ? const Color(0xFFFF4D4D) : Colors.grey[400],
                              size: 18,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        "${product.rating} (${product.popularity})",
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "₹${product.price}",
                            style: GoogleFonts.manrope(fontWeight: FontWeight.bold, fontSize: 18, color: const Color(0xFF0052FF)),
                          ),
                          if (isSale)
                            Text(
                              "₹20,499",
                              style: TextStyle(fontSize: 10, color: Colors.grey[400], decoration: TextDecoration.lineThrough),
                            ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          CartService().addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("${product.name} added to cart"),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0052FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.shopping_cart_rounded, color: Colors.white, size: 18),
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
    );
  }
}
