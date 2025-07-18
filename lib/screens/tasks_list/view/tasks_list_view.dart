import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/tasks_bloc.dart';
import 'task_form_view.dart';

class TasksListView extends StatefulWidget {
  const TasksListView({super.key});

  @override
  State<TasksListView> createState() => _TasksListViewState();
}

class _TasksListViewState extends State<TasksListView> {
  final _filterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TaskFormView()),
              );
              if (!mounted) return;
              // ignore: use_build_context_synchronously
              context.read<TasksBloc>().add(LoadTasks());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _filterController,
              decoration: const InputDecoration(
                labelText: 'Filtrar tarefas',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                context.read<TasksBloc>().add(FilterTasks(value));
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                if (state is TasksLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is TasksLoaded) {
                  if (state.tasks.isEmpty) {
                    return const Center(
                      child: Text('Nenhuma tarefa encontrada.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final task = state.tasks[index];
                      return ListTile(
                        title: Text("${task.status} - ${task.title}"),
                        subtitle: Text(task.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                context.read<TasksBloc>().add(
                                  DeleteTask(task.id),
                                );
                              },
                            ),
                          ],
                        ),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TaskFormView(task: task),
                            ),
                          );
                          if (!mounted) return;
                          // ignore: use_build_context_synchronously
                          context.read<TasksBloc>().add(LoadTasks());
                        },
                      );
                    },
                  );
                }
                return const Center(child: Text('Erro ao carregar tarefas.'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
