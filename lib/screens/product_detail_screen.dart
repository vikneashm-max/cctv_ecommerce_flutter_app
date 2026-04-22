import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../services/cart_service.dart';
import '../theme/app_colors.dart';

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
      backgroundColor: AppColors.foundation,
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Hero Image Section
              SliverAppBar(
                expandedHeight: 400,
                backgroundColor: AppColors.foundation,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
                  onPressed: () => Navigator.pop(context),
                  style: IconButton.styleFrom(backgroundColor: Colors.black.withOpacity(0.2)),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.share_outlined, color: AppColors.onSurface),
                    onPressed: () {},
                    style: IconButton.styleFrom(backgroundColor: Colors.black.withOpacity(0.2)),
                  ),
                  const SizedBox(width: 8),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: widget.product.name,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          widget.product.images.first.contains('new_design') 
                            ? widget.product.images.first 
                            : 'new_design/product_description.png', // Fallback to a design image
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                AppColors.foundation.withOpacity(0.8),
                                AppColors.foundation,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      Text(
                        widget.product.category.toUpperCase(),
                        style: GoogleFonts.inter(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.product.name,
                        style: GoogleFonts.inter(
                          color: AppColors.onSurface,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Text(widget.product.rating.toString(), style: GoogleFonts.inter(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12)),
                                const SizedBox(width: 4),
                                Icon(Icons.star_rounded, color: AppColors.primary, size: 14),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "1,284 Ratings",
                            style: GoogleFonts.inter(color: AppColors.onSurfaceVariant, fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      
                      // Price Section
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "₹${widget.product.price}",
                            style: GoogleFonts.inter(
                              color: AppColors.onSurface,
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "₹${(widget.product.price * 1.3).toInt()}",
                            style: GoogleFonts.inter(
                              color: AppColors.onSurfaceVariant,
                              fontSize: 18,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.tertiary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              "29% OFF",
                              style: GoogleFonts.inter(color: AppColors.tertiary, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Inclusive of all taxes",
                        style: GoogleFonts.inter(color: AppColors.onSurfaceVariant, fontSize: 12, fontStyle: FontStyle.italic),
                      ),
                      
                      const SizedBox(height: 48),
                      
                      // Exclusive Benefits
                      _buildSectionHeader("EXCLUSIVE BENEFITS"),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: _buildPrivilegeCard(Icons.account_balance_wallet_rounded, "Cashback", "Get ₹4,000 instant cashback")),
                          const SizedBox(width: 16),
                          Expanded(child: _buildPrivilegeCard(Icons.shield_rounded, "Warranty", "Free 2-Year Extended Warranty")),
                        ],
                      ),
                      
                      const SizedBox(height: 48),
                      
                      // Product Specifications
                      _buildSectionHeader("PRODUCT SPECIFICATIONS"),
                      const SizedBox(height: 20),
                      _buildBlueprintItem(Icons.videocam_rounded, "4K Ultra HD Optics", "Crystal clear resolution for day and night monitoring."),
                      _buildBlueprintItem(Icons.psychology_rounded, "Smart Motion Detection", "AI-powered alerts for real-time security."),
                      _buildBlueprintItem(Icons.bolt_rounded, "Easy Installation", "Syncs seamlessly with your smart home setup."),
                      
                      const SizedBox(height: 48),
                      
                      // Description
                      _buildSectionHeader("Description"),
                      const SizedBox(height: 16),
                      Text(
                        "Designed for those who demand the best in security. The ${widget.product.name} offers unparalleled monitoring with smart AI integration. It is robust, reliable, and easy to manage, ensuring your property is always under watchful eyes.",
                        style: GoogleFonts.inter(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                      
                      const SizedBox(height: 120), // Bottom padding
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Bottom Actions
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomActionPanel(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.inter(
        color: AppColors.onSurface,
        fontSize: 13,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildPrivilegeCard(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLevel1,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.onSurfaceVariant.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(height: 12),
          Text(title, style: GoogleFonts.inter(color: AppColors.onSurface, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: GoogleFonts.inter(color: AppColors.onSurfaceVariant, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildBlueprintItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(color: AppColors.onSurface, fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: GoogleFonts.inter(color: AppColors.onSurfaceVariant, fontSize: 13, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionPanel() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      decoration: BoxDecoration(
        color: AppColors.foundation.withOpacity(0.8),
        border: Border(top: BorderSide(color: AppColors.onSurfaceVariant.withOpacity(0.1))),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 64,
                  child: TextButton(
                    onPressed: () {
                      CartService().addToCart(widget.product);
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: AppColors.surfaceLevel2,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          title: Text("Added to Cart", style: GoogleFonts.inter(color: AppColors.onSurface, fontWeight: FontWeight.bold)),
                          content: Text("${widget.product.name} has been added to your cart.", style: GoogleFonts.inter(color: AppColors.onSurfaceVariant)),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("CONTINUE SHOPPING", style: GoogleFonts.inter(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12)),
                            ),
                          ],
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.surfaceLevel1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text("ADD TO CART", style: GoogleFonts.inter(color: AppColors.onSurface, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
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
                    child: Text("BUY NOW", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


