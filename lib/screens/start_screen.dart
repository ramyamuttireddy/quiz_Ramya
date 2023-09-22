import 'package:flutter/material.dart';


class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz, {super.key});
  final void Function() startQuiz;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
         const SizedBox(height: 40),
        Text(
          "Quiz App",
        ),
        const SizedBox(height: 30),
        OutlinedButton.icon(
          onPressed: startQuiz,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
          ),
          icon:const Icon(Icons.arrow_right_alt),
          label: const Text("start quiz"),
        ),
      ],
    ));
  }
}
