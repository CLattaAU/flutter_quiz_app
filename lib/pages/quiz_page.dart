import 'package:flutter/material.dart';
// import 'package:flutter_quiz_app/data/sample_questions.dart';
import 'package:flutter_quiz_app/models/answer.dart';
import 'package:flutter_quiz_app/models/question.dart';
import 'package:flutter_quiz_app/pages/results_page.dart';
import 'package:flutter_quiz_app/services/db_service.dart';
import 'package:flutter_quiz_app/widgets/answer_button.dart';
import 'package:flutter_quiz_app/pages/recent_attempts_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> _questions = [];
  List<Answer> _currentAnswers = [];

  int _currentIndex = 0;
  int _currentScore = 0;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final questions = await DBService.getQuestions();

    if (questions.isNotEmpty) {
      final answers = await DBService.getAnswersForQuestion(questions[0].id!);
      setState(() {
        _questions = questions;
        _currentAnswers = answers;
      });
    }
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _currentScore = 0;
    });
    _loadQuestions();
  }

  void _nextQuestion(bool isCorrect) async {
    if (isCorrect) {
      setState(() {
        _currentScore++;
      });
    }
    if (_currentIndex + 1 < _questions.length) {
      final nextIndex = _currentIndex + 1;
      final answers = await DBService.getAnswersForQuestion(
        _questions[nextIndex].id!,
      );

      setState(() {
        _currentIndex = nextIndex;
        _currentAnswers = answers;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultsPage(
            score: _currentScore,
            // total: _questions.length,
            onRestart: _restartQuiz, // pass restart callback if you want
          ),
        ),
      );
    }
  }

  void _handleAnswerTap(Answer answer) async {
    final question = _questions[_currentIndex];

    // Log the answer
    await DBService.logAnswer(
      questionId: question.id!,
      selectedAnswerId: answer.id!,
      wasCorrect: answer.isCorrect,
    );

    _nextQuestion(answer.isCorrect);
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.flutter_dash,
          size: 40.0,
          color: const Color.fromARGB(255, 20, 113, 189),
        ),
        title: Text(
          'Quiz App Question: ${_currentIndex + 1} of ${_questions.length}',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.history),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RecentAttemptsPage()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              _questions[_currentIndex].text,
              textAlign: TextAlign.left,
              style: TextStyle(),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.separated(
                itemCount: _currentAnswers.length,
                itemBuilder: (context, index) => AnswerButton(
                  onTap: () => _handleAnswerTap(_currentAnswers[index]),
                  text: _currentAnswers[index].text,
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
