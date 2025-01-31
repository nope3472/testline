import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:provider/provider.dart';
import 'package:internquiz/providers/quiz_provider.dart';
import 'dart:math' show pi;

class TestlineResultScreen extends StatefulWidget {
  final int correctAnswers;
  final int testsCompleted;
  final int fullScores;
  final double accuracy;
  final double speed;
  final int totalCoins;
  final int trophy;

  const TestlineResultScreen({
    super.key,
    required this.correctAnswers,
    required this.testsCompleted,
    required this.fullScores,
    required this.accuracy,
    required this.speed,
    required this.totalCoins,
    required this.trophy,
  });

  @override
  State<TestlineResultScreen> createState() => _TestlineResultScreenState();
}

class _TestlineResultScreenState extends State<TestlineResultScreen> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 5));
    if (widget.accuracy >= 70) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1E1B4B), Color(0xFF312E81)],
            ),
          ),
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    _buildTopBar(),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          const SizedBox(height: 16),
                          _buildHeader(),
                          const SizedBox(height: 16),
                          Text(
                            _getMotivationalMessage(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          _buildStatsGrid(),
                          const SizedBox(height: 24),
                          _buildProgressSection(),
                          const SizedBox(height: 24),
                          _buildBottomStats(),
                          const SizedBox(height: 24),
                          _buildActionButtons(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirection: pi / 2,
                  maxBlastForce: 5,
                  minBlastForce: 2,
                  emissionFrequency: 0.05,
                  numberOfParticles: 50,
                  gravity: 0.1,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              final quizProvider = Provider.of<QuizProvider>(context, listen: false);
              quizProvider.resetAndInitialize();
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/quiz',
                (route) => false,
              );
            },
            child: const Text(
              'Reattempt Quiz',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/home',
                (route) => false,
              );
            },
            child: const Text(
              'Back to Home',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  String _getMotivationalMessage() {
    if (widget.accuracy >= 90) {
      return 'Outstanding! You\'re a Champion! 🏆';
    } else if (widget.accuracy >= 70) {
      return 'Great Job! Keep it up! 🌟';
    } else if (widget.accuracy >= 50) {
      return 'Good effort! Room to improve! 💪';
    } else {
      return 'Keep practicing! You\'ll get better! 📚';
    }
  }

  Color _getAccuracyColor() {
    if (widget.accuracy >= 90) return Colors.green;
    if (widget.accuracy >= 70) return Colors.blue;
    if (widget.accuracy >= 50) return Colors.orange;
    return Colors.red;
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTopBarItem(Icons.edit, 'Edit Profile'),
          _buildTopBarItem(Icons.settings, 'Settings'),
          _buildTopBarItem(Icons.share, 'Share Report'),
        ],
      ),
    );
  }

  Widget _buildTopBarItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Text(
                'Quiz',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'Quiz Report',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.check_circle,
            value: widget.correctAnswers.toString(),
            label: 'Correct\nAnswers',
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            icon: Icons.assignment,
            value: widget.testsCompleted.toString(),
            label: 'Tests\nCompleted',
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildStatCard(
            icon: Icons.emoji_events,
            value: widget.fullScores.toString(),
            label: 'Full\nScores',
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProgressRow('Accuracy', widget.accuracy, _getAccuracyColor()),
          const SizedBox(height: 16),
          _buildProgressRow('Speed(lower the better)', widget.speed, Colors.green),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Score',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                '${widget.correctAnswers}/${widget.testsCompleted}',
                style: TextStyle(
                  color: _getAccuracyColor(),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildProgressRow(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: value / 100,
            backgroundColor: Colors.white.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${value.toStringAsFixed(1)}%',
          style: TextStyle(color: color),
        ),
      ],
    );
  }

  Widget _buildBottomStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBottomStatItem('Total Coins', widget.totalCoins.toString()),
        _buildBottomStatItem('Trophy', widget.trophy.toString()),
      ],
    );
  }

  Widget _buildBottomStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(Icons.dashboard, 'DPP'),
          _buildNavItem(Icons.assignment, 'Tests'),
          _buildNavItem(Icons.local_offer, 'Offers'),
          _buildNavItem(Icons.person, 'Profile', isSelected: true),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, {bool isSelected = false}) {
    final color = isSelected ? Colors.teal : Colors.white.withOpacity(0.7);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: color, fontSize: 12),
        ),
      ],
    );
  }
}