import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock orders data
    final List<Map<String, dynamic>> orders = [
      {
        'id': 'ORD-2024-8842',
        'date': 'Oct 12, 2023',
        'status': 'DELIVERED',
        'total': '₹3,500',
        'items': [
          Product(name: "4MP IP Bullet Camera", category: "Cameras", price: 3500, icon: Icons.videocam_rounded, rating: 4.5, popularity: 120, addedDate: DateTime(2023, 10, 1), images: []),
        ],
      },
      {
        'id': 'ORD-2024-9120',
        'date': 'Jan 15, 2024',
        'status': 'IN TRANSIT',
        'total': '₹6,800',
        'items': [
          Product(name: "2TB Surveillance HDD", category: "Storage", price: 6800, icon: Icons.storage_rounded, rating: 4.9, popularity: 300, addedDate: DateTime(2023, 8, 5), images: []),
        ],
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.foundation,
      appBar: AppBar(
        title: Text(
          "MY ORDERS",
          style: GoogleFonts.inter(
            color: AppColors.onSurface,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: AppColors.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.foundation,
        elevation: 0,
      ),
      body: orders.isEmpty
          ? _buildEmptyOrders()
          : ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return _buildOrderCard(order);
              },
            ),
    );
  }

  Widget _buildEmptyOrders() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_rounded, size: 80, color: AppColors.onSurfaceVariant.withOpacity(0.2)),
          const SizedBox(height: 24),
          Text(
            "NO ORDERS FOUND",
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: AppColors.onSurfaceVariant,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final product = order['items'][0] as Product;
    final bool isDelivered = order['status'] == 'DELIVERED';
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.surfaceLevel1,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.onSurfaceVariant.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLevel2,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(product.icon, color: AppColors.primary, size: 28),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (isDelivered ? AppColors.success : AppColors.primary).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          order['status'],
                          style: GoogleFonts.inter(
                            color: isDelivered ? AppColors.success : AppColors.primary,
                            fontWeight: FontWeight.w900,
                            fontSize: 9,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.name,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Ordered on ${order['date']}",
                        style: GoogleFonts.inter(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant.withOpacity(0.5)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLevel2.withOpacity(0.5),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "ID: ${order['id']}",
                  style: GoogleFonts.inter(color: AppColors.onSurfaceVariant, fontSize: 11, fontWeight: FontWeight.w600),
                ),
                Text(
                  order['total'],
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


