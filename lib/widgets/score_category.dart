import 'package:flutter/material.dart';

class ScoreCategoryAnimation extends StatefulWidget {
  final double percentage;

  const ScoreCategoryAnimation({super.key, required this.percentage});

  @override
  _ScoreCategoryAnimationState createState() => _ScoreCategoryAnimationState();
}

class _ScoreCategoryAnimationState extends State<ScoreCategoryAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final category = _getCategory(widget.percentage);
    
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Column(
          children: [
            Icon(
              category.icon,
              size: 80,
              color: category.color.withOpacity(0.8),
            ),
            const SizedBox(height: 20),
            Text(
              category.text,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: category.color,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(2, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _CategoryData _getCategory(double percentage) {
    if (percentage < 30) {
      return _CategoryData(
        icon: Icons.sentiment_very_dissatisfied,
        text: 'Needs Improvement',
        color: Colors.redAccent,
      );
    } else if (percentage < 50) {
      return _CategoryData(
        icon: Icons.sentiment_dissatisfied,
        text: 'Keep Practicing',
        color: Colors.orangeAccent,
      );
    } else if (percentage < 80) {
      return _CategoryData(
        icon: Icons.sentiment_satisfied,
        text: 'Good Job!',
        color: Colors.blueAccent,
      );
    } else {
      return _CategoryData(
        icon: Icons.sentiment_very_satisfied,
        text: 'Excellent!',
        color: Colors.greenAccent,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _CategoryData {
  final IconData icon;
  final String text;
  final Color color;

  _CategoryData({
    required this.icon,
    required this.text,
    required this.color,
  });
}