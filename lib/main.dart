import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/pages/quiz_page.dart';
import 'package:flutter_quiz_app/services/db_initializer.dart';
import 'package:flutter_quiz_app/services/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DBInitializer.init();
  DBService.initDB();
  runApp(MaterialApp(home: FlutterQuizApp()));
}

class FlutterQuizApp extends StatelessWidget {
  const FlutterQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return QuizPage();
  }
}
