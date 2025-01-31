import 'package:flutter/material.dart';
import 'package:internquiz/models/quiz.dart';
import 'package:internquiz/providers/quiz_provider.dart';
import 'package:internquiz/widgets/animation_option.dart';
import 'package:internquiz/widgets/liquid-indicator.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, _) {
        final question = provider.currentQuestion;

        return Scaffold(
          backgroundColor: const Color(0xFF1E1E1E), // Dark gray background
          body: Stack(
            children: [
              // Background
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1E1E1E), // Dark gray
                      Color(0xFF252525), // Slightly lighter gray
                    ],
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Header
                    _buildAppHeader(context, provider),

                    // Question Card with Floating Animation
                    _buildAnimatedQuestionCard(question),

                    // Options Grid
                    Expanded(
                      child: _buildOptionsGrid(provider, question, context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppHeader(BuildContext context, QuizProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Streak Counter with Pulse Animation
          _buildStreakCounter(provider),
          // Progress Indicator
          _buildProgressIndicator(provider),
        ],
      ),
    );
  }

  Widget _buildStreakCounter(QuizProvider provider) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 1.1),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.2), // Softer glow effect
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.orangeAccent),
            ),
            child: Row(
              children: [
                const Icon(Icons.local_fire_department, color: Colors.orangeAccent),
                const SizedBox(width: 8),
                Text(
                  '${provider.streak}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressIndicator(QuizProvider provider) {
    return LiquidProgressIndicator(
      current: provider.currentIndex,
      total: provider.quiz?.questions.length ?? 0,
      color: const Color(0xFF007BFF), 
      glowColor: Colors.yellow, // Vibrant blue for contrast
    );
  }

  Widget _buildAnimatedQuestionCard(Question? question) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 50),
            child: child,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 30),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: const Color(0xFF252525), // Slightly lighter than background
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            const Icon(Icons.biotech, color: Colors.lightBlueAccent, size: 40),
            const SizedBox(height: 15),
            Text(
              question?.description ?? 'Loading question...',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionsGrid(QuizProvider provider, Question? question, BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: question?.options.length ?? 0,
      itemBuilder: (context, index) {
        final answer = question!.options[index];
        return AnimatedOptionCard(
          answer: answer,
          onTap: () => provider.answerQuestion(answer, context),
          color: _getOptionCardColor(index), // Dynamic colors for variety
        );
      },
    );
  }

  Color _getOptionCardColor(int index) {
    // Using different colors for options, similar to the provided image
    const List<Color> colors = [
      Color(0xFFFFA726), // Orange
      Color(0xFF29B6F6), // Light Blue
      Color(0xFFFFEB3B), // Yellow
      Color(0xFF66BB6A), // Green
    ];
    return colors[index % colors.length]; // Cycling through colors
  }
}
