import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
          _buildSectionHeader("02.", "Technical Skills", isMobile),
          const SizedBox(height: 40),

          // Categories Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final double cardWidth = isMobile
                  ? constraints.maxWidth
                  : (constraints.maxWidth - 24) / 2;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  _buildSkillCategoryCard(
                    title: "Frameworks & Languages",
                    skills: ["Flutter", "Dart", "Swift (Basic)", "Kotlin (Basic)"],
                    icon: Icons.code,
                    width: cardWidth,
                  ),
                  _buildSkillCategoryCard(
                    title: "State Management",
                    skills: ["Provider", "GetX", "BLoC", "Riverpod"],
                    icon: Icons.account_tree_outlined,
                    width: cardWidth,
                  ),
                  _buildSkillCategoryCard(
                    title: "Backend & Cloud Services",
                    skills: [
                      "REST API Integration",
                      "Firebase Auth / Firestore",
                      "Firebase Analytics / Push Notifications",
                      "Supabase Auth / DB / Realtime",
                    ],
                    icon: Icons.cloud_queue_rounded,
                    width: cardWidth,
                  ),
                  _buildSkillCategoryCard(
                    title: "DevOps & Release Management",
                    skills: [
                      "Git & Version Control",
                      "App Store Deployment",
                      "Google Play Deployment",
                      "App Signing & Compliance",
                      "Crash Monitoring & Analytics",
                    ],
                    icon: Icons.rocket_launch_rounded,
                    width: cardWidth,
                  ),
                ],
              );
            },
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

  Widget _buildSkillCategoryCard({
    required String title,
    required List<String> skills,
    required IconData icon,
    required double width,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF131824).withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF202B3E)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF64FFDA), size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: skills.map((skill) => _SkillBadge(name: skill)).toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillBadge extends StatefulWidget {
  final String name;

  const _SkillBadge({required this.name});

  @override
  State<_SkillBadge> createState() => _SkillBadgeState();
}

class _SkillBadgeState extends State<_SkillBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: _isHovered
              ? const Color(0xFFBD00FF).withOpacity(0.15)
              : const Color(0xFF1E2638).withOpacity(0.5),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: _isHovered
                ? const Color(0xFFBD00FF)
                : const Color(0xFF2E3B54).withOpacity(0.7),
            width: 1.2,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: const Color(0xFFBD00FF).withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 1,
                  )
                ]
              : [],
        ),
        child: Text(
          widget.name,
          style: TextStyle(
            color: _isHovered ? Colors.white : const Color(0xFFECEFF4),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
