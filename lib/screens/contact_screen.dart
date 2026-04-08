import 'package:flutter/material.dart';
import '../widgets/animated_scale_card.dart';

class ContactScreen extends StatelessWidget {
  final ScrollController controller;
  const ContactScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFE),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            // Premium Header
             Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF5538C9), Color(0xFF8A72F1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Get In Touch",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Our team is ready to assist you anytime.",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

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
                  const SizedBox(height: 16),
                  _buildNewContactCard(
                    Icons.phone_rounded, 
                    "Phone Support", 
                    "+91 97863 37243",
                    "Call Now",
                  ),
                  const SizedBox(height: 16),
                  _buildNewContactCard(
                    Icons.email_rounded, 
                    "Email Address", 
                    "tnautomations@gmail.com",
                    "Send Email",
                  ),
                  const SizedBox(height: 16),
                   _buildNewContactCard(
                    Icons.access_time_filled_rounded, 
                    "Operating Hours", 
                    "Mon - Sat: 9:00 AM - 8:00 PM\nSunday: Closed",
                    "Check Status",
                  ),

                  const SizedBox(height: 48),

                  const Text(
                    "Follow Our Updates",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(Icons.facebook),
                      const SizedBox(width: 16),
                      _buildSocialIcon(Icons.camera_alt_rounded),
                      const SizedBox(width: 16),
                      _buildSocialIcon(Icons.business_rounded),
                    ],
                  ),
                  const SizedBox(height: 60),
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
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5538C9).withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: const Color(0xFF5538C9), size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, height: 1.3)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Icon(icon, color: const Color(0xFF5538C9), size: 24),
    );
  }
}

