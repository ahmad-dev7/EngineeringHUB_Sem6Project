import 'package:flutter/material.dart';
import 'package:myapp/constants/k_my_text.dart';

class QuestionButton extends StatelessWidget {
  final String question;
  final String action;
  final Function() onTap;
  const QuestionButton({
    super.key,
    required this.question,
    required this.action,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        KMyText(question, color: Theme.of(context).hintColor),
        TextButton(
          onPressed: onTap,
          child: KMyText(
            action,
            color: Theme.of(context).colorScheme.secondary,
          ),
        )
      ],
    );
  }
}
