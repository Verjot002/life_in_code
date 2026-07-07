import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onContactPressed;

  const HeroSection({super.key, required this.onContactPressed});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
  late AnimationController _avatarRotationController;
  late AnimationController _pulseController;

  // Typing Effect Variables
  final List<String> _roles = [
    "Mobile Application Developer",
    "Flutter Specialist",
    "Cross-Platform Builder",
    "UI/UX Implementation Expert"
  ];
  int _currentRoleIndex = 0;
  String _displayedText = "";
  int _charIndex = 0;
  bool _isDeleting = false;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();

    // Rotate the glowing outer ring of the avatar
    _avatarRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Pulse effect for glow
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // Start Typing Effect loop
    _startTyping();
  }

  void _startTyping() {
    const pauseBeforeDelete = Duration(seconds: 2);
    const pauseBeforeType = Duration(milliseconds: 500);

    _typingTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!mounted) return;

      final currentRole = _roles[_currentRoleIndex];

      if (!_isDeleting) {
        // Typing state
        if (_charIndex < currentRole.length) {
          // Slow down writing
          if (timer.tick % 2 == 0) {
            setState(() {
              _displayedText = currentRole.substring(0, _charIndex + 1);
              _charIndex++;
            });
          }
        } else {
          // Pausing at complete word
          _isDeleting = true;
          _typingTimer?.cancel();
          Future.delayed(pauseBeforeDelete, () {
            if (mounted) _startTyping();
          });
        }
      } else {
        // Deleting state
        if (_charIndex > 0) {
          setState(() {
            _displayedText = currentRole.substring(0, _charIndex - 1);
            _charIndex--;
          });
        } else {
          // Word deleted, move to next
          _isDeleting = false;
          _currentRoleIndex = (_currentRoleIndex + 1) % _roles.length;
          _typingTimer?.cancel();
          Future.delayed(pauseBeforeType, () {
            if (mounted) _startTyping();
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _avatarRotationController.dispose();
    _pulseController.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      constraints: BoxConstraints(minHeight: size.height * 0.8),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : size.width * 0.08,
      ),
      child: Center(
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          verticalDirection: isMobile ? VerticalDirection.up : VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Column (Text & CTAs)
            Expanded(
              flex: isMobile ? 0 : 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  if (isMobile) const SizedBox(height: 30),
                  // Welcome Tag
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF64FFDA).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: const Color(0xFF64FFDA).withOpacity(0.3),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.insights,
                          size: 14,
                          color: Color(0xFF64FFDA),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Available for Freelance & Full-time",
                          style: TextStyle(
                            color: Color(0xFF64FFDA),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Name Headline
                  Text(
                    "VERJOT HEER",
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    style: TextStyle(
                      fontSize: isMobile ? 36 : 56,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.5,
                      height: 1.1,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: [Colors.white, Color(0xFF909BB4)],
                        ).createShader(
                          const Rect.fromLTWH(0.0, 0.0, 400.0, 70.0),
                        ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Typed Subtitle
                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment:
                          isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
                      children: [
                        Text(
                          _displayedText,
                          style: TextStyle(
                            fontSize: isMobile ? 18 : 24,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFBD00FF), // Neon Purple
                          ),
                        ),
                        // Cursor animation
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _pulseController.value > 0.5 ? 1.0 : 0.0,
                              child: Container(
                                width: 3,
                                height: isMobile ? 22 : 28,
                                margin: const EdgeInsets.only(left: 4),
                                color: const Color(0xFFBD00FF),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Short bio
                  Text(
                    "I am a Mobile Application Developer with 1.5 years of professional experience crafting fluid, scalable, and high-performance cross-platform apps using Flutter & Dart. Let's translate your ideas into sleek pixel-perfect code.",
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF909BB4),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Action Buttons
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      // Primary action button (Hire Me)
                      ElevatedButton(
                        onPressed: widget.onContactPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF64FFDA),
                          foregroundColor: const Color(0xFF07090E),
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 8,
                          shadowColor: const Color(0xFF64FFDA).withOpacity(0.3),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Hire Me",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, size: 18),
                          ],
                        ),
                      ),
                      // Secondary action button (Download CV)
                      OutlinedButton(
                        onPressed: _launchEmail,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFF202B3E), width: 2),
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.alternate_email, size: 18),
                            SizedBox(width: 8),
                            Text(
                              "Get in Touch",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (!isMobile) const SizedBox(width: 40),

            // Right Column (Glow Avatar Representation)
            Expanded(
              flex: isMobile ? 0 : 5,
              child: Center(
                child: SizedBox(
                  width: isMobile ? 240 : 360,
                  height: isMobile ? 240 : 360,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Rotating Neon Halo Rings (Background decoration)
                      RotationTransition(
                        turns: _avatarRotationController,
                        child: CustomPaint(
                          size: Size(isMobile ? 220 : 340, isMobile ? 220 : 340),
                          painter: AvatarRingPainter(
                            color1: const Color(0xFF64FFDA),
                            color2: const Color(0xFFBD00FF),
                          ),
                        ),
                      ),
                      // Pulse Glow effect background
                      ScaleTransition(
                        scale: Tween<double>(begin: 0.95, end: 1.05).animate(
                          CurvedAnimation(
                            parent: _pulseController,
                            curve: Curves.easeInOut,
                          ),
                        ),
                        child: Container(
                          width: isMobile ? 180 : 280,
                          height: isMobile ? 180 : 280,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF64FFDA).withOpacity(0.12),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Sleek tech-avatar core
                      Container(
                        width: isMobile ? 170 : 260,
                        height: isMobile ? 170 : 260,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0D111A),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF202B3E),
                            width: 3,
                          ),
                        ),
                        child: ClipOval(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) => const LinearGradient(
                                    colors: [Color(0xFF64FFDA), Color(0xFFBD00FF)],
                                  ).createShader(bounds),
                                  child: Icon(
                                    Icons.developer_mode_rounded,
                                    size: isMobile ? 60 : 90,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "LIFE IN CODE",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 3.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'verjotheer@gmail.com',
      queryParameters: {
        'subject': 'Project Inquiry - Portfolio App'
      },
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }
}

class AvatarRingPainter extends CustomPainter {
  final Color color1;
  final Color color2;

  AvatarRingPainter({required this.color1, required this.color2});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..shader = LinearGradient(
        colors: [color1, color2, color1.withOpacity(0.1), color2, color1],
        stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
      ).createShader(rect);

    canvas.drawArc(rect, 0, 1.8 * 3.1415, false, paint);
    canvas.drawArc(rect, 2.0 * 3.1415, 0.3 * 3.1415, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
