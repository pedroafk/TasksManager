import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_manager/screens/tasks_list/model/task_model.dart';
import '../../bloc/tasks_bloc.dart';
import '../task_form_view.dart';

class TaskListTile extends StatelessWidget {
  final TaskModel task;
  const TaskListTile({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${task.status} - ${task.title}"),
      subtitle: Text(task.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              context.read<TasksBloc>().add(DeleteTask(task.id));
            },
          ),
        ],
      ),
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TaskFormView(task: task)),
        );
        if (!context.mounted) return;
        context.read<TasksBloc>().add(LoadTasks());
      },
    );
  }
}
