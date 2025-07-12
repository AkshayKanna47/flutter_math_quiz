import 'package:cloud_firestore/cloud_firestore.dart';

class Score {
  final String userId;
  final int score;
  final DateTime timestamp;

  Score({required this.userId, required this.score, required this.timestamp});

  factory Score.fromMap(Map<String, dynamic> data) {
    return Score(
      userId: data['userId'] ?? 'unknown',
      score: data['score'] ?? 0,
      timestamp: data['timestamp'] != null
          ? (data['timestamp'] is Timestamp
                ? (data['timestamp'] as Timestamp).toDate()
                : DateTime.now())
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {'userId': userId, 'score': score, 'timestamp': timestamp};
  }
}

