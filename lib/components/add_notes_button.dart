import 'package:flutter/material.dart';
import 'package:myapp/constants/k_my_text.dart';

class AddNotes extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final IconData icon;
  const AddNotes({
    super.key,
    required this.onTap,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        side: BorderSide.none,
        label: KMyText(label),
        deleteIcon: Icon(icon),
        onDeleted: onTap,
        deleteButtonTooltipMessage: '',
      ),
    );
  }
}
