import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../services/theme_service.dart';
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
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  _buildSectionHeader("MY PROFILE"),
                  const SizedBox(height: 24),
                  _buildProfileCard(context),
                  const SizedBox(height: 48),
                  _buildSectionHeader("QUICK ACTIONS"),
                  const SizedBox(height: 24),
                  _buildActionGrid(context),
                  const SizedBox(height: 48),
                  _buildSectionHeader("APP SETTINGS"),
                  const SizedBox(height: 16),
                  _buildThemeToggle(),
                  const SizedBox(height: 64),
                  _buildLogoutButton(context),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.inter(
        color: AppColors.onSurfaceVariant,
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 2,
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surfaceLevel1,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "VIKNEASH M",
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "ELITE CUSTOMER",
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primary,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLevel2,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.onSurfaceVariant.withOpacity(0.1)),
                ),
                child: Icon(Icons.person_rounded, color: AppColors.onSurface, size: 32),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surfaceLevel2,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.verified_user_rounded, color: AppColors.tertiary, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ELITE MEMBER",
                        style: GoogleFonts.inter(
                          color: AppColors.onSurface,
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "PRIORITY SUPPORT & EXCLUSIVE DEALS",
                        style: GoogleFonts.inter(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildActionTile(Icons.inventory_2_rounded, "MY ORDERS", () => Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersScreen())))),
            const SizedBox(width: 16),
            Expanded(child: _buildActionTile(Icons.favorite_rounded, "FAVORITES", () => Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen())))),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildActionTile(Icons.headset_mic_rounded, "SUPPORT", () => Navigator.push(context, MaterialPageRoute(builder: (context) => ContactScreen(controller: ScrollController()))))),
            const SizedBox(width: 16),
            Expanded(child: _buildActionTile(Icons.settings_rounded, "SETTINGS", () {})),
          ],
        ),
      ],
    );
  }

  Widget _buildActionTile(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surfaceLevel1,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.onSurfaceVariant.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: AppColors.onSurface,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeToggle() {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeService().themeMode,
      builder: (context, mode, child) {
        final isDark = mode == ThemeMode.dark;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surfaceLevel1,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded, color: AppColors.primary),
                  const SizedBox(width: 16),
                  Text(
                    isDark ? "Dark Mode" : "Light Mode",
                    style: GoogleFonts.inter(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Switch(
                value: isDark,
                onChanged: (value) => ThemeService().toggleTheme(),
                activeColor: AppColors.primary,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.onSurfaceVariant.withOpacity(0.1)),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
          );
        },
        child: Text(
          "LOGOUT",
          style: GoogleFonts.inter(
            color: const Color(0xFFFF4B4B),
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}


