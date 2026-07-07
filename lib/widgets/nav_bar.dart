import 'dart:ui';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onMenuPressed;
  final Function(int) onNavPressed;

  const NavBar({
    super.key,
    required this.isMobile,
    required this.onMenuPressed,
    required this.onNavPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(isMobile ? 12 : 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF0D111A).withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF202B3E).withOpacity(0.5),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo / Branding
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => onNavPressed(0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF64FFDA), Color(0xFFBD00FF)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.terminal,
                            color: Color(0xFF07090E),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "VH",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Navigation Items
                if (isMobile)
                  IconButton(
                    icon: const Icon(Icons.menu_rounded, color: Colors.white),
                    onPressed: onMenuPressed,
                  )
                else
                  Row(
                    children: [
                      _NavBarItem(label: "Home", onTap: () => onNavPressed(0)),
                      _NavBarItem(label: "About", onTap: () => onNavPressed(1)),
                      _NavBarItem(label: "Skills", onTap: () => onNavPressed(2)),
                      _NavBarItem(label: "Experience", onTap: () => onNavPressed(3)),
                      _NavBarItem(label: "Projects", onTap: () => onNavPressed(4)),
                      const SizedBox(width: 16),
                      // Contact Call-to-Action button
                      ElevatedButton(
                        onPressed: () => onNavPressed(5),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: const Color(0xFF64FFDA),
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Color(0xFF64FFDA), width: 1.5),
                          ),
                        ),
                        child: const Text(
                          "Contact Me",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.label,
    required this.onTap,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _isHovered ? const Color(0xFF64FFDA) : const Color(0xFF909BB4),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class MobileDrawer extends StatelessWidget {
  final Function(int) onSectionSelected;

  const MobileDrawer({
    super.key,
    required this.onSectionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0A0D14),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF64FFDA), Color(0xFFBD00FF)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.terminal,
                    color: Color(0xFF07090E),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "VERJOT HEER",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              "Mobile Application Developer",
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF64FFDA),
              ),
            ),
            const SizedBox(height: 40),
            const Divider(color: Color(0xFF202B3E)),
            _DrawerItem(icon: Icons.home_rounded, label: "Home", onTap: () => onSectionSelected(0)),
            _DrawerItem(icon: Icons.person_rounded, label: "About Me", onTap: () => onSectionSelected(1)),
            _DrawerItem(icon: Icons.construction_rounded, label: "Skills", onTap: () => onSectionSelected(2)),
            _DrawerItem(icon: Icons.history_edu_rounded, label: "Experience", onTap: () => onSectionSelected(3)),
            _DrawerItem(icon: Icons.layers_rounded, label: "Projects", onTap: () => onSectionSelected(4)),
            _DrawerItem(icon: Icons.alternate_email_rounded, label: "Contact", onTap: () => onSectionSelected(5)),
            const Spacer(),
            const Text(
              "Hoshiarpur, Punjab, India",
              style: TextStyle(fontSize: 12, color: Color(0xFF505A70)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF64FFDA)),
      title: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
