import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/animated_scale_card.dart';

class ContactScreen extends StatelessWidget {
  final ScrollController controller;
  const ContactScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "GET IN TOUCH",
                    style: GoogleFonts.inter(
                      color: AppColors.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "CONTACT\nUS",
                    style: GoogleFonts.inter(
                      color: AppColors.onSurface,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      height: 0.95,
                      letterSpacing: -1.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Direct access to our support team. Available for assistance and product consultations.",
                    style: GoogleFonts.inter(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildTechnicalContactCard(
                    Icons.location_on_rounded, 
                    "OFFICE ADDRESS", 
                    "2/206, main road, Thittai, Sirkali, Tamil Nadu 609111",
                  ),
                  const SizedBox(height: 16),
                  _buildTechnicalContactCard(
                    Icons.phone_rounded, 
                    "PHONE NUMBER", 
                    "+91 97863 37243",
                  ),
                  const SizedBox(height: 16),
                  _buildTechnicalContactCard(
                    Icons.email_rounded, 
                    "EMAIL ADDRESS", 
                    "tnautomations@gmail.com",
                  ),
                  const SizedBox(height: 16),
                  _buildTechnicalContactCard(
                    Icons.access_time_filled_rounded, 
                    "WORKING HOURS", 
                    "Mon - Sat: 09:00 - 20:00\nSunday: Closed",
                  ),

                  const SizedBox(height: 64),

                  Center(
                    child: Text(
                      "SOCIAL MEDIA",
                      style: GoogleFonts.inter(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialCommand(Icons.facebook_rounded),
                      const SizedBox(width: 24),
                      _buildSocialCommand(Icons.camera_alt_rounded),
                      const SizedBox(width: 24),
                      _buildSocialCommand(Icons.business_rounded),
                    ],
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechnicalContactCard(IconData icon, String title, String value) {
    return AnimatedScaleCard(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surfaceLevel1,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.onSurfaceVariant.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceLevel2,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary.withOpacity(0.1)),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title, 
                    style: GoogleFonts.inter(
                      color: AppColors.primary, 
                      fontSize: 10, 
                      fontWeight: FontWeight.w900, 
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value, 
                    style: GoogleFonts.inter(
                      color: AppColors.onSurface, 
                      fontSize: 15, 
                      fontWeight: FontWeight.w700, 
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialCommand(IconData icon) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.surfaceLevel1,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.onSurfaceVariant.withOpacity(0.1)),
      ),
      child: Icon(icon, color: AppColors.onSurface, size: 24),
    );
  }
}


