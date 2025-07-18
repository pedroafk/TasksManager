import 'package:flutter/material.dart';

class TaskDueDateTile extends StatelessWidget {
  final DateTime? dueDate;
  final ValueChanged<DateTime> onDatePicked;
  const TaskDueDateTile({
    super.key,
    required this.dueDate,
    required this.onDatePicked,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        dueDate == null
            ? 'Select Due Date'
            : 'Expires in: ${dueDate!.day}/${dueDate!.month}/${dueDate!.year}',
      ),
      trailing: const Icon(Icons.calendar_today),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
        );
        if (picked != null) onDatePicked(picked);
      },
    );
  }
}
