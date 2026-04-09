import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'orders_screen.dart';
import 'favorites_screen.dart';
import 'contact_screen.dart';
import 'login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: CustomScrollView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildFlipkartProfileCard(context),
                const SizedBox(height: 16),
                _buildActionButtons(context),
                const SizedBox(height: 48),
                _buildLogoutButton(context),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlipkartProfileCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Vikneash M",
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2A1263),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.amber.shade700, width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.bolt_rounded, size: 18, color: Colors.amber.shade700),
                    const SizedBox(width: 4),
                    Text(
                      "0",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2A1263),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Get Early Access, and 15% bank offer\nwith TN Premium BLACK",
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          _buildExploreButton(),
        ],
      ),
    );
  }

  Widget _buildExploreButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF2A1263),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "Explore BLACK",
        style: GoogleFonts.outfit(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildActionTile(
                  context,
                  Icons.inventory_2_outlined,
                  "Orders",
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const OrdersScreen())),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildActionTile(
                  context,
                  Icons.favorite_outline_rounded,
                  "Favourites",
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritesScreen())),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildActionTile(
                  context,
                  Icons.headset_mic_outlined,
                  "Help Center",
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => ContactScreen(controller: ScrollController()))),
                ),
              ),
              const Expanded(child: SizedBox()), // Placeholder for balance
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF7039F7), size: 22),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: const Color(0xFF2A1263),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        height: 56,
        child: TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFFF4B4B), width: 1),
            ),
          ),
          child: Text(
            "Log Out",
            style: GoogleFonts.outfit(
              color: const Color(0xFFFF4B4B),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
