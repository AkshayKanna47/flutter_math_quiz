import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'providers/quiz_provider.dart';
import 'presentation/screens/auth_screen.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/quiz_screen.dart';
import 'presentation/screens/result_screen.dart';
import 'presentation/screens/leaderboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAImwJZb32dTM-Ec5mS_SdOJiWfXKfeDsA",
      authDomain: "flutterquiz-9dd1e.firebaseapp.com",
      projectId: "flutterquiz-9dd1e",
      storageBucket: "flutterquiz-9dd1e.firebasestorage.app",
      messagingSenderId: "374395504651",
      appId: "1:374395504651:web:9e5bd0f444208e8f895f0e",
    ),
  );
  runApp(const MathQuizApp());
}

class MathQuizApp extends StatelessWidget {
  const MathQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Math Quiz',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
        ),
        initialRoute: '/auth',
        routes: {
          '/auth': (context) => const AuthScreen(),
          '/home': (context) => const HomeScreen(),
          '/quiz': (context) => const QuizScreen(),
          '/result': (context) => const ResultScreen(),
          '/leaderboard': (context) => const LeaderboardScreen(),
        },
      ),
    );
  }
}
