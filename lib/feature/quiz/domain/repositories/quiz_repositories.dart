import 'package:dartz/dartz.dart';
import 'package:quiz_app/core/error/failure.dart';
import 'package:quiz_app/feature/quiz/domain/entities/question.dart';

abstract class QuizRepository{
  Future<Either<Failure, List<Question>>> getQuizQuestions();
}