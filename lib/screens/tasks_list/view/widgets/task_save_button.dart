import 'package:flutter/material.dart';

class TaskSaveButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const TaskSaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.save),
        label: const Text('Save Task'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
