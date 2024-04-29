import 'package:chat_bubbles/algo/algo.dart';
import 'package:flutter/material.dart';

/// Extracted and modified from chat bubble package
class KMyDateChip extends StatelessWidget {
  final DateTime date;
  final Color color;

  const KMyDateChip({
    super.key,
    required this.date,
    this.color = const Color(0x558AD3D5),
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 7,
          bottom: 7,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              Algo.dateChipText(date),
              style: TextStyle(
                color: Theme.of(context).colorScheme.background,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
