import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  final int answer;
  final VoidCallback onPressed;

  const AnswerButton({
    super.key,
    required this.answer,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(answer.toString(), style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
