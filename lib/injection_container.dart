import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/feature/quiz/data/data_source/quiz_local_data_source.dart';
import 'package:quiz_app/feature/quiz/data/data_source/quiz_remote_data_source.dart';
import 'package:quiz_app/feature/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:quiz_app/feature/quiz/domain/repositories/quiz_repositories.dart';
import 'package:quiz_app/feature/quiz/domain/usecase/get_quiz_questions.dart';
import 'package:quiz_app/feature/quiz/presentation/bloc/quiz_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => QuizBloc(getQuizQuestions: sl()));

  // Use case
  sl.registerLazySingleton(() => GetQuizQuestions(sl()));

  // Repository
  sl.registerLazySingleton<QuizRepository>(
    () => QuizReposiotryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      connectivity: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<QuizRemoteDataSource>(() => QuizRemoteDataSourceImpl(client: sl()),);

  sl.registerLazySingleton<QuizLocalDataSource>(() => QuizLocalDataSourceImpl(),);

  // Core
  sl.registerLazySingleton(() => http.Client(),);
  sl.registerLazySingleton(() => Connectivity(),);
}
