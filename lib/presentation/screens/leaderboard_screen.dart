import 'dart:math'; // Added for min function
import 'package:flutter/material.dart';
import '../../data/services/firestore_service.dart';
import '../../data/models/score.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text('Leaderboard')),
      body: StreamBuilder<List<Score>>(
        stream: firestoreService.getLeaderboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No scores yet!'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final score = snapshot.data![index];
              return ListTile(
                leading: Text('#${index + 1}'),
                title: Text(
                  'User ${score.userId.substring(0, min(score.userId.length, 8))}',
                ),
                trailing: Text('Score: ${score.score}'),
              );
            },
          );
        },
      ),
    );
  }
}
