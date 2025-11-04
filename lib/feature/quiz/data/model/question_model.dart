// lib/features/quiz/data/models/question_model.dart
import 'package:hive/hive.dart';

import '../../domain/entities/question.dart';

part 'question_model.g.dart';

@HiveType(typeId: 0)
class QuestionModel extends HiveObject {
  @HiveField(0)
  final String category;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final String difficulty;

  @HiveField(3)
  final String question;

  @HiveField(4)
  final String correctAnswer;

  @HiveField(5)
  final List<String> incorrectAnswers;

  QuestionModel({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      category: json['category'],
      type: json['type'],
      difficulty: json['difficulty'],
      question: json['question'],
      correctAnswer: json['correct_answer'],
      incorrectAnswers: List<String>.from(json['incorrect_answers']),
    );
  }

  Question toEntity() {
    return Question(
      category: category,
      type: type,
      difficulty: difficulty,
      question: question,
      correctAnswer: correctAnswer,
      incorrectAnswers: incorrectAnswers,
    );
  }
}