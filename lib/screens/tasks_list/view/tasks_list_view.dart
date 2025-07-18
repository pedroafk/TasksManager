import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return BlocProvider(
      create: (_) => TasksBloc(userId)..add(LoadTasks()),
      child: Scaffold(
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
                          title: Text(task.title),
                          subtitle: Text(task.description),
                          trailing: Text(task.status),
                          onTap: () {
                            // Editar tarefa
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
      ),
    );
  }
}
