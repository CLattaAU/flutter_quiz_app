class Answer {
  final int? id;
  final int questionId;
  final String text;
  final bool isCorrect;

  const Answer({
    this.id,
    required this.questionId,
    required this.text,
    required this.isCorrect,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'questionId': questionId,
      'text': text,
      'isCorrect': isCorrect,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      id: map['id'],
      questionId: map['questionId'],
      text: map['text'],
      isCorrect: map['isCorrect'],
    );
  }

  factory Answer.fromJson(Map<String, dynamic> json, questionId) {
    return Answer(
      questionId: json['questionId'],
      text: json['text'],
      isCorrect: json['isCorrect'] ?? false,
    );
  }
}
