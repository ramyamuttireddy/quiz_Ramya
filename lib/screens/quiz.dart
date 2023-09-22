import 'package:flutter/material.dart';
import 'package:quiz_app_ramya/screens/question_screen.dart';
import 'package:quiz_app_ramya/screens/results_screen.dart';
import 'package:quiz_app_ramya/screens/start_screen.dart';

import '../data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswer = [];
  var activeScreen = 'start-screen';
  var answersShuffled = false;


  
  List<List<String>> shuffledAnswers = List.generate(
    questions.length,
    (index) => questions[index].shuffledAnswers,
  );
  

  void switchScreen() {
    setState(() {
      if (!answersShuffled) {
      questions.forEach((question) {
        question.answers.shuffle();
      });
      answersShuffled = true;
    }
      activeScreen = 'questions-screen';
    });
  }

  void chooseAnswer(String answer) {
    if (!answersShuffled) {
      questions.forEach((question) {
        question.answers.shuffle();
      });
      answersShuffled = true;
    }
    selectedAnswer.add(answer);
    if (selectedAnswer.length == questions.length) {
      setState(() {
        activeScreen = "results-screen";
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswer = [];
      answersShuffled = false; // Reset the shuffle flag
      activeScreen = 'start-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidget = activeScreen == 'start-screen'
        ? StartScreen(switchScreen)
        : QuestionScreen(
            onSelectAnswer: chooseAnswer,
          );

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswer,
        onRestart: restartQuiz,
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 211, 150, 132),
                Color.fromARGB(255, 215, 204, 203),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: screenWidget,
        ),
      ),
    );
  }
}
