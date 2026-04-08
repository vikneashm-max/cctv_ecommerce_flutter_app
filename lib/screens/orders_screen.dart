import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock orders data
    final List<Map<String, dynamic>> orders = [
      {
        'id': 'ORD-2024-8842',
        'date': 'Oct 12, 2023',
        'status': 'Delivered',
        'total': '₹3,500',
        'items': [
          Product(name: "4MP IP Bullet Camera", category: "Cameras", price: 3500, icon: Icons.camera_alt_rounded, rating: 4.5, popularity: 120, addedDate: DateTime(2023, 10, 1), images: []),
        ],
      },
      {
        'id': 'ORD-2024-9120',
        'date': 'Jan 15, 2024',
        'status': 'In Transit',
        'total': '₹6,800',
        'items': [
          Product(name: "2TB Surveillance HDD", category: "Storage", price: 6800, icon: Icons.storage_rounded, rating: 4.9, popularity: 300, addedDate: DateTime(2023, 8, 5), images: []),
        ],
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F4FF),
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
      ),
      body: orders.isEmpty
          ? _buildEmptyOrders()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
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
          Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            "No orders yet",
            style: GoogleFonts.outfit(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          Text(
            "Your order history will appear here.",
            style: GoogleFonts.outfit(color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final product = order['items'][0] as Product;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F8FE),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(product.icon, color: const Color(0xFF5538C9), size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order['status'],
                        style: GoogleFonts.outfit(
                          color: order['status'] == 'Delivered' ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product.name,
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Ordered on ${order['date']}",
                        style: GoogleFonts.outfit(
                          color: Colors.black45,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: Colors.black26),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order ID: ${order['id']}",
                  style: GoogleFonts.outfit(color: Colors.black54, fontSize: 13),
                ),
                Text(
                  order['total'],
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: const Color(0xFF5538C9),
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
