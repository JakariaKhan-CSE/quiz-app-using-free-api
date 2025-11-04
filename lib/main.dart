// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quiz_app/injection_container.dart' as di;

import 'feature/quiz/data/model/question_model.dart';
import 'feature/quiz/presentation/bloc/quiz_bloc.dart';
import 'feature/quiz/presentation/bloc/quiz_event.dart';
import 'feature/quiz/presentation/pages/quiz_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(QuestionModelAdapter());
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuizBloc>(create: (context) => di.sl<QuizBloc>()..add(LoadQuizEvent()),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const QuizPage(),
        ),
      );
  }
}
