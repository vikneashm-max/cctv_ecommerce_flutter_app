import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/cart_service.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FE),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
          ValueListenableBuilder<List<Product>>(
            valueListenable: CartService().favoriteItems,
            builder: (context, favs, child) {
              final isFav = CartService().isFavorite(widget.product);
              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: isFav ? Colors.redAccent : const Color(0xFF2A1263),
                ),
                onPressed: () => CartService().toggleFavorite(widget.product),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Section
            Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: widget.product.images.isNotEmpty
                ? Stack(
                    children: [
                      PageView.builder(
                        itemCount: widget.product.images.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Center(
                            child: Hero(
                              tag: index == 0 ? widget.product.name : "other_${index}",
                              child: Image.asset(
                                widget.product.images[index],
                                fit: BoxFit.contain,
                                height: 260,
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 20,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            widget.product.images.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF7039F7).withOpacity(0.2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Hero(
                    tag: widget.product.name,
                    child: Icon(widget.product.icon, size: 180, color: const Color(0xFF7039F7).withOpacity(0.2)),
                  ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7039F7).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.product.category,
                          style: const TextStyle(color: Color(0xFF7039F7), fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(widget.product.rating.toString(), style: const TextStyle(color: Color(0xFF2A1263), fontWeight: FontWeight.bold)),
                      Text(" (120 reviews)", style: TextStyle(color: const Color(0xFF7C808E), fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.product.name,
                    style: const TextStyle(color: Color(0xFF2A1263), fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: -1),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "₹${widget.product.price}",
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF7039F7)),
                          ),
                          Text(
                            "₹${(widget.product.price * 1.4).toInt()} (40% OFF)",
                            style: TextStyle(
                              fontSize: 14, 
                              color: const Color(0xFF7C808E).withOpacity(0.5), 
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Quantity Selector
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            _buildQuantityIcon(Icons.remove_rounded, () {
                              if (_quantity > 1) setState(() => _quantity--);
                            }),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "$_quantity",
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF7039F7)),
                              ),
                            ),
                            _buildQuantityIcon(Icons.add_rounded, () {
                              setState(() => _quantity++);
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    "Overview",
                    style: TextStyle(color: Color(0xFF2A1263), fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "This ${widget.product.name} is designed for high-performance ${widget.product.category.toLowerCase()} surveillance. It features next-gen optics and AI-enhanced monitoring to ensure your safety and peace of mind. Built with durability and reliability in mind.",
                    style: TextStyle(fontSize: 15, color: const Color(0xFF7C808E), height: 1.6),
                  ),
                  const SizedBox(height: 32),
                  _buildSpecificationRow("Connectivity", "High-Speed Wired/Wireless"),
                  _buildSpecificationRow("Warranty", "2 Years Manufacturer Warranty"),
                  _buildSpecificationRow("Resolution", "4K Ultra HD Support"),
                  const SizedBox(height: 100), // Space for bottom button
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              border: Border(top: BorderSide(color: Colors.white.withOpacity(0.4), width: 1.5)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF7039F7), width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: const Text("Buy Now", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7039F7))),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        CartService().addToCart(widget.product, quantity: _quantity);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Added $_quantity to Cart"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: const Color(0xFF7039F7),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7039F7),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: const Text("Add to Cart", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityIcon(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Icon(icon, color: const Color(0xFF7039F7), size: 20),
      ),
    );
  }

  Widget _buildSpecificationRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: const Color(0xFF7C808E), fontWeight: FontWeight.w600)),
          Text(value, style: const TextStyle(color: Color(0xFF2A1263), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
