// main.dart
import 'package:flutter/material.dart';

import 'package:internquiz/providers/quiz_provider.dart';
import 'package:internquiz/screens/home_screen.dart';
import 'package:internquiz/screens/quiz_screen.dart';
import 'package:internquiz/screens/result_screen.dart';

import 'package:internquiz/splashscreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: MaterialApp(
        title: 'Biology Quiz',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Roboto',
        ),
        home: const ModernSplash(child: HomeScreen()),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (context) => const HomeScreen());
            case '/quiz':
              return MaterialPageRoute(builder: (context) => const QuizScreen());
            case '/results':
              final args = settings.arguments as Map<String, dynamic>;
              return MaterialPageRoute(
                builder: (context) => TestlineResultScreen(
                  correctAnswers: args['correctAnswers'] as int,
                  testsCompleted: args['testsCompleted'] as int,
                  fullScores: args['fullScores'] as int,
                  accuracy: args['accuracy'] as double,
                  speed: args['speed'] as double,
                  totalCoins: args['totalCoins'] as int,
                  trophy: args['trophy'] as int,
                ),
              );
            default:
              return MaterialPageRoute(builder: (context) => const HomeScreen());
          }
        },
      ),
    );
  }
}