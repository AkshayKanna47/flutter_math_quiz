import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/score.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveScore(Score score) async {
    await _db.collection('scores').add(score.toMap());
  }

  Stream<List<Score>> getLeaderboard() {
    return _db
        .collection('scores')
        .orderBy('score', descending: true)
        .limit(10)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Score.fromMap(doc.data())).toList(),
        );
  }
}
