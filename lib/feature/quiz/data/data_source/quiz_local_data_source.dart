import 'package:hive/hive.dart';
import 'package:quiz_app/core/error/failure.dart';
import 'package:quiz_app/feature/quiz/data/model/question_model.dart';

abstract class QuizLocalDataSource{
  Future<List<QuestionModel>> getCachedQuizQuestions();
  Future<void> cacheQuizQuestions(List<QuestionModel> questions);
}

class QuizLocalDataSourceImpl implements QuizLocalDataSource{
  static const String boxName = 'quiz_questions';

  Future<Box<QuestionModel>> _openBox()async{
    if(!Hive.isBoxOpen(boxName))
      {
        return await Hive.openBox<QuestionModel>(boxName);
      }
    return Hive.box<QuestionModel>(boxName);
  }
  @override
  Future<List<QuestionModel>> getCachedQuizQuestions()async{
    final box = await _openBox();
    if(box.isEmpty)
      {
        throw CacheFailure('No cached questions');
      }
    return box.values.toList();
  }
  @override
  Future<void> cacheQuizQuestions(List<QuestionModel> questions)async{
    final box = await _openBox();
    await box.clear();
    for(var question in questions){
      await box.add(question);
    }
  }
}