import 'package:flutter/material.dart';

class CategoryAddField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;

  const CategoryAddField({
    super.key,
    required this.controller,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'New Category'),
          ),
        ),
        IconButton(icon: const Icon(Icons.add), onPressed: onAdd),
      ],
    );
  }
}
