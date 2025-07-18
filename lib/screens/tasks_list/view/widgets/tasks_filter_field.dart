import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tasks_manager/screens/tasks_list/view/task_form_view.dart';
import '../../bloc/tasks_bloc.dart';
import '../../bloc/categories_bloc.dart';
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
            return BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, catState) {
                final Map<String, String> categoryNames =
                    catState is CategoriesLoaded
                    ? {
                        for (var cat in catState.categories)
                          cat['id'] as String: cat['name'] as String,
                      }
                    : {};

                return TypeAheadField<TaskModel>(
                  controller: controller,
                  builder: (context, textEditingController, focusNode) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: const InputDecoration(
                        labelText: 'Search Tasks',
                        prefixIcon: Icon(Icons.search),
                      ),
                    );
                  },
                  suggestionsCallback: (pattern) {
                    if (pattern.isEmpty) return [];
                    return tasks
                        .where(
                          (task) =>
                              task.title.toLowerCase().contains(
                                pattern.toLowerCase(),
                              ) ||
                              task.description.toLowerCase().contains(
                                pattern.toLowerCase(),
                              ) ||
                              (categoryNames[task.categoryId]?.toLowerCase() ??
                                      '')
                                  .contains(pattern.toLowerCase()) ||
                              task.status.toLowerCase().contains(
                                pattern.toLowerCase(),
                              ),
                        )
                        .toList();
                  },
                  itemBuilder: (context, suggestion) {
                    final categoryName =
                        categoryNames[suggestion.categoryId] ??
                        suggestion.categoryId;
                    return ListTile(
                      title: Text(suggestion.title),
                      subtitle: Text('$categoryName - ${suggestion.status}'),
                    );
                  },
                  onSelected: (TaskModel suggestion) {
                    controller.text = suggestion.title;
                    FocusScope.of(context).unfocus();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TaskFormView(task: suggestion),
                      ),
                    );
                  },
                  emptyBuilder: (context) => const SizedBox(
                    height: 50,
                    child: Center(child: Text('No tasks found')),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
