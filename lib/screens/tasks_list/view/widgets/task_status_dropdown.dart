import 'package:flutter/material.dart';

class TaskStatusDropdown extends StatelessWidget {
  final String selectedStatus;
  final ValueChanged<String?> onChanged;

  const TaskStatusDropdown({
    super.key,
    required this.selectedStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedStatus,
      decoration: const InputDecoration(
        labelText: 'Status',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: 'To do', child: Text('To do')),
        DropdownMenuItem(value: 'In Progress', child: Text('In Progress')),
        DropdownMenuItem(value: 'Done', child: Text('Done')),
      ],
      onChanged: onChanged,
    );
  }
}
