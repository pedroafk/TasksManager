import 'package:flutter/material.dart';

class TaskDescriptionField extends StatelessWidget {
  final TextEditingController controller;
  const TaskDescriptionField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
    );
  }
}
