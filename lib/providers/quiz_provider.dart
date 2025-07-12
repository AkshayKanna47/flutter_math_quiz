import 'dart:async';
import 'package:flutter/material.dart';
import '../data/models/score.dart';
import '../data/models/question.dart';
import '../data/services/quiz_service.dart';
import '../data/services/firestore_service.dart';
import '../data/services/auth_service.dart';

class QuizProvider with ChangeNotifier {
  final QuizService _quizService = QuizService();
  final FirestoreService _firestoreService = FirestoreService();
  final AuthService _authService = AuthService();
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  Timer? _timer;
  int _timeLeft = 15;

  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  int get timeLeft => _timeLeft;

  QuizProvider() {
    _questions = _quizService.generateQuestions(10);
  }

  void startTimer(BuildContext context) {
    _timer?.cancel();
    _timeLeft = 15;
    notifyListeners();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        timer.cancel();
        _nextQuestion(context);
      }
    });
  }

  void checkAnswer(int selectedAnswer, BuildContext context) {
    _timer?.cancel();
    if (selectedAnswer == _questions[_currentQuestionIndex].correctAnswer) {
      _score += 10;
    }
    _nextQuestion(context);
  }

  void _nextQuestion(BuildContext context) {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      startTimer(context);
    } else {
      _saveScore();
      Navigator.pushReplacementNamed(context, '/result', arguments: _score);
    }
    notifyListeners();
  }

  Future<void> _saveScore() async {
    final user = _authService.getCurrentUser();
    if (user != null) {
      final score = Score(
        userId: user.uid,
        score: _score,
        timestamp: DateTime.now(), // Use local timestamp for Score object
      );
      await _firestoreService.saveScore(score);
    }
  }

  void resetQuiz() {
    _score = 0;
    _currentQuestionIndex = 0;
    _questions = _quizService.generateQuestions(10);
    _timeLeft = 15;
    notifyListeners();
  }
}
