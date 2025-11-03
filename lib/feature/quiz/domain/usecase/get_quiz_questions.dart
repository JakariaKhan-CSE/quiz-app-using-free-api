import 'package:dartz/dartz.dart';
import 'package:quiz_app/core/usecase/usecase.dart';
import 'package:quiz_app/feature/quiz/domain/entities/question.dart';
import 'package:quiz_app/feature/quiz/domain/repositories/quiz_repositories.dart';

import '../../../../core/error/failure.dart';

class GetQuizQuestions extends UseCase<List<Question>, NoParams>{
  final QuizRepository repository;

  GetQuizQuestions(this.repository);
  @override
  Future<Either<Failure, List<Question>>> call(NoParams params) {
  return repository.getQuizQuestions();
  }

}

class NoParams{}