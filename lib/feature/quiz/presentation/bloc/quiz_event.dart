import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable{
  const QuizEvent();
  @override
  List<Object> get props => [];
}

class LoadQuizEvent extends QuizEvent {}

class AnswerQuestionEvent extends QuizEvent{
  final String answer;
  const AnswerQuestionEvent(this.answer);

  @override
  List<Object> get props => [answer];
}

class NextQuestionEvent extends QuizEvent {}