import 'package:flutter_quiz_app/models/answer.dart';

class Question {
  final String text;
  final List<Answer> answers;

  const Question({required this.text, required this.answers});
}
