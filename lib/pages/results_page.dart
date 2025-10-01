import 'package:flutter/material.dart';
// import 'package:flutter_quiz_app/pages/quiz_page.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key, required this.score, required this.onRestart});

  final int score;
  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.flutter_dash),
        title: Text('Results Page'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Your Final Score: $score', style: TextStyle(fontSize: 28)),
            TextButton(
              child: Text('Restart'),
              onPressed: () {
                onRestart();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
