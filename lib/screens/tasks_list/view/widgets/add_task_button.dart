import 'package:flutter/material.dart';
import '../../view/task_form_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/tasks_bloc.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      tooltip: 'Add Task',
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TaskFormView()),
        );
        if (!context.mounted) return;
        context.read<TasksBloc>().add(LoadTasks());
      },
    );
  }
}
