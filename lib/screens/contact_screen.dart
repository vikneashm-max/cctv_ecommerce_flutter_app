import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/animated_scale_card.dart';

class ContactScreen extends StatelessWidget {
  final ScrollController controller;
  const ContactScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Handled by MainScreen
      body: SingleChildScrollView(
        controller: controller,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Premium Header
            Stack(
              children: [
                Container(
                  height: 220,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF5538C9), Color(0xFF7C61EF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(48),
                      bottomRight: Radius.circular(48),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF5538C9),
                        blurRadius: 20,
                        offset: Offset(0, 5),
                        spreadRadius: -10,
                      )
                    ],
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 30, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Get In Touch",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Our expert team is here to secure\nyour world 24/7.",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 36),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildNewContactCard(
                    Icons.location_on_rounded, 
                    "Main Headquarters", 
                    "2/206, main road, Thittai, Sirkali, Tamil Nadu 609111",
                    "Navigate",
                  ),
                  const SizedBox(height: 18),
                  _buildNewContactCard(
                    Icons.phone_rounded, 
                    "Phone Support", 
                    "+91 97863 37243",
                    "Call Now",
                  ),
                  const SizedBox(height: 18),
                  _buildNewContactCard(
                    Icons.email_rounded, 
                    "Email Address", 
                    "tnautomations@gmail.com",
                    "Send Email",
                  ),
                  const SizedBox(height: 18),
                  _buildNewContactCard(
                    Icons.access_time_filled_rounded, 
                    "Operating Hours", 
                    "Mon - Sat: 9:00 AM - 8:00 PM\nSunday: Closed",
                    "Check Status",
                  ),

                  const SizedBox(height: 48),

                  const Text(
                    "Follow Our Updates",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.8),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(Icons.facebook_rounded),
                      const SizedBox(width: 20),
                      _buildSocialIcon(Icons.camera_alt_rounded),
                      const SizedBox(width: 20),
                      _buildSocialIcon(Icons.business_rounded),
                    ],
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewContactCard(IconData icon, String title, String value, String actionLabel) {
    return AnimatedScaleCard(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF5538C9).withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5538C9).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(icon, color: const Color(0xFF5538C9), size: 28),
                ),
                const SizedBox(width: 22),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
                      const SizedBox(height: 6),
                      Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, height: 1.4, letterSpacing: -0.2)),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: const Color(0xFF5538C9).withOpacity(0.1), blurRadius: 15, offset: const Offset(0, 6)),
        ],
      ),
      child: Icon(icon, color: const Color(0xFF5538C9), size: 26),
    );
  }
}
