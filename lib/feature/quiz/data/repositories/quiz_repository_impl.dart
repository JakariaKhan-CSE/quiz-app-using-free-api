import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:quiz_app/feature/quiz/data/data_source/quiz_local_data_source.dart';
import 'package:quiz_app/feature/quiz/data/data_source/quiz_remote_data_source.dart';
import 'package:quiz_app/feature/quiz/domain/repositories/quiz_repositories.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/question.dart';
import '../model/question_model.dart';

class QuizReposiotryImpl implements QuizRepository {
  final QuizRemoteDataSource remoteDataSource;
  final QuizLocalDataSource localDataSource;
  final Connectivity connectivity;

  QuizReposiotryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
  });
  @override
  Future<Either<Failure, List<Question>>> getQuizQuestions() async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      try {
        final remoteQuestions = await remoteDataSource.getQuizQuestions();
        await localDataSource.cacheQuizQuestions(
          remoteQuestions,
        ); // save on cache when fetch from remote
        return Right(remoteQuestions.map((model) => model.toEntity()).toList());
      } on ServerFailure catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      try {
        final localQuestions = await localDataSource.getCachedQuizQuestions();
        return Right(localQuestions.map((model) => model.toEntity()).toList());
      } on CacheFailure catch (e) {
        return Left(CacheFailure(e.message));
      } catch (e) {
        return Left(NetworkFailure());
      }
    }
  }
}