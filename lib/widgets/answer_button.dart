import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({super.key, required this.onTap, required this.text});

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onTap, child: Text(text));
  }
}
