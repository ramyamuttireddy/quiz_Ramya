import 'package:flutter/material.dart';

import 'package:quiz_app_ramya/questions_summary/questions_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer =
        itemData['user_answer'] == itemData['correct_answer'];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionIdentifier(
          isCorrectAnswer: isCorrectAnswer,
          questionIndex: itemData['question_index'] as int,
        ),
        const SizedBox(
          width: 20,
        ),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(itemData['question'] as String,
           
            ),
            const SizedBox(
              height: 10,
            ),
            Text(itemData['user_answer'] as String,
            style: const TextStyle(
              color: Color.fromARGB(255, 168, 101, 96),
            )),
            Text(itemData['correct_answer'] as String,
            style: const TextStyle(
              color: Color.fromARGB(255, 96, 163, 98),
            )),
          ],
          ),
          ),

      ],
    );
  }
}
