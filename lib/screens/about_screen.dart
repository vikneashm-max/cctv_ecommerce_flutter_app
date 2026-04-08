import 'package:flutter/material.dart';
import '../widgets/animated_scale_card.dart';

class AboutScreen extends StatelessWidget {
  final ScrollController controller;
  const AboutScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFE),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Premium Header with Gradient
            Stack(
              children: [
                Container(
                  height: 240,
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
                Positioned(
                  top: -50,
                  right: -50,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white.withOpacity(0.05),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "About Us",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Pioneering security through innovation and trust.",
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
                Positioned(
                  bottom: 0,
                  left: 24,
                  right: 24,
                  child: _buildTextCard(
                    "Our Vision",
                    "To be the leading provider of intelligent surveillance systems that empower individuals and businesses with peace of mind through cutting-edge technology.",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                   const SizedBox(height: 12),
                  const Text("Core Values", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildValueCard(Icons.verified_user_rounded, "Security", "Highest grade protection.")),
                      const SizedBox(width: 16),
                      Expanded(child: _buildValueCard(Icons.auto_awesome_rounded, "Innovation", "Next-gen AI tech.")),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildValueCard(Icons.beenhere_rounded, "Reliability", "Trustworthy systems.")),
                      const SizedBox(width: 16),
                      Expanded(child: _buildValueCard(Icons.support_agent_rounded, "Support", "24/7 Expert assistance.")),
                    ],
                  ),
                  const SizedBox(height: 48),

                  const Text("Service Ecosystem", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
                  const SizedBox(height: 20),
                  _buildIconCard(Icons.camera_alt_rounded, "Premium Hardware", "We source only top-tier cameras and recording equipment from industry leaders."),
                  const SizedBox(height: 16),
                  _buildIconCard(Icons.settings_rounded, "Custom Installation", "Our experts design and install systems tailored specifically to your layout and needs."),
                  const SizedBox(height: 16),
                  _buildIconCard(Icons.cloud_done_rounded, "Smart Integration", "Access your security feeds anytime, anywhere with seamless mobile and cloud integration."),

                  const SizedBox(height: 48),

                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF5538C9).withOpacity(0.03),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: const Color(0xFF5538C9).withOpacity(0.05)),
                    ),
                    child: Column(
                      children: [
                        const Text("Implementation Pipeline", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900), textAlign: TextAlign.center),
                        const SizedBox(height: 32),
                        _buildProcessStep("01", Icons.chat_bubble_outline_rounded, "Discovery", "Initial consultation to understand parameters."),
                        _buildProcessConnector(),
                        _buildProcessStep("02", Icons.architecture_rounded, "Blueprint", "Architecting the optimal security layout."),
                        _buildProcessConnector(),
                        _buildProcessStep("03", Icons.construction_rounded, "Execution", "Precision installation by certified experts."),
                        _buildProcessConnector(),
                        _buildProcessStep("04", Icons.task_alt_rounded, "Validation", "Final testing and comprehensive system demo."),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueCard(IconData icon, String title, String text) {
    return AnimatedScaleCard(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: const Color(0xFF5538C9).withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF5538C9).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xFF5538C9), size: 24),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(text, style: TextStyle(fontSize: 12, color: Colors.grey.shade500, height: 1.4)),
          ],
        ),
      ),
    );
  }

  Widget _buildTextCard(String title, String text) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 30, offset: const Offset(0, 15)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF5538C9))),
          const SizedBox(height: 12),
          Text(text, style: TextStyle(fontSize: 14, color: Colors.grey.shade600, height: 1.6, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildIconCard(IconData icon, String title, String text) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF0F2FF)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2FF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: const Color(0xFF5538C9), size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(text, style: TextStyle(fontSize: 13, color: Colors.grey.shade500, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessStep(String num, IconData icon, String title, String text) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: const Color(0xFF5538C9),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(color: const Color(0xFF5538C9).withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4)),
            ],
          ),
          child: Center(child: Text(num, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900))),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(text, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
            ],
          ),
        ),
        Icon(icon, color: const Color(0xFF5538C9).withOpacity(0.2), size: 32),
      ],
    );
  }

  Widget _buildProcessConnector() {
    return Container(
      width: 2,
      height: 30,
      margin: const EdgeInsets.only(left: 21, top: 4, bottom: 4),
      color: const Color(0xFF5538C9).withOpacity(0.1),
    );
  }
}

