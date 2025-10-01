import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/pages/quiz_page.dart';

void main() {
  runApp(MaterialApp(home: FlutterQuizApp()));
}

class FlutterQuizApp extends StatelessWidget {
  const FlutterQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return QuizPage();
  }
}
