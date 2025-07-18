import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../bloc/tasks_bloc.dart';
import '../../model/task_model.dart';

class TasksFilterField extends StatelessWidget {
  final TextEditingController controller;
  const TasksFilterField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TasksBloc, TasksState>(
          builder: (context, state) {
            final List<TaskModel> tasks = state is TasksLoaded
                ? state.tasks
                : [];
            return TypeAheadField<TaskModel>(
              controller: controller,
              builder: (context, textEditingController, focusNode) {
                return TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    labelText: 'Filtrar tarefas',
                    prefixIcon: Icon(Icons.search),
                  ),
                );
              },
              suggestionsCallback: (pattern) {
                if (pattern.isEmpty) return [];
                final filtered = tasks
                    .where(
                      (task) =>
                          task.title.toLowerCase().contains(
                            pattern.toLowerCase(),
                          ) ||
                          task.description.toLowerCase().contains(
                            pattern.toLowerCase(),
                          ) ||
                          task.categoryId.toLowerCase().contains(
                            pattern.toLowerCase(),
                          ) ||
                          task.status.toLowerCase().contains(
                            pattern.toLowerCase(),
                          ),
                    )
                    .toList();
                return filtered;
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion.title),
                  subtitle: Text(
                    '${suggestion.categoryId} - ${suggestion.status}',
                  ),
                );
              },
              onSelected: (TaskModel suggestion) {
                controller.text = suggestion.title;
                context.read<TasksBloc>().add(FilterTasks(suggestion.title));
                FocusScope.of(context).unfocus();
              },
              emptyBuilder: (context) => const SizedBox(
                height: 50,
                child: Center(child: Text('Nenhuma tarefa encontrada')),
              ),
            );
          },
        ),
      ),
    );
  }
}
