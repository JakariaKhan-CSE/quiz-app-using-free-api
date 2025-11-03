import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/core/error/failure.dart';
import 'package:quiz_app/feature/quiz/data/model/question_model.dart';

abstract class QuizRemoteDataSource{
  Future<List<QuestionModel>> getQuizQuestions();
}

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource{
  final http.Client client;
  QuizRemoteDataSourceImpl({required this.client});
  
  @override
  Future<List<QuestionModel>> getQuizQuestions()async{
    final response = await client.get(Uri.parse('https://opentdb.com/api.php?amount=10&type=multiple'),);
    if(response.statusCode == 200)
      {
        final jsonMap = json.decode(response.body);
        if(jsonMap['response_code']==0)
          {
            return (jsonMap['results']as List).map((item) => QuestionModel.fromJson(item),).toList();
          }
        else{
          throw ServerFailure('API response code: ${jsonMap['response_code']}');
        }
      }
    else{
      throw ServerFailure('Server error: ${response.statusCode}');
    }
  }
}