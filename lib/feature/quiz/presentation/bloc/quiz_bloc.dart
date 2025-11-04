import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/feature/quiz/domain/usecase/get_quiz_questions.dart';
import 'package:quiz_app/feature/quiz/presentation/bloc/quiz_event.dart';
import 'package:quiz_app/feature/quiz/presentation/bloc/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState>{
  final GetQuizQuestions getQuizQuestions;
  
  QuizBloc({required this.getQuizQuestions}) : super(QuizInitial()){
    on<LoadQuizEvent>(_onLoadQuiz);
    on<AnswerQuestionEvent>(_onAnswerQuestion);
    on<NextQuestionEvent>(_onNextQuestion);
  }
  
  Future<void> _onLoadQuiz(LoadQuizEvent event, Emitter<QuizState> emit)async{
    emit(QuizLoading());
    final result = await getQuizQuestions(NoParams());
    result.fold((failure) => emit(QuizError(failure.message)),
        (questions) => emit(QuizLoaded(
            questions: questions,
            currentIndex: 0,
            score: 0,
        selectedAnswer: null
        )),);
  }

  void _onAnswerQuestion(AnswerQuestionEvent event, Emitter<QuizState> emit){
    if(state is QuizLoaded)
      {
        final currentState = state as QuizLoaded;
        emit(currentState.copyWith(selectedAnswer: event.answer));
      }
  }
  Future<void> _onNextQuestion(NextQuestionEvent event, Emitter<QuizState> emit)async{
    if(state is QuizLoaded){
      final currentState = state as QuizLoaded;
      int newScore = currentState.score;
      if(currentState.selectedAnswer == currentState.questions[currentState.currentIndex].correctAnswer){
        newScore++;
      }
      int newIndex = currentState.currentIndex + 1;
      if(newIndex < currentState.questions.length)
        {
          emit(currentState.copyWith(
            currentIndex: newIndex,
            score: newScore,
            selectedAnswer: null
          ));
        }
      else{
        emit(QuizFinished(score: newScore, total: currentState.questions.length));
      }
    }
  }
}