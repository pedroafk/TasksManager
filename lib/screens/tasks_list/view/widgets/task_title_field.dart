import 'package:flutter/material.dart';

class TaskTitleField extends StatelessWidget {
  final TextEditingController controller;
  const TaskTitleField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Title',
        border: OutlineInputBorder(),
      ),
      validator: (v) => v == null || v.isEmpty ? 'Enter the title' : null,
    );
  }
}
