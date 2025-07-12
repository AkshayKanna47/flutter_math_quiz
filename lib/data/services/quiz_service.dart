import 'dart:math';
import '../models/question.dart';

class QuizService {
  final Random _random = Random();

  List<Question> generateQuestions(int count) {
    return List.generate(count, (_) => _generateQuestion());
  }

  Question _generateQuestion() {
    final num1 = _random.nextInt(20) + 1;
    final num2 = _random.nextInt(20) + 1;
    final operators = ['+', '-', '×', '÷'];
    final operator = operators[_random.nextInt(4)];
    int correctAnswer;
    String questionText;

    switch (operator) {
      case '+':
        correctAnswer = num1 + num2;
        questionText = '$num1 + $num2';
        break;
      case '-':
        correctAnswer = num1 - num2;
        questionText = '$num1 - $num2';
        break;
      case '×':
        correctAnswer = num1 * num2;
        questionText = '$num1 × $num2';
        break;
      case '÷':
        correctAnswer = (num1 / num2).floor();
        questionText = '$num1 ÷ $num2';
        break;
      default:
        correctAnswer = num1 + num2;
        questionText = '$num1 + $num2';
    }

    final answers = [correctAnswer];
    while (answers.length < 4) {
      final wrongAnswer = correctAnswer + _random.nextInt(20) - 10;
      if (!answers.contains(wrongAnswer) && wrongAnswer != correctAnswer) {
        answers.add(wrongAnswer);
      }
    }
    answers.shuffle();
    return Question(
      text: questionText,
      correctAnswer: correctAnswer,
      answers: answers,
    );
  }
}
