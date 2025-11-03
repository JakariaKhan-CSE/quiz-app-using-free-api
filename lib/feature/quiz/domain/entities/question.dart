import 'package:equatable/equatable.dart';

class Question extends Equatable{

  String category;

  String type;

  String difficulty;

  String question;

  String correctAnswer;

  List<String> incorrectAnswers;

  Question({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  @override
  List<Object> get props => [category, type, difficulty, question, correctAnswer, incorrectAnswers];
}