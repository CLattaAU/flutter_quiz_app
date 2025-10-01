import 'package:flutter_quiz_app/models/answer.dart';
import 'package:flutter_quiz_app/models/question.dart';

final List<Question> questions = [
  Question(
    text: "What is the capital of Germany",
    answers: [
      Answer(text: 'Berlin', isCorrect: true),
      Answer(text: 'Paris', isCorrect: false),
      Answer(text: 'Rome', isCorrect: false),
      Answer(text: 'Madrid', isCorrect: false),
    ],
  ),
  Question(
    text: "What is the capital of Spain",
    answers: [
      Answer(text: 'Berlin', isCorrect: false),
      Answer(text: 'Paris', isCorrect: false),
      Answer(text: 'Rome', isCorrect: false),
      Answer(text: 'Madrid', isCorrect: true),
    ],
  ),
  Question(
    text: "What is the capital of Italy",
    answers: [
      Answer(text: 'Berlin', isCorrect: false),
      Answer(text: 'Paris', isCorrect: false),
      Answer(text: 'Rome', isCorrect: true),
      Answer(text: 'Madrid', isCorrect: false),
    ],
  ),
  Question(
    text: "What is the capital of France",
    answers: [
      Answer(text: 'Berlin', isCorrect: false),
      Answer(text: 'Paris', isCorrect: true),
      Answer(text: 'Rome', isCorrect: false),
      Answer(text: 'Madrid', isCorrect: false),
    ],
  ),
  Question(
    text: "What is the capital of Austria",
    answers: [
      Answer(text: 'Berlin', isCorrect: false),
      Answer(text: 'Paris', isCorrect: false),
      Answer(text: 'Vienna', isCorrect: true),
      Answer(text: 'Madrid', isCorrect: false),
    ],
  ),
];
