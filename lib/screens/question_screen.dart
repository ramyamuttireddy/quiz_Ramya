
import 'package:flutter/material.dart';
import 'package:quiz_app_ramya/screens/questions_summary.dart';
import 'package:quiz_app_ramya/screens/quiz.dart';
import 'package:quiz_app_ramya/screens/results_screen.dart';
import '../data/questions.dart';
import 'answers_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key, required void Function(String answer) onSelectAnswer});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  List<String?> selectedAnswers = List.generate(questions.length, (_) => null);
  int attemptsLeft = 3; 
  int currentAttempt = 0; 

  void loadQuestion(int questionIndex) {
    setState(() {
      currentQuestionIndex = questionIndex;
      attemptsLeft = 3; 
      currentAttempt = 0; 
      
    });
  }

  void answerQuestion(String? answer) {
  setState(() {
    if (attemptsLeft > 0) {
      selectedAnswers[currentQuestionIndex] = answer;
      attemptsLeft--;
      currentAttempt++;

      
      if (currentAttempt == 3) {
       
        if (currentQuestionIndex < questions.length - 1) {
          loadQuestion(currentQuestionIndex + 1);
        } else {
         
          Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ResultsScreen(
                chosenAnswers: selectedAnswers.where((answer) => answer != null).cast<String>().toList(), onRestart: () { selectedAnswers; },
              ),
            ),
          );
        }
      }
    }
  });
}


void next() {
  if (currentQuestionIndex < questions.length - 1) {
    loadQuestion(currentQuestionIndex + 1);
  } else {
   
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ResultsScreen(
          chosenAnswers: selectedAnswers.where((answer) => answer != null).cast<String>().toList(),
          onRestart: () {
           Navigator.push<void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => Quiz(),
              
            ),
          );
          },
        ),
      ),
    );
  }
}

  void previous() {
    if (currentQuestionIndex > 0) {
      loadQuestion(currentQuestionIndex - 1);
    } else {
      // Navigate to the previous screen or handle navigation as needed
    }
  }

 // Add a boolean flag to check if it's the last question
bool get isLastQuestion => currentQuestionIndex == questions.length - 1;

// ...

@override
Widget build(BuildContext context) {
  final currentQuestion = questions[currentQuestionIndex];

  return SizedBox(
    width: double.infinity,
    child: Container(
      margin: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            currentQuestion.text,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          ...currentQuestion.answers.map((answer) {
            final isSelected = selectedAnswers[currentQuestionIndex] == answer;
            return AnswerButton(
              answerText: answer,
              selected: isSelected,
              onTap: () {
                answerQuestion(answer);
              },
            );
          }),
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Display Previous button for all questions
                ElevatedButton(
                  onPressed: () {
                    previous();
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        size: 15,
                      ),
                      Text('Previous'),
                    ],
                  ),
                ),
                // Conditionally display Submit or Next button
                if (isLastQuestion)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => ResultsScreen(
                            chosenAnswers: selectedAnswers.where((answer) => answer != null).cast<String>().toList(),
                            onRestart: () {
                              selectedAnswers;
                            },
                          ),
                        ),
                      );
                    },
                    child: const Text('Submit'),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      next();
                    },
                    child: const Row(
                      children: [
                        Text('Next'),
                        Icon(
                          Icons.arrow_forward,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                Text('Attempts Left: $attemptsLeft'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}