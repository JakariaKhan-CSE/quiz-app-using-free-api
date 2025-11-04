import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/feature/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:quiz_app/feature/quiz/presentation/bloc/quiz_event.dart';
import 'package:quiz_app/feature/quiz/presentation/bloc/quiz_state.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz App')),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is QuizLoaded) {
            final question = state.questions[state.currentIndex];
            final answer = [
              ...question.incorrectAnswers,
              question.correctAnswer,
            ];
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${state.currentIndex + 1}/${state.questions.length}',
                  ),
                  const SizedBox(height: 16),
                  Text(question.question, style: TextStyle(fontSize: 18)),
                  const SizedBox(height: 16),
                  ...answer.map(
                    (answer) => RadioListTile(
                      value: answer,
                      title: Text(answer),
                      groupValue: state.selectedAnswer,
                      onChanged: (value) {
                        BlocProvider.of<QuizBloc>(
                          context,
                        ).add(AnswerQuestionEvent(value!));
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: state.selectedAnswer != null
                        ? () => BlocProvider.of<QuizBloc>(
                            context,
                          ).add(NextQuestionEvent())
                        : null,
                    child: const Text('Next'),
                  ),
                ],
              ),
            );
          }
          else if(state is QuizFinished){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Quiz Finished! Score: ${state.score}/${state.total}'),
                  ElevatedButton(onPressed: () => BlocProvider.of<QuizBloc>(context).add(LoadQuizEvent()), child: Text('Restart'))
                ],
              ),
            );
          }
          else if(state is QuizError)
            {
              return Center(child: Text('Error: ${state.message}'),);
            }
          return const Center(
            child: Text('Press start to begin'),
          );
        },
      ),
    );
  }
}
