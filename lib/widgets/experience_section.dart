import 'package:flutter/material.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

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
          _buildSectionHeader("03.", "Professional Experience", isMobile),
          const SizedBox(height: 40),

          // Timeline Column
          Column(
            children: [
              _buildTimelineItem(
                role: "Flutter Developer",
                company: "Digimantra Labs, Mohali",
                bullets: [
                  "Developing cross-platform mobile applications using Flutter & Dart.",
                  "Collaborating with team members to design and implement clean architectures and reusable UI components.",
                  "Integrating REST APIs and external databases (Supabase/Firebase) with robust exception handling.",
                  "Debugging, performance optimization, and memory profiling to ensure butter-smooth frame rates.",
                ],
                isCurrent: true,
                isMobile: isMobile,
              ),
              _buildTimelineItem(
                role: "Flutter Developer Intern",
                company: "Digimantra Labs (Internship)",
                bullets: [
                  "Assisted in crafting beautiful, responsive application screens based on Figma specs.",
                  "Collaborated on state management implementations (Provider, GetX) and local cache databases.",
                  "Gained hands-on experience in calling HTTP APIs and parsing complex JSON payloads.",
                  "Identified bug triggers, resolved crash logs, and prepared APKs/bundles for Google Play Console testing.",
                ],
                isCurrent: false,
                isMobile: isMobile,
                isLast: true,
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

  Widget _buildTimelineItem({
    required String role,
    required String company,
    required List<String> bullets,
    required bool isCurrent,
    required bool isMobile,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator line & node
          Column(
            children: [
              // Outer circle
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: isCurrent ? const Color(0xFF64FFDA).withOpacity(0.2) : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCurrent ? const Color(0xFF64FFDA) : const Color(0xFF505A70),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isCurrent ? const Color(0xFF64FFDA) : const Color(0xFF505A70),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              // Connecting line
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFF202B3E),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 24),

          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 56),
              decoration: BoxDecoration(
                color: const Color(0xFF131824).withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isCurrent ? const Color(0xFF64FFDA).withOpacity(0.5) : const Color(0xFF202B3E),
                ),
                boxShadow: isCurrent
                    ? [
                        BoxShadow(
                          color: const Color(0xFF64FFDA).withOpacity(0.03),
                          blurRadius: 15,
                          spreadRadius: 2,
                        )
                      ]
                    : [],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              role,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              company,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF64FFDA),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Period dates removed
                    ],
                  ),
                  const SizedBox(height: 20),
                  ...bullets.map((bullet) => Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "▹ ",
                              style: TextStyle(
                                color: Color(0xFFBD00FF),
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                bullet,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF909BB4),
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
