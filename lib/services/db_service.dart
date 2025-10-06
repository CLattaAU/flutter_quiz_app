import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_quiz_app/models/question.dart';
import 'package:flutter_quiz_app/models/answer.dart';

class DBService {
  static Future<Database> initDB() async {
    // get the path for quiz.db
    final dbPath = await getDatabasesPath();
    // print("dbPath: $dbPath");
    final path = join(dbPath, 'quiz.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // QUESTIONS table
        await db.execute('''
          CREATE TABLE questions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            text TEXT
          )
        ''');

        // ANSWERS table
        await db.execute('''
          CREATE TABLE answers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            questionId INTEGER,
            text TEXT,
            isCorrect INTEGER,
            FOREIGN KEY (questionId) REFERENCES questions (id)
          )
        ''');

        // ACTIVITY_LOG table
        await db.execute('''
          CREATE TABLE activity_log (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            questionId INTEGER,
            selectedAnswerId INTEGER,
            wasCorrect INTEGER,
            timestamp TEXT,
            FOREIGN KEY (questionId) REFERENCES questions (id),
            FOREIGN KEY (selectedAnswerId) REFERENCES answers (id)
          )
        ''');

        // print("Seeding database");
        await seedDatabase(db);
      },
    );
  }

  static Future<int> insertQuestion(Question question) async {
    final db = await DBService.initDB();
    return await db.insert(
      'questions',
      question.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> seedDatabase(Database db) async {
    final data = await rootBundle.loadString('assets/questions.json');
    final List<dynamic> jsonData = jsonDecode(data);

    for (var q in jsonData) {
      int qId = await db.insert('questions', {'text': q['text']});

      for (var a in q['answers']) {
        await db.insert('answers', {
          'questionId': qId,
          'text': a['text'],
          'isCorrect': a['isCorrect'] ? 1 : 0,
        });
      }
    }
  }

  static Future<List<Question>> getQuestions() async {
    final db = await DBService.initDB();
    final List<Map<String, dynamic>> maps = await db.query('questions');

    return List.generate(maps.length, (i) {
      return Question.fromMap(maps[i]);
    });
  }

  static Future<List<Answer>> getAnswersForQuestion(int questionId) async {
    final db = await DBService.initDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'answers',
      where: 'questionId = ?',
      whereArgs: [questionId],
    );

    return List.generate(maps.length, (i) {
      return Answer.fromMap(maps[i]);
    });
  }
}
