import 'dart:math';
import 'package:flutter/material.dart';

class LiquidProgressIndicator extends StatefulWidget {
  final int current;
  final int total;
  final Color color;  // Add this line

  const LiquidProgressIndicator({
    super.key,
    required this.current,
    required this.total,
    required this.color, required Color glowColor, // Update this line to accept color
  });

  @override
  State<LiquidProgressIndicator> createState() => _LiquidProgressIndicatorState();
}


class _LiquidProgressIndicatorState extends State<LiquidProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      _animationController,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 120, 111, 243).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Wave Animation
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                size: const Size(30, 30),
                painter: _WavePainter(_animation.value),
              );
            },
          ),
          const SizedBox(width: 10),
          Text(
            'Question ${widget.current + 1}/${widget.total}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double waveValue;

  _WavePainter(this.waveValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color.fromARGB(255, 113, 157, 244)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * (0.5 + 0.4 * sin(waveValue * 2 * pi)))
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * (0.3 + 0.4 * sin(waveValue * 2 * pi + 1)),
        size.width * 0.5,
        size.height * 0.5,
      )
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * (0.7 + 0.4 * sin(waveValue * 2 * pi + 2)),
        size.width,
        size.height * 0.5,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
