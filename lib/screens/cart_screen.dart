import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/cart_service.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.foundation,
      appBar: AppBar(
        title: Text(
          "MY CART",
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
      body: ValueListenableBuilder<List<CartItem>>(
        valueListenable: CartService().cartItems,
        builder: (context, items, child) {
          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inventory_2_outlined, size: 80, color: AppColors.onSurfaceVariant.withOpacity(0.2)),
                  const SizedBox(height: 24),
                  Text(
                    "YOUR CART IS EMPTY",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    height: 50,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        backgroundColor: AppColors.surfaceLevel1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text("BACK TO SHOP", style: GoogleFonts.inter(color: AppColors.onSurface, fontWeight: FontWeight.w800, fontSize: 12)),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(24),
                  itemCount: items.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final cartItem = items[index];
                    final product = cartItem.product;
                    return Container(
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
                                  style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      product.category.toUpperCase(),
                                      style: GoogleFonts.inter(color: AppColors.onSurfaceVariant, fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(color: AppColors.primaryContainer.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                                      child: Text("x${cartItem.quantity}", style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.primary)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "₹${product.price * cartItem.quantity}",
                                  style: GoogleFonts.inter(fontWeight: FontWeight.w900, fontSize: 17, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => CartService().removeFromCart(cartItem),
                            icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFFF4B4B), size: 20),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              _buildCheckoutSection(items),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCheckoutSection(List<CartItem> items) {
    final double total = CartService().getTotalPrice();
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
      decoration: BoxDecoration(
        color: AppColors.surfaceLevel1,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border(top: BorderSide(color: AppColors.onSurfaceVariant.withOpacity(0.1))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "SUBTOTAL",
                style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w900, color: AppColors.onSurfaceVariant, letterSpacing: 1),
              ),
              Text(
                "₹$total",
                style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [AppColors.primaryContainer, AppColors.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                "CHECKOUT",
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

