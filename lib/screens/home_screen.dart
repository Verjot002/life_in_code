import 'package:flutter/material.dart';
import '../widgets/particle_background.dart';
import '../widgets/nav_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/contact_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // GlobalKeys to reference sections for smooth scrolling
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Scaffold(
      key: _scaffoldKey,
      drawer: isMobile
          ? MobileDrawer(
              onSectionSelected: (sectionIndex) {
                Navigator.pop(context); // Close drawer
                _handleNavigation(sectionIndex);
              },
            )
          : null,
      body: Stack(
        children: [
          // Background - Deep Obsidian Space + Interactive Particles
          const Positioned.fill(
            child: ParticleBackground(),
          ),

          // Scrollable Content
          SelectionArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Spacer to offset the floating navbar in desktop
                  SizedBox(height: isMobile ? 70 : 100),

                  // Sections
                  HeroSection(key: _heroKey, onContactPressed: () => _scrollToSection(_contactKey)),
                  AboutSection(key: _aboutKey),
                  SkillsSection(key: _skillsKey),
                  ExperienceSection(key: _experienceKey),
                  ProjectsSection(key: _projectsKey),
                  ContactSection(key: _contactKey),

                  // Footer
                  const FooterSection(),
                ],
              ),
            ),
          ),

          // Header Navigation Bar (Floating Glassmorphism)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              isMobile: isMobile,
              onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
              onNavPressed: _handleNavigation,
            ),
          ),
        ],
      ),
    );
  }

  void _handleNavigation(int index) {
    switch (index) {
      case 0:
        _scrollToSection(_heroKey);
        break;
      case 1:
        _scrollToSection(_aboutKey);
        break;
      case 2:
        _scrollToSection(_skillsKey);
        break;
      case 3:
        _scrollToSection(_experienceKey);
        break;
      case 4:
        _scrollToSection(_projectsKey);
        break;
      case 5:
        _scrollToSection(_contactKey);
        break;
    }
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFF06080C),
        border: Border(
          top: BorderSide(color: Color(0xFF131824), width: 1),
        ),
      ),
      child: Column(
        children: [
          const Text(
            "VERJOT HEER",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Mobile Application Developer (Flutter)",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF64FFDA),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "© 2026 Verjot Heer. All Rights Reserved.",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF505A70),
            ),
          ),
          const SizedBox(height: 8),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     const Icon(Icons.code, size: 14, color: Color(0xFF505A70)),
          //     const SizedBox(width: 4),
          //     Text(
          //       "Handcrafted with Flutter Web",
          //       style: TextStyle(
          //         fontSize: 12,
          //         fontStyle: FontStyle.italic,
          //         color: const Color(0xFF505A70).withOpacity(0.8),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
