import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    final List<Map<String, dynamic>> projects = [
      {
        "title": "VehiPub",
        "subtitle": "French Vehicle Marketplace App",
        "description":
            "A feature-rich French vehicle advertising and marketplace mobile application. Built using Flutter for the cross-platform frontend and integrated Supabase fully for authentication, relational database, secure storage, and real-time syncing.",
        "tags": ["Flutter", "Supabase", "Realtime Sync", "Auth & Storage"],
        "icon": Icons.directions_car_rounded,
        "accent": const Color(0xFFBD00FF), // Purple
      },
      {
        "title": "Doctor Matic",
        "subtitle": "Healthcare Appointment App",
        "description":
            "A healthcare-oriented mobile application that allows patients to search for doctors, book appointments, and view checkup records. Designed with a clean, friendly UI and integrated REST APIs for real-time schedule management.",
        "tags": ["Flutter & Dart", "REST APIs", "User-Friendly UI", "Secure Booking"],
        "icon": Icons.local_hospital_rounded,
        "accent": const Color(0xFF64FFDA), // Teal
      },
      {
        "title": "Mobile Petrol Station (MPS)",
        "subtitle": "On-demand Fuel Delivery App",
        "description":
            "An innovative on-demand fuel ordering and logistics tracking mobile application. Features live location tracking, driver assignments, real-time map updates, and a payment portal.",
        "tags": ["Flutter", "Realtime Map", "Location Tracking", "Payment Integration"],
        "icon": Icons.local_gas_station_rounded,
        "accent": const Color(0xFFBD00FF), // Purple
      },
      {
        "title": "Kofluence",
        "subtitle": "Influencer Marketing Platform",
        "description":
            "Contributed to the influencer marketing mobile ecosystem connecting brands and content creators. Focused on optimizing scroll performance for image-heavy grids, responsive interfaces, and push notifications.",
        "tags": ["Flutter", "Performance Optimization", "Push Notifications", "Figma to Code"],
        "icon": Icons.campaign_rounded,
        "accent": const Color(0xFF64FFDA), // Teal
      },
      {
        "title": "All the Smoke",
        "subtitle": "Feature-Rich Lifestyle App",
        "description":
            "A fast, modern lifestyle-centric mobile application. Developed with customized widgets, complex scroll view controllers, custom animations, and a rich, dark UI vibe.",
        "tags": ["Flutter & Dart", "Custom Animations", "Fluid UI", "State Management"],
        "icon": Icons.smoke_free_rounded,
        "accent": const Color(0xFFBD00FF), // Purple
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 24 : size.width * 0.08,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          _buildSectionHeader("04.", "Featured Projects", isMobile),
          const SizedBox(height: 40),

          // Project Cards Wrap
          LayoutBuilder(
            builder: (context, constraints) {
              final double cardWidth = isMobile
                  ? constraints.maxWidth
                  : (constraints.maxWidth - 24) / 2;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: projects
                    .map((project) => _ProjectCard(
                          title: project["title"],
                          subtitle: project["subtitle"],
                          description: project["description"],
                          tags: project["tags"],
                          icon: project["icon"],
                          accentColor: project["accent"],
                          width: cardWidth,
                        ))
                    .toList(),
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
}

class _ProjectCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String description;
  final List<String> tags;
  final IconData icon;
  final Color accentColor;
  final double width;

  const _ProjectCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.tags,
    required this.icon,
    required this.accentColor,
    required this.width,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: widget.width,
        padding: const EdgeInsets.all(28),
        transform: _isHovered
            ? (Matrix4.identity()
              ..translate(0, -6, 0)
              ..scale(1.01))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: const Color(0xFF131824).withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? widget.accentColor : const Color(0xFF202B3E),
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.accentColor.withOpacity(0.12),
                    blurRadius: 25,
                    spreadRadius: 2,
                    offset: const Offset(0, 10),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row (Icon & Title)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? widget.accentColor.withOpacity(0.15)
                        : const Color(0xFF07090E).withOpacity(0.6),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isHovered
                          ? widget.accentColor
                          : const Color(0xFF202B3E),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    widget.icon,
                    color: _isHovered ? widget.accentColor : const Color(0xFF909BB4),
                    size: 24,
                  ),
                ),
                const Icon(
                  Icons.arrow_outward_rounded,
                  color: Color(0xFF505A70),
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Card Header Text
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.subtitle,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: widget.accentColor,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              widget.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF909BB4),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            // Tags Wrap
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.tags
                  .map((tag) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2638).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFF2E3B54).withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFFECEFF4),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
