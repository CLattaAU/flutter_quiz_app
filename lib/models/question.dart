// import 'package:flutter_quiz_app/models/answer.dart';

class Question {
  final int? id;
  final String text;
  // final List<Answer> answers;

  const Question({this.id, required this.text});

  Map<String, dynamic> toMap() {
    return {'id': id, 'text': text};
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(id: map['id'], text: map['text']);
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(text: json['text']);
  }
}
