import 'package:flutter/material.dart';
import 'package:internquiz/models/quiz.dart';

class AnswerCard extends StatefulWidget {
  final Answer answer;
  final VoidCallback onTap;
  final bool isSelected;

  const AnswerCard({
    super.key,
    required this.answer,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  _AnswerCardState createState() => _AnswerCardState();
}

class _AnswerCardState extends State<AnswerCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.isSelected
                        ? [const Color.fromARGB(255, 111, 120, 131), Colors.blue.shade600]
                        : [Colors.grey.shade800, Colors.grey.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: widget.isSelected
                          ? Colors.blue.shade200.withOpacity(0.5)
                          : Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Option Indicator
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: widget.isSelected
                              ? Colors.white.withOpacity(0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: widget.isSelected
                                ? Colors.white
                                : Colors.grey.shade500,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            widget.answer.id, // Assuming answer has an ID or label
                            style: TextStyle(
                              color: widget.isSelected
                                  ? Colors.white
                                  : Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Answer Text
                      Expanded(
                        child: Text(
                          widget.answer.description,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: widget.isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      // Correct/Wrong Indicator
                      if (widget.isSelected)
                        Icon(
                          widget.answer.isCorrect
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: widget.answer.isCorrect
                              ? Colors.green.shade400
                              : Colors.red.shade400,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}