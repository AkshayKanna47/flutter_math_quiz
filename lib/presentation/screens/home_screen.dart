import 'package:flutter/material.dart';
import '../../providers/quiz_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Math Quiz')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Provider.of<QuizProvider>(context, listen: false).resetQuiz();
                Navigator.pushNamed(context, '/quiz');
              },
              child: const Text('Start Quiz'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/leaderboard');
              },
              child: const Text('View Leaderboard'),
            ),
          ],
        ),
      ),
    );
  }
}
