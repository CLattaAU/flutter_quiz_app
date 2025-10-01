import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/data/sample_questions.dart';
import 'package:flutter_quiz_app/models/answer.dart';
import 'package:flutter_quiz_app/models/question.dart';
import 'package:flutter_quiz_app/pages/results_page.dart';
import 'package:flutter_quiz_app/widgets/answer_button.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int questionIndex = 0;
  int score = 0;
  List<Answer> answers = [];
  Question? question;

  void _handleAnswerSelected(bool isCorrect) {
    if (isCorrect) {
      setState(() {
        score++;
      });
    }

    if (questionIndex + 1 < questions.length) {
      setState(() {
        questionIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultsPage(score: score, onRestart: _restartQuiz),
        ),
      );
    }
  }

  void _restartQuiz() {
    setState(() {
      score = 0;
      questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.flutter_dash),
        title: Text(
          'Quiz App Question: ${questionIndex + 1} of ${questions.length}',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              questions[questionIndex].text,
              textAlign: TextAlign.left,
              style: TextStyle(),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.separated(
                itemCount: questions[questionIndex].answers.length,
                itemBuilder: (context, index) => AnswerButton(
                  onTap: () => _handleAnswerSelected(
                    questions[questionIndex].answers[index].isCorrect,
                  ),
                  text: questions[questionIndex].answers[index].text,
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
