import 'package:flutter/material.dart';
import 'package:quiz_app_ramya/screens/questions_summary.dart';
import '../data/questions.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    Key? key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final void Function() onRestart;
  final List<String> chosenAnswers;

  List<Map<String, Object>> summaryData() {
    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData()
        .where((data) => data['user_answer'] == data['correct_answer'])
        .length;

    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center children vertically
            children: [
              Text(
                'You Answered $numCorrectQuestions out of $numTotalQuestions questions correctly',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              QuestionsSummary(summaryData()),
              const SizedBox(
                height: 30,
              ),
              TextButton.icon(
                onPressed: onRestart,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                ),
                icon: const Icon(Icons.refresh),
                label: const Text("Restart Quiz"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
