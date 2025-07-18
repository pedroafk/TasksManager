import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/tasks_bloc.dart';

class TasksFilterField extends StatelessWidget {
  final TextEditingController controller;
  const TasksFilterField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Filtrar tarefas',
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          context.read<TasksBloc>().add(FilterTasks(value));
        },
      ),
    );
  }
}
