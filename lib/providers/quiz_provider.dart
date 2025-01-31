import 'package:flutter/material.dart';
import 'package:internquiz/models/quiz.dart';
import 'package:internquiz/services/quiz_service.dart';

class QuizProvider with ChangeNotifier {
  Quiz? _quiz;
  int _currentIndex = 0;
  int _score = 0;
  int _streak = 0;
  bool _isLoading = false;
  String? _error;
  int _correctAnswers = 0;
  int _totalAttempted = 0;
  double _accuracy = 0.0;
  double _speed = 0.0;
  DateTime? _lastQuestionStartTime;

  // Getters
  Quiz? get quiz => _quiz;
  int get currentIndex => _currentIndex;
  int get score => _score;
  int get streak => _streak;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get correctAnswers => _correctAnswers;
  double get accuracy => _accuracy;
  double get speed => _speed;
  Question? get currentQuestion =>
      _quiz != null && _currentIndex < _quiz!.questions.length
          ? _quiz!.questions[_currentIndex]
          : null;

  final QuizService _quizService = QuizService();

  Future<void> initializeQuiz() async {
    _isLoading = true;
    notifyListeners();

    try {
      _quiz = await _quizService.fetchQuiz();
      _error = null;
      _resetQuizStats();
      _lastQuestionStartTime = DateTime.now();
    } catch (e) {
      _error = e.toString();
      _quiz = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void answerQuestion(Answer answer, BuildContext context) {
    if (_quiz == null) return;

    final now = DateTime.now();
    final timeTaken = now.difference(_lastQuestionStartTime!).inSeconds;
    _updateSpeed(timeTaken);
    _lastQuestionStartTime = now;

    _totalAttempted++;

    if (answer.isCorrect) {
      _correctAnswers++;

      int questionScore = 10;
      questionScore += (_streak ~/ 3 * 5);

      if (timeTaken < 5) {
        questionScore += 5;
      } else if (timeTaken < 10) {
        questionScore += 3;
      } else if (timeTaken < 15) {
        questionScore += 1;
      }

      _score += questionScore;
      _streak++;
    } else {
      _streak = 0;
    }

    _accuracy = (_correctAnswers / _totalAttempted) * 100;

    if (_currentIndex < _quiz!.questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/results',
        (route) => false,
        arguments: {
          'correctAnswers': _correctAnswers,
          'testsCompleted': _totalAttempted,
          'fullScores': _streak,
          'accuracy': _accuracy,
          'speed': _speed,
          'totalCoins': _score,
          'trophy': _calculateTrophy(),
        },
      );
    }
    notifyListeners();
  }

  int _calculateTrophy() {
    if (_accuracy >= 90) return 3;
    if (_accuracy >= 70) return 2;
    if (_accuracy >= 50) return 1;
    return 0;
  }

  void _updateSpeed(int timeTaken) {
    if (_currentIndex == 0) {
      _speed = timeTaken.toDouble();
    } else {
      _speed = (_speed * _currentIndex + timeTaken) / (_currentIndex + 1);
    }
  }

  void _resetQuizStats() {
    _currentIndex = 0;
    _score = 0;
    _streak = 0;
    _correctAnswers = 0;
    _totalAttempted = 0;
    _accuracy = 0.0;
    _speed = 0.0;
    _lastQuestionStartTime = null;
  }

  void resetAndInitialize() {
    _resetQuizStats();
    initializeQuiz();
  }

  void resetQuiz() {
    _resetQuizStats();
    notifyListeners();
  }
}