import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/quiz_provider.dart';
import '../widgets/question_widget.dart';
import '../widgets/answer_button.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final question = quizProvider.questions[quizProvider.currentQuestionIndex];
    quizProvider.startTimer(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${quizProvider.currentQuestionIndex + 1}/10'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Time Left: ${quizProvider.timeLeft}s',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            QuestionWidget(questionText: question.text),
            const SizedBox(height: 20),
            ...question.answers.map(
              (answer) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: AnswerButton(
                  answer: answer,
                  onPressed: () => quizProvider.checkAnswer(answer, context),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Score: ${quizProvider.score}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
