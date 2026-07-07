import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 24 : size.width * 0.08,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          _buildSectionHeader("01.", "About Me", isMobile),
          const SizedBox(height: 40),

          // Layout splits content and statistics/education
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Text summary & Contact Info
              Expanded(
                flex: isMobile ? 0 : 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Who am I?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "I'm Verjot Heer, a dedicated Flutter developer based in Punjab, India. I specialize in crafting elegant mobile solutions that are highly performant, visually premium, and structurally sound. I hold a solid educational foundation in computer applications and love learning new technologies.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF909BB4),
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Education Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Education Cards
                    _buildEducationItem(
                      degree: "Master of Computer Applications (MCA)",
                      university: "Lovely Professional University",
                      duration: "2023 – 2025",
                    ),
                    const SizedBox(height: 16),
                    _buildEducationItem(
                      degree: "Bachelor of Computer Applications (BCA)",
                      university: "Lovely Professional University",
                      duration: "2020 – 2023",
                    ),
                  ],
                ),
              ),

              if (!isMobile) const SizedBox(width: 60),
              if (isMobile) const SizedBox(height: 40),

              // Right side: Stat boxes
              Expanded(
                flex: isMobile ? 0 : 5,
                child: Column(
                  children: [
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.2,
                      children: [
                        _buildStatCard("1.5+", "Years Experience"),
                        _buildStatCard("5+", "Apps Completed"),
                        // _buildStatCard("REST", "API Integrations"),
                        // _buildStatCard("State", "Mgmt Expert"),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Core Details Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFF131824).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFF202B3E)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Developer Info",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF64FFDA),
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildDetailRow(Icons.location_on, "Hoshiarpur, Punjab, India"),
                          const SizedBox(height: 12),
                          _buildDetailRow(Icons.phone, "+91 81464 12648"),
                          const SizedBox(height: 12),
                          _buildDetailRow(Icons.email, "verjotheer@gmail.com"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String index, String title, bool isMobile) {
    return Row(
      children: [
        Text(
          index,
          style: TextStyle(
            fontSize: isMobile ? 18 : 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF64FFDA),
            fontFamily: "monospace",
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 20 : 26,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
        if (!isMobile) ...[
          const SizedBox(width: 20),
          const Expanded(
            child: Divider(
              color: Color(0xFF202B3E),
              thickness: 1,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEducationItem({
    required String degree,
    required String university,
    required String duration,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131824).withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF202B3E).withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  degree,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                duration,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64FFDA),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            university,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF909BB4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF131824).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF202B3E)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFBD00FF),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF909BB4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF64FFDA), size: 18),
        const SizedBox(width: 12),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFFECEFF4),
          ),
        ),
      ],
    );
  }
}
