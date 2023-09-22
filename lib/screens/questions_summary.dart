import 'package:flutter/material.dart';

class QuestionsSummary extends StatelessWidget {
  final List<Map<String, Object>> summaryData;

  QuestionsSummary(this.summaryData);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Questions Summary:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        for (final data in summaryData)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Question: ${data['question']}'),
              Text(
                'Correct Answer: ${data['correct_answer']}',
                style: TextStyle(
                  color: data['correct_answer'] == data['user_answer']
                      ? Colors.green
                      : Colors.green,
                ),
              ),
              Text(
                'Your Answer: ${data['user_answer']}',
                style: TextStyle(
                  color: data['correct_answer'] == data['user_answer']
                      ? Colors.green
                      : Colors.red,
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
      ],
    );
  }
}
