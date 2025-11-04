import 'package:hive/hive.dart';
import 'package:quiz_app/feature/quiz/domain/entities/question.dart';

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
  final String correctedAnswer;

  @HiveField(5)
  final List<String> incorrectAnswers;

  QuestionModel({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctedAnswer,
    required this.incorrectAnswers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      category: json['category'],
      type: json['type'],
      difficulty: json['difficulty'],
      question: json['question'],
      correctedAnswer: json['correctedAnswer'],
      incorrectAnswers: List<String>.from(json['incorrectAnswers']),
    );
  }
  Question toEntity() {
    return Question(
      category: category,
      type: type,
      difficulty: difficulty,
      question: question,
      correctAnswer: correctedAnswer,
      incorrectAnswers: incorrectAnswers,
    );
  }
}

// @HiveType(typeId: 1)
// class Question extends HiveObject {
//   @HiveField(0)
//   String category;
//
//   @HiveField(1)
//   String type;
//
//   @HiveField(2)
//   String difficulty;
//
//   @HiveField(3)
//   String question;
//
//   @HiveField(4)
//   String correctAnswer;
//
//   @HiveField(5)
//   List<String> incorrectAnswers;
//
//   Question({
//     required this.category,
//     required this.type,
//     required this.difficulty,
//     required this.question,
//     required this.correctAnswer,
//     required this.incorrectAnswers,
//   });
// }