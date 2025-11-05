import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/feature/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:quiz_app/feature/quiz/presentation/bloc/quiz_event.dart';
import 'package:quiz_app/feature/quiz/presentation/bloc/quiz_state.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a color scheme for attractiveness
    final primaryColor = Colors.blueAccent;
    final accentColor = Colors.orangeAccent;
    final backgroundColor = Colors.grey[100];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Master'),
        backgroundColor: primaryColor,
        elevation: 4,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [backgroundColor!, Colors.white],
          ),
        ),
        child: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is QuizLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuizLoaded) {
              final question = state.questions[state.currentIndex];
              // Shuffle answers for better UX
              final answers = [
                ...question.incorrectAnswers,
                question.correctAnswer,
              ]..shuffle();

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Progress indicator
                    LinearProgressIndicator(
                      value: (state.currentIndex + 1) / state.questions.length,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Question ${state.currentIndex + 1}/${state.questions.length}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          question.question,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView.builder(
                        itemCount: answers.length,
                        itemBuilder: (context, index) {
                          final answer = answers[index];
                          return RadioListTile<String>(
                            value: answer,
                            groupValue: state.selectedAnswer,
                            onChanged: (value) {
                              BlocProvider.of<QuizBloc>(context)
                                  .add(AnswerQuestionEvent(value!));
                            },
                            title: Text(answer),
                            activeColor: primaryColor,
                            tileColor: state.selectedAnswer == answer
                                ? primaryColor.withOpacity(0.1)
                                : null,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: state.selectedAnswer != null
                          ? () => BlocProvider.of<QuizBloc>(context)
                          .add(NextQuestionEvent())
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is QuizFinished) {
              return Center(
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 64,
                          color: accentColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Quiz Finished!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Score: ${state.score}/${state.total}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () => BlocProvider.of<QuizBloc>(context)
                              .add(LoadQuizEvent()),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Restart',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is QuizError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
              );
            }
            return const Center(
              child: Text('Press start to begin'),
            );
          },
        ),
      ),
    );
  }
}