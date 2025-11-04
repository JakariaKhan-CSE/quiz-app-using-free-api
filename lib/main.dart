import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quiz_app/feature/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:quiz_app/feature/quiz/presentation/bloc/quiz_event.dart';
import 'package:quiz_app/feature/quiz/presentation/pages/quiz_page.dart';

import 'feature/quiz/data/model/question_model.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(QuestionModelAdapter());
 // Hive.registerAdapter(QuestionAdapter());
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => di.sl<QuizBloc>()..add(LoadQuizEvent()),
        child: const QuizPage(),
      ),
    );
  }
}
