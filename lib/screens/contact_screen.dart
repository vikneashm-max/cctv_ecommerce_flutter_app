import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key, this.controller});
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        controller: controller,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              "PREMIUM AUTOMATION SERVICES",
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0052FF),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Smart Solutions for a Safer Workspace",
              style: GoogleFonts.manrope(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Expert installation and maintenance of high-end surveillance and automation systems across India. Reliability you can trust.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            
            _buildServiceCard(
              Icons.inventory_2_rounded,
              "Professional Installation",
              "End-to-end setup of CCTV, smart locks, and industrial automation with 100% cable concealment and testing.",
              "4,999",
              "STARTING FROM",
              "Book Now",
              true,
              "https://images.unsplash.com/photo-1581092160562-40aa08e78837?w=600",
            ),
            const SizedBox(height: 24),
            _buildServiceCard(
              Icons.build_rounded,
              "CCTV Maintenance",
              "Regular health checks, lens cleaning, and DVR/NVR optimization to ensure your eyes never fail.",
              "1,499",
              "/ VISIT",
              "Book Now",
              false,
              null,
              isOutlinedButton: true,
            ),
            const SizedBox(height: 24),
            _buildServiceCard(
              Icons.headset_mic_rounded,
              "Technical Support",
              "24/7 remote assistance for network configuration, cloud storage, and troubleshooting of your automation hardware.",
              "999",
              "/ MONTH",
              "Subscribe",
              true,
              null,
            ),
            const SizedBox(height: 24),
            _buildServiceCard(
              Icons.analytics_rounded,
              "System Consultation",
              "Custom blueprinting for your factory or residence. We analyze blind spots and energy efficiency to design your perfect ecosystem.",
              "2,500",
              "CONSULT FEE",
              "Book Now",
              true,
              "https://images.unsplash.com/photo-1517646287270-a5a9ca602e5c?w=600",
            ),
            
            const SizedBox(height: 48),
            
            // Trust Icons
            _buildTrustGrid(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    IconData icon, 
    String title, 
    String desc, 
    String price, 
    String priceLabel, 
    String buttonText, 
    bool isPrimary,
    String? imageUrl,
    {bool isOutlinedButton = false}
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7F0FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: const Color(0xFF0052FF), size: 24),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  desc,
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600], height: 1.5),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "₹ $price",
                      style: GoogleFonts.manrope(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF0052FF)),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      priceLabel,
                      style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[400]),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: isOutlinedButton 
                    ? OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF0052FF)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text(buttonText, style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: const Color(0xFF0052FF))),
                      )
                    : ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0052FF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        child: Text(buttonText, style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Colors.white)),
                      ),
                ),
              ],
            ),
          ),
          if (imageUrl != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                height: 160,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 160,
                    width: double.infinity,
                    color: Colors.grey[100],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 160,
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_not_supported_outlined, color: Colors.grey[400], size: 32),
                      const SizedBox(height: 8),
                      Text(
                        "Image unavailable",
                        style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTrustGrid() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTrustItem(Icons.verified_user_rounded, "OEM Certified"),
            _buildTrustItem(Icons.timer_rounded, "4hr Response"),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTrustItem(Icons.security_rounded, "1yr Warranty"),
            _buildTrustItem(Icons.payments_rounded, "Transparent Pricing"),
          ],
        ),
      ],
    );
  }

  Widget _buildTrustItem(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey[600], size: 28),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
