import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/cart_service.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foundation,
      appBar: AppBar(
        title: Text(
          "MY FAVORITES",
          style: GoogleFonts.inter(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            fontSize: 16,
          ),
        ),
        backgroundColor: AppColors.foundation,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ValueListenableBuilder<List<Product>>(
        valueListenable: CartService().favoriteItems,
        builder: (context, items, child) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border_rounded, size: 80, color: AppColors.onSurfaceVariant.withOpacity(0.2)),
                  const SizedBox(height: 24),
                  Text(
                    "NO FAVORITES YET",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Tap the heart icon to save items you love.",
                    style: GoogleFonts.inter(color: AppColors.onSurfaceVariant.withOpacity(0.5), fontSize: 12),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final product = items[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)));
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLevel1,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.onSurfaceVariant.withOpacity(0.05)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLevel2,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(product.icon, color: AppColors.primary, size: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: GoogleFonts.inter(color: AppColors.onSurface, fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.category.toUpperCase(),
                              style: GoogleFonts.inter(color: AppColors.onSurfaceVariant, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "₹${product.price}",
                              style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 17, color: AppColors.onSurface),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => CartService().toggleFavorite(product),
                        icon: Icon(Icons.favorite_rounded, color: AppColors.primary, size: 20),
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

