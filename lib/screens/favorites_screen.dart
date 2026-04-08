import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FE),
      appBar: AppBar(
        title: const Text("My Favorites", style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.8)),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      body: ValueListenableBuilder<List<Product>>(
        valueListenable: CartService().favoriteItems,
        builder: (context, items, child) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border_rounded, size: 100, color: Colors.grey.shade300),
                  const SizedBox(height: 20),
                  const Text("No favorites yet", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 10),
                  Text("Explore products and tap the heart icon!", style: TextStyle(color: Colors.grey.shade500)),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final product = items[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF5538C9).withOpacity(0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F2FF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(product.icon, color: const Color(0xFF5538C9), size: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(product.category, style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                            const SizedBox(height: 8),
                            Text("₹${product.price}", style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF5538C9))),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => CartService().toggleFavorite(product),
                        icon: const Icon(Icons.favorite_rounded, color: Colors.redAccent),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
