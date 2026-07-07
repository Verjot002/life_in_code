import 'dart:math';
import 'package:flutter/material.dart';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final Random _random = Random();
  Offset? _mousePosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Initialize particles
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeParticles();
    });
  }

  void _initializeParticles() {
    final size = MediaQuery.of(context).size;
    final particleCount = (size.width * size.height / 15000).clamp(30, 80).toInt();

    _particles.clear();
    for (int i = 0; i < particleCount; i++) {
      _particles.add(
        Particle(
          position: Offset(
            _random.nextDouble() * size.width,
            _random.nextDouble() * size.height,
          ),
          velocity: Offset(
            (_random.nextDouble() - 0.5) * 0.6,
            (_random.nextDouble() - 0.5) * 0.6,
          ),
          radius: _random.nextDouble() * 2.0 + 1.0,
          color: _random.nextBool()
              ? const Color(0xFF64FFDA).withOpacity(0.3) // Teal
              : const Color(0xFFBD00FF).withOpacity(0.3), // Purple
        ),
      );
    }
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePosition = event.localPosition;
        });
      },
      onExit: (_) {
        setState(() {
          _mousePosition = null;
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          _updateParticles();
          return CustomPaint(
            painter: ParticlePainter(
              particles: _particles,
              mousePosition: _mousePosition,
            ),
            child: Container(),
          );
        },
      ),
    );
  }

  void _updateParticles() {
    if (_particles.isEmpty) return;
    final size = MediaQuery.of(context).size;

    for (var particle in _particles) {
      // Move particle
      particle.position += particle.velocity;

      // Interaction with mouse (repel effect)
      if (_mousePosition != null) {
        final dx = particle.position.dx - _mousePosition!.dx;
        final dy = particle.position.dy - _mousePosition!.dy;
        final distance = sqrt(dx * dx + dy * dy);

        if (distance < 120) {
          // Repel force
          final force = (120 - distance) / 120;
          final angle = atan2(dy, dx);
          final pushX = cos(angle) * force * 1.5;
          final pushY = sin(angle) * force * 1.5;

          // Apply temporary acceleration without overriding base velocity permanently
          particle.position += Offset(pushX, pushY);
        }
      }

      // Keep particles inside screen bounds
      double x = particle.position.dx;
      double y = particle.position.dy;

      if (x < 0) {
        x = size.width;
      } else if (x > size.width) {
        x = 0;
      }

      if (y < 0) {
        y = size.height;
      } else if (y > size.height) {
        y = 0;
      }

      particle.position = Offset(x, y);
    }
  }
}

class Particle {
  Offset position;
  Offset velocity;
  final double radius;
  final Color color;

  Particle({
    required this.position,
    required this.velocity,
    required this.radius,
    required this.color,
  });
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Offset? mousePosition;

  ParticlePainter({
    required this.particles,
    required this.mousePosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final particlePaint = Paint()..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    // Draw lines between particles
    for (int i = 0; i < particles.length; i++) {
      final p1 = particles[i];
      for (int j = i + 1; j < particles.length; j++) {
        final p2 = particles[j];
        final dx = p1.position.dx - p2.position.dx;
        final dy = p1.position.dy - p2.position.dy;
        final distance = sqrt(dx * dx + dy * dy);

        if (distance < 100) {
          final opacity = (1.0 - (distance / 100)) * 0.15;
          // Gradient link color depending on particles
          linePaint.color = const Color(0xFF64FFDA).withOpacity(opacity);
          canvas.drawLine(p1.position, p2.position, linePaint);
        }
      }

      // Draw line to mouse
      if (mousePosition != null) {
        final dx = p1.position.dx - mousePosition!.dx;
        final dy = p1.position.dy - mousePosition!.dy;
        final distance = sqrt(dx * dx + dy * dy);

        if (distance < 150) {
          final opacity = (1.0 - (distance / 150)) * 0.25;
          linePaint.color = const Color(0xFFBD00FF).withOpacity(opacity);
          canvas.drawLine(p1.position, mousePosition!, linePaint);
        }
      }

      // Draw particle
      particlePaint.color = p1.color;
      canvas.drawCircle(p1.position, p1.radius, particlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}
