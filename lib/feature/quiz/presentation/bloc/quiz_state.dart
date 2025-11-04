import 'package:equatable/equatable.dart';
import 'package:quiz_app/feature/quiz/domain/entities/question.dart';

abstract class QuizState extends Equatable{
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial  extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState{
  final List<Question> questions;
  final int currentIndex;
  final int score;
  final String? selectedAnswer;

  const QuizLoaded({
    required this.questions,
    required this.currentIndex,
    required this.score,
    this.selectedAnswer,
});

  QuizLoaded copyWith({
    List<Question>? questions,
    int? currentIndex,
    int? score,
    String? selectedAnswer,
}){
    return QuizLoaded(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      score: score ?? this.score,
      selectedAnswer: selectedAnswer,
    );
}

@override
  List<Object> get props => [questions, currentIndex, score, selectedAnswer ?? ''];
}

class QuizFinished extends QuizState{
  final int score;
  final int total;

  const QuizFinished({
    required this.score,
    required this.total,
  });

  @override
  List<Object> get props => [score, total];
}

class QuizError extends QuizState{
  final String message;

  const QuizError(this.message);

  @override
  List<Object> get props => [message];
}